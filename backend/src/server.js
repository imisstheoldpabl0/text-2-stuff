import './config/env.js';  // Import FIRST to load environment variables
import express from 'express';
import cors from 'cors';
import modelsRouter from './routes/models.js';
import predictionsRouter from './routes/predictions.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.use('/api/models', modelsRouter);
app.use('/api/predictions', predictionsRouter);

// Error handling
app.use((error, req, res, next) => {
  console.error('Error:', error);
  res.status(500).json({
    success: false,
    error: error.message || 'Internal server error'
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log('\n🚀 Server running successfully!');
  console.log(`   Local: http://localhost:${PORT}`);
  console.log(`   Network: http://192.168.1.37:${PORT}`);
  console.log('\n✓ Ready to accept requests from iOS app\n');
});
