# Replicate AI Models iOS App - Project Context

## Project Overview
We are building an iOS application that provides end users with a beautiful frontend interface to access AI image and video generation models through Replicate's API. This is our first app, and we're starting with a simple but well-architected foundation that can scale.

## Tech Stack

### Backend
- **Runtime**: Node.js (v16+)
- **Framework**: Express.js
- **API Client**: Replicate JavaScript SDK
- **Language**: ES6+ (ESM modules)
- **Key Dependencies**:
  - `replicate` - Official Replicate API client
  - `express` - Web framework
  - `cors` - Cross-origin resource sharing
  - `dotenv` - Environment variable management

### Frontend
- **Platform**: iOS 26 (minimum target)
- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Networking**: Native URLSession with async/await

## Project Goals

### Primary Objectives
1. Create a clean, simple backend API that proxies requests to Replicate
2. Build an intuitive iOS interface for generating images and videos
3. Make 5 free AI models available from launch:
   - Google Imagen 4 (image generation)
   - Luma Reframe Video (video reframing)
   - Ideogram V3 Turbo (fast image generation)
   - FLUX Kontext Pro (image editing with text)
   - MiniMax Video-01 (text-to-video)

### Secondary Objectives
- Establish patterns for easy addition of new models
- Implement proper error handling and loading states
- Create a maintainable codebase for future expansion

## Key Constraints & Requirements

### Backend Requirements
- Follow the "Slowstart: Set up a project from scratch" guide from Replicate's docs
- Use ESM modules (`"type": "module"` in package.json)
- RESTful API design with proper status codes
- Environment-based configuration (never commit API tokens)
- Cors enabled for local iOS development

### iOS Requirements
- **Strictly iOS 26+** - Use latest SwiftUI features
- SwiftUI for all UI components (no UIKit unless absolutely necessary)
- Async/await for all network calls
- Proper error handling and user feedback
- Support both light and dark mode

### Code Quality Standards
- Clear, descriptive variable and function names
- Proper error messages that help with debugging
- Comments only where logic is complex
- Consistent code formatting
- Type safety (TypeScript patterns in JS, strong typing in Swift)

## Project Structure

### Expected Directory Layout
```
project-root/
├── CLAUDE.md                 # This file
├── backend/
│   ├── src/
│   │   ├── server.js        # Express app entry point
│   │   ├── routes/          # API route handlers
│   │   ├── services/        # Business logic (Replicate calls)
│   │   ├── config/          # Configuration files
│   │   └── middleware/      # Express middleware
│   ├── .env                 # Environment variables (git-ignored)
│   ├── .gitignore
│   └── package.json
└── replicate-ai/
    └── ReplicateApp/
        ├── App/             # App entry point
        ├── Models/          # Data models
        ├── Services/        # API service layer
        ├── ViewModels/      # Business logic for views
        ├── Views/           # SwiftUI views
        └── Resources/       # Assets, config files
```

## Important Technical Details

### Replicate API Patterns
- Models are identified as `owner/model-name` (e.g., `google/imagen-4`)
- The JavaScript SDK supports both `replicate.run()` (blocking) and `replicate.predictions.create()` (async)
- Predictions have statuses: `starting`, `processing`, `succeeded`, `failed`, `canceled`
- Free models don't require payment setup but still need authentication

### iOS-Specific Considerations
- **iOS 26 minimum** means we can use:
  - `NavigationStack` (not NavigationView)
  - Modern SwiftUI syntax
  - Swift 5.9+ features
- URLSession is sufficient (no need for Alamofire)
- Use `@MainActor` for ViewModels that update UI
- `async/await` is preferred over completion handlers

### Model Input/Output Patterns
Each model has different input requirements:
- **Image models**: Usually require a `prompt` string
- **Video models**: May require `prompt` + additional parameters
- **Outputs**: Usually return URLs to generated files (images/videos)
- The app will need to download and display these files

## Development Workflow

### Backend Development
1. Set up Node.js project with ESM modules
2. Install Replicate SDK and dependencies
3. Create Express server with CORS
4. Implement model configuration
5. Create API routes (models, predictions)
6. Test with curl/Postman before connecting iOS

### iOS Development
1. Create Xcode project targeting iOS 26
2. Set up Models (Codable structs)
3. Create APIService for backend communication
4. Build ViewModels with @Published properties
5. Create SwiftUI views with proper state management
6. Test with backend running locally

### Testing Strategy
- Backend: Test each endpoint with curl
- iOS: Run in simulator against local backend
- Integration: Full flow from UI → Backend → Replicate → Result

## Reference Documentation
- [Replicate Node.js Quickstart](https://replicate.com/docs/get-started/nodejs)
- [Replicate JavaScript Client GitHub](https://github.com/replicate/replicate-javascript)
- [Google Imagen 4 Model](https://replicate.com/google/imagen-4)
- [Luma Reframe Video](https://replicate.com/luma/reframe-video)
- [Ideogram V3 Turbo](https://replicate.com/ideogram-ai/ideogram-v3-turbo)
- [FLUX Kontext Pro](https://replicate.com/black-forest-labs/flux-kontext-pro)
- [MiniMax Video-01](https://replicate.com/minimax/video-01)

## Environment Variables Required

### Backend (.env)
```
REPLICATE_API_TOKEN=r8_xxxxxxxxxxxxxxxxxxxx
PORT=3000
NODE_ENV=development
```

### iOS (Config.swift)
```swift
enum Config {
    static let apiBaseURL = "http://localhost:3000/api"
    // Change to production URL when deploying
}
```

## Security Considerations
- API token should NEVER be in iOS app or committed to git
- Backend acts as a proxy to keep credentials secure
- Use HTTPS in production
- Validate inputs on backend before sending to Replicate
- Rate limiting should be added before production

## Future Enhancements (Not in Initial Scope)
- User authentication
- Saving generation history
- Sharing generated content
- In-app purchases for premium models
- Push notifications for long-running generations
- Batch generation support

## Getting Started Checklist
- [ ] Obtain Replicate API token from https://replicate.com/account/api-tokens
- [ ] Install Node.js v16 or higher
- [ ] Install Xcode with iOS 26 SDK
- [ ] Clone/create repository structure
- [ ] Set up backend following the plan
- [ ] Set up iOS app following the plan
- [ ] Test backend endpoints independently
- [ ] Test iOS app against backend
- [ ] Verify all 5 models work correctly

## Notes for Claude Code
- When creating files, follow the exact structure outlined in the detailed plan
- Use consistent naming conventions (camelCase for JS, PascalCase for Swift types)
- Include proper error handling in every async function
- Add loading states to all UI components that fetch data
- Comment any complex business logic
- Create one complete, working feature at a time
- Test each component before moving to the next