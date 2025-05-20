const asyncHandler = require('express-async-handler');
const { v4: uuidv4 } = require('uuid');
const sharp = require('sharp');
const bcrypt = require('bcryptjs');
const fs = require('fs');
const path = require('path');

const factory = require('./handlersFactory');
const ApiError = require('../utils/apiError');
const { uploadSingleImage } = require('../middlewares/uploadImageMiddleware');
const createToken = require('../utils/createToken');
const User = require('../models/userModel');

// Upload single image
exports.uploadUserImage = uploadSingleImage('profileImg');

// Image processing
exports.resizeImage = asyncHandler(async (req, res, next) => {
  if (!req.file) {
    return next();
  }

  try {
    console.log('🖼️ Processing image:', {
      originalname: req.file.originalname,
      path: req.file.path,
      mimetype: req.file.mimetype,
      size: req.file.size
    });

    const filename = `user-${Date.now()}.jpeg`;
    const uploadDir = path.join(__dirname, '..', 'uploads', 'users');

    // Create directory if it doesn't exist
    if (!fs.existsSync(uploadDir)) {
      await fs.promises.mkdir(uploadDir, { recursive: true });
    }

    // Read the file into a buffer
    const imageBuffer = await fs.promises.readFile(req.file.path);
    
    // Process image from buffer with optimized settings
    const processedBuffer = await sharp(imageBuffer)
      .resize(600, 600, {
        fit: 'inside',
        withoutEnlargement: true,
        fastShrinkOnLoad: true
      })
      .toFormat('jpeg', {
        quality: 80,
        progressive: true,
        optimizeScans: true
      })
      .toBuffer();

    // Save the processed buffer
    await fs.promises.writeFile(path.join(uploadDir, filename), processedBuffer);

    // Delete the original file
    await fs.promises.unlink(req.file.path);

    req.body.profileImg = filename;
    console.log('✅ Image processed and saved successfully:', {
      filename,
      path: path.join(uploadDir, filename),
      originalSize: req.file.size,
      processedSize: processedBuffer.length
    });
  } catch (error) {
    console.error('❌ Error processing image:', error);
    // Clean up the original file if it exists
    if (req.file && req.file.path) {
      try {
        await fs.promises.unlink(req.file.path);
      } catch (unlinkError) {
        console.error('Failed to clean up original file:', unlinkError);
      }
    }
    return next(new ApiError('Error processing image', 500));
  }
  next();
});

//@desc   Get list of User
//@route  GET /api/v1/Users
//@access Private/Admin
exports.getUsers = factory.getAll(User);

//@desc  Get specific User by if
//@route GET /api/v1/Users/:id
//@access Private/Admin
exports.getUser = factory.getOne(User);

//@desc   Create User
//@route  POST  /api/v1/Users
//@access Private/Admin
exports.createUser = factory.createOne(User);

//@desc    Update spacific User
//@route   Put  /api/v1/Users/:id
//@access  Private/Admin
exports.updateUser = asyncHandler(async (req, res, next) => {
  // If there's a new profile image, delete the old one
  if (req.body.profileImg) {
    const oldUser = await User.findById(req.params.id);
    if (oldUser && oldUser.profileImg) {
      const oldImagePath = path.join(__dirname, '..', 'uploads', 'users', oldUser.profileImg);
      if (fs.existsSync(oldImagePath)) {
        fs.unlinkSync(oldImagePath);
        console.log('Deleted old profile image:', oldImagePath);
      }
    }
  }

  const document = await User.findByIdAndUpdate(
    req.params.id, 
    {
      name: req.body.name,
      slug: req.body.slug,
      phone: req.body.phone,
      email: req.body.email,
      profileImg: req.body.profileImg,
      role: req.body.role,
    },
    {
      new: true,
    }
  );

  if (!document) {
    return next(
      new ApiError(`No document for this id ${req.params.id}`, 404)
    );
  }

  // Construct the full URL for the profile image
  let profileImgUrl = null;
  if (document.profileImg) {
    profileImgUrl = `${req.protocol}://${req.get('host')}/uploads/users/${document.profileImg}`;
  }

  res.status(200).json({ 
    status: 'success',
    data: {
      ...document.toObject(),
      profileImg: profileImgUrl,
    }
  });
});

exports.changeUserPassword = asyncHandler(async (req, res, next) => {
  const document = await User.findByIdAndUpdate(
    req.params.id, 
    {
      password: await bcrypt.hash(req.body.password, 12),
      passwordChangeAt: Date.now(),
    },
    {
      new: true,
    }
  );
  if (!document) {
    return next(new ApiError(`No document for this id ${req.params.id}`, 404));
  }
  res.status(200).json({ data: document });
});

