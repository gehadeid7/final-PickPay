const multer = require('multer');
const ApiError = require('../utils/apiError');
const path = require('path');
const fs = require('fs');

const multerOptions = () => {
  // Get the project root directory (2 levels up from this file)
  const projectRoot = path.join(__dirname, '..', '..');
  const uploadDir = path.join(projectRoot, 'uploads', 'users');
  console.log('📁 Project root:', projectRoot);
  console.log('📁 Upload directory path:', uploadDir);
  
  if (!fs.existsSync(uploadDir)) {
    console.log('📁 Creating upload directory...');
    fs.mkdirSync(uploadDir, { recursive: true });
    console.log('✅ Upload directory created successfully');
  } else {
    console.log('📁 Upload directory already exists');
  }

  const multerStorage = multer.diskStorage({
    destination: function (req, file, cb) {
      console.log('📁 Saving file to:', uploadDir);
      console.log('📄 File details:', {
        originalname: file.originalname,
        mimetype: file.mimetype,
        size: file.size
      });
      cb(null, uploadDir);
    },
    filename: function (req, file, cb) {
      const ext = file.mimetype.split('/')[1];
      const filename = `user-${Date.now()}.${ext}`;
      console.log('📄 Generated filename:', filename);
      console.log('📄 Full path will be:', path.join(uploadDir, filename));
      cb(null, filename);
    }
  });

  const multerFilter = function (req, file, cb) {
    console.log('🔍 Checking file type:', file.mimetype);
    console.log('🔍 File details:', {
      originalname: file.originalname,
      size: file.size,
      mimetype: file.mimetype
    });
    if (file.mimetype.startsWith('image')) {
      console.log('✅ File type accepted');
      cb(null, true);
    } else {
      console.log('❌ Invalid file type');
      cb(new ApiError('Only Images allowed', 400), false);
    }
  };

  const upload = multer({ 
    storage: multerStorage, 
    fileFilter: multerFilter,
    limits: {
      fileSize: 5 * 1024 * 1024, // 5MB limit
      files: 1 // Only allow one file
    },
    preservePath: true // Keep the original path
  });

  // Add error handling
  upload._handleFile = function(req, file, cb) {
    this._storage._handleFile(req, file, (err, info) => {
      if (err) {
        console.error('❌ Multer file handling error:', err);
        return cb(err);
      }
      console.log('✅ File handled successfully:', info);
      cb(null, info);
    });
  };

  return upload;
};

exports.uploadSingleImage = (fieldName) => {
  console.log('🔄 Setting up upload middleware for field:', fieldName);
  return multerOptions().single(fieldName);
};

exports.uploadMixOfImages = (arrayOfFields) => {
  console.log('🔄 Setting up upload middleware for fields:', arrayOfFields);
  return multerOptions().fields(arrayOfFields);
}; 