import express from 'express';
import replicateService from '../services/replicate.js';

const router = express.Router();

// POST /api/predictions - Create a new prediction
router.post('/', async (req, res, next) => {
  try {
    const { modelKey, input, webhook } = req.body;

    if (!modelKey || !input) {
      return res.status(400).json({
        success: false,
        error: 'modelKey and input are required'
      });
    }

    const prediction = await replicateService.createPrediction(
      modelKey,
      input,
      webhook
    );

    res.json({ success: true, prediction });
  } catch (error) {
    next(error);
  }
});

// GET /api/predictions/:id - Get prediction status
router.get('/:id', async (req, res, next) => {
  try {
    const prediction = await replicateService.getPrediction(req.params.id);
    res.json({ success: true, prediction });
  } catch (error) {
    next(error);
  }
});

export default router;