exports.deleteUser = factory.deleteOne(User);

//@desc  Get logged user data
//@route GET /api/v1/users/getMe
//@access Private/Protect
exports.getLoggedUserData = asyncHandler(async (req, res, next) => {
  req.params.id = req.user._id;
  next();
});

//@desc  Update logged user password
//@route PUT /api/v1/users/updateMyPassword
//@access Private/Protect
exports.updateLoggedUserPassword = asyncHandler(async (req, res, next) => {
  const user = await User.findByIdAndUpdate(
    req.user._id, 
    {
      password: await bcrypt.hash(req.body.password, 12),
      passwordChangeAt: Date.now(),
    },
    {
      new: true,
    }
  );

  const token = createToken(user._id);
  res.status(200).json({ data: { user, token } });
});

//@desc  Update logged user data (without passwword, role)
//@route PUT /api/v1/users/updateMe
//@access Private/Protect
exports.updateLoggedUserData = asyncHandler(async (req, res, next) => {
  if (req.body.email) {
    const existingUser = await User.findOne({ email: req.body.email });
    if (existingUser && existingUser._id.toString() !== req.user._id.toString()) {
      return next(new ApiError('Email already exists', 400));
    }
  }

  const allowedFields = [
    'name', 
    'email', 
    'phone', 
    'profileImg',
    'gender',    
    'dob',
    'age',
    'address'
  ];
  
  const updateData = {};
  for (const field of allowedFields) {
    if (req.body[field] !== undefined) {
      updateData[field] = req.body[field];
    }
  }

  // If there's a new profile image, delete the old one
  if (req.body.profileImg) {
    const oldUser = await User.findById(req.user._id);
    if (oldUser && oldUser.profileImg) {
      const oldImagePath = path.join(__dirname, '..', 'uploads', 'users', oldUser.profileImg);
      if (fs.existsSync(oldImagePath)) {
        fs.unlinkSync(oldImagePath);
        console.log('Deleted old profile image:', oldImagePath);
      }
    }
  }

  const updateUser = await User.findByIdAndUpdate(
    req.user._id, 
    updateData,
    {
      new: true,
      runValidators: true,
      select: allowedFields.join(' ')
    }
  );

  let profileImgUrl = null;
  if (updateUser.profileImg) {
    profileImgUrl = `${req.protocol}://${req.get('host')}/uploads/users/${updateUser.profileImg}`;
  }

  res.status(200).json({ 
    status: 'success',
    data: {
      ...updateUser.toObject(),
      profileImg: profileImgUrl,
    }
  });
});

// @desc    Upload user profile image only
// @route   POST /api/v1/users/uploadPhoto
// @access  Private
exports.uploadUserPhotoHandler = async (req, res, next) => {
  try {
    console.log('=== Upload Handler Debug ===');
    console.log('req.file:', req.file);
    console.log('req.body:', req.body);

    if (!req.file) {
      console.log('No file in request');
      return res.status(400).json({ 
        status: 'fail', 
        message: 'No file uploaded' 
      });
    }

    const profileImg = req.file.filename;
    const profileImgUrl = `${req.protocol}://${req.get('host')}/uploads/users/${profileImg}`;

    console.log('Successfully processed image:', {
      filename: profileImg,
      url: profileImgUrl
    });

    res.status(200).json({
      status: 'success',
      message: 'Image uploaded successfully',
      profileImg: profileImg,
      profileImgUrl: profileImgUrl,
    });
  } catch (error) {
    console.error('Upload handler error:', error);
    next(error);
  }
};

//@desc  Deactivate logged user
//@route DELETE /api/v1/users/deleteMe
//@access Private/Protect
exports.deleteLoggedUserData = asyncHandler(async (req, res, next) => {
  await User.findByIdAndUpdate(req.user._id, { active: false });
  res.status(204).json({ status: 'Success' });
});

// @desc    Check if profile image already exists
// @route   POST /api/v1/users/check-image-exists
// @access  Private/Protect
exports.checkImageExists = asyncHandler(async (req, res, next) => {
  const { fileName } = req.body;

  if (!fileName) {
    return next(new ApiError('fileName is required', 400));
  }

  const query = { profileImg: fileName };
  const user = await User.findOne(query).select('_id');
  const exists = !!user;

  res.status(200).json({ exists });
}); 