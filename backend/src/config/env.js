import dotenv from 'dotenv';

// Load environment variables immediately when this module is imported
dotenv.config();

// Export environment variables for explicit access if needed
export const config = {
  REPLICATE_API_TOKEN: process.env.REPLICATE_API_TOKEN,
  PORT: process.env.PORT || 3000,
  NODE_ENV: process.env.NODE_ENV || 'development'
};

// Validate critical environment variables
if (!config.REPLICATE_API_TOKEN) {
  console.error('ERROR: REPLICATE_API_TOKEN is not set in .env file');
  console.error('Please add your Replicate API token to backend/.env');
  process.exit(1);
}

console.log('✓ Environment variables loaded successfully');
console.log(`✓ Replicate token loaded: ${config.REPLICATE_API_TOKEN.substring(0, 10)}...`);
