import express from 'express';
import replicateService from '../services/replicate.js';

const router = express.Router();

// GET /api/models - List all available models
router.get('/', (req, res) => {
  const models = replicateService.getAvailableModels();
  res.json({ success: true, models });
});

// GET /api/models/:modelKey - Get specific model info
router.get('/:modelKey', (req, res) => {
  const models = replicateService.getAvailableModels();
  const model = models[req.params.modelKey];

  if (!model) {
    return res.status(404).json({
      success: false,
      error: 'Model not found'
    });
  }

  res.json({ success: true, model });
});

export default router;
