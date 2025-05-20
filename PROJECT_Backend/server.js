const express = require('express');
const cors = require('cors');
const morgan = require('morgan');
const path = require('path');
const fs = require('fs');
const dotenv = require('dotenv');
const compression = require('compression');
const rateLimit = require('express-rate-limit');
const ApiError = require('./utils/apiError');
const globalError = require('./middlewares/errorMiddleware');
const mountRoutes = require('./routes');
const dbConnection = require('./config/database');
const { webhookCheckout } = require('./services/orderService');

const configPath = path.join(__dirname, 'config.env');
console.log('Config path:', configPath);
console.log('Config exists:', fs.existsSync(configPath));
dotenv.config({ path: configPath });
console.log('Loaded DB_URI:', process.env.DB_URI);

// Connect with db
dbConnection();

// express app
const app = express();

// Enable other domains to access your application
app.use(cors());
app.options('*', cors());

// compress all responses
app.use(compression());

// Checkout webhook
app.post(
  '/webhook-checkout',
  express.raw({ type: 'application/json' }),
  webhookCheckout
);

// Middlewares
app.use(express.json({ limit: '20kb' }));
app.use(express.static(path.join(__dirname, 'uploads')));

// Serve static files from the uploads directory with specific route
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
  console.log(`mode: ${process.env.NODE_ENV}`);
}

// Limit each IP to 100 requests per `window` (here, per 15 minutes)
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100,
  message:
    "Too many accounts created from this IP, please try again after an hour",
});

// Apply the rate limiting middlewareto all requests
app.use("/api", limiter);

// Mount Routes
mountRoutes(app);

// Handle unhandled routes
app.all('*', (req, res, next) => {
  next(new ApiError(`Cant find this route: ${req.originalUrl}`, 400));
});

// Global error handling middleware
app.use(globalError);

const PORT = process.env.PORT || 3000;
const server = app.listen(PORT, () => {
  console.log(`App running on port ${PORT}`);
});

// Handle rejection outside express
process.on('unhandledRejection', (err) => {
  console.error(`UnhandledRejection Errors: ${err.name} | ${err.message}`);
  server.close(() => {
    console.error(`Shutting down....`);
    process.exit(1);
  });
}); 