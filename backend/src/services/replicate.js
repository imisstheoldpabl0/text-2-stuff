import '../config/env.js';  // Import FIRST to ensure dotenv loads
import Replicate from 'replicate';
import { AVAILABLE_MODELS } from '../config/models.js';

class ReplicateService {
  constructor() {
    const token = process.env.REPLICATE_API_TOKEN;

    if (!token) {
      throw new Error('REPLICATE_API_TOKEN is not set in environment variables');
    }

    console.log('✓ Initializing Replicate client with token:', token.substring(0, 10) + '...');

    this.client = new Replicate({
      auth: token
    });
  }

  async runModel(modelKey, input, onProgress = null) {
    const model = AVAILABLE_MODELS[modelKey];
    if (!model) {
      throw new Error(`Model ${modelKey} not found`);
    }

    try {
      const output = await this.client.run(model.id, { input }, onProgress);
      return output;
    } catch (error) {
      throw new Error(`Failed to run model: ${error.message}`);
    }
  }

  async createPrediction(modelKey, input, webhook = null) {
    const model = AVAILABLE_MODELS[modelKey];
    if (!model) {
      throw new Error(`Model ${modelKey} not found`);
    }

    const options = {
      model: model.id,
      input
    };

    if (webhook) {
      options.webhook = webhook;
      options.webhook_events_filter = ['completed'];
    }

    return await this.client.predictions.create(options);
  }

  async getPrediction(predictionId) {
    return await this.client.predictions.get(predictionId);
  }

  getAvailableModels() {
    return AVAILABLE_MODELS;
  }
}

export default new ReplicateService();
