# Do4U - Jules Agent Configuration

## Project Overview
Do4U is Egypt's first dedicated errands mobile application, connecting customers with runners to handle various tasks like government paperwork, shopping, pick-up/drop-off, queueing, car errands, and custom tasks.

## Tech Stack
- **Frontend:** Flutter 3.x (Dart)
- **State Management:** BLoC / Cubit
- **Backend:** Node.js 20 LTS (Express.js)
- **Database:** PostgreSQL 16 (Primary), Firebase Firestore (Real-time)
- **Infrastructure:** Google Cloud Run, Firebase, Redis

## Architecture
- **Monorepo:** Managed by Melos.
- **Backend:** Layered architecture (Routes, Services, Models, Middleware).
- **Mobile:** Feature-based modularization.
- **Real-time:** Firestore for runner locations and Socket.io for status updates.

## Code Style & Linting
- **Dart:** Follow standard Flutter linting rules.
- **JavaScript/TypeScript:** ESLint with standard configurations.
- **Naming:** camelCase for variables/functions, PascalCase for classes.

## Testing Requirements
- Unit tests for all BLoC classes.
- Unit tests for the pricing engine.
- Integration tests for critical user journeys.
- All new features MUST include tests.
- Run `flutter test` before completing tasks.

## Key Environment Variables
- `DATABASE_URL`, `REDIS_URL`, `JWT_PRIVATE_KEY`, `JWT_PUBLIC_KEY`
- `FIREBASE_SERVICE_ACCOUNT`, `PAYMOB_API_KEY`, `VONAGE_API_KEY`

## Instructions
- Adhere to the FULL TECHNICAL SPECIFICATION provided in the initial prompt.
- Ensure RTL (Arabic) support in all UI components.
- Use the shared packages for models and UI components to ensure consistency.
