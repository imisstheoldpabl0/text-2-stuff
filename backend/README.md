# Backend Server - Quick Start

## Setup

1. **Install dependencies** (first time only):
   ```bash
   npm install
   ```

2. **Add your Replicate API token** to `.env`:
   ```
   REPLICATE_API_TOKEN=your_token_here
   ```
   Get your token at: https://replicate.com/account/api-tokens

## Running the Server

**Development mode** (with auto-reload):
```bash
npm run dev
```

**Production mode**:
```bash
npm start
```

Server runs at: `http://localhost:3000`

## Testing

```bash
# Health check
curl http://localhost:3000/health

# List models
curl http://localhost:3000/api/models
```
