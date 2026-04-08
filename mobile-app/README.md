# NEP Mobile App (Flutter)

Flutter scaffold for the NEP student app, aligned to the root `AGENTS.md`.

## Current scope

- Onboarding with:
  - Phone/Email
  - Programme
  - Level
  - Institution
- Bottom navigation tabs:
  - Home
  - Lectures
  - Quizzes
  - Exam Hall
  - Companion
  - Library
- Mock-data UI for:
  - Home dashboard
  - Lectures flow: Programme -> Course -> Topic
  - Quizzes practice area
- Placeholder screens for:
  - Exam Hall
  - Companion
  - Library

## Run locally

1. Install Flutter from [flutter.dev](https://flutter.dev).
2. Open a terminal in `mobile-app`.
3. Run `flutter pub get`.
4. If platform folders are not present yet, run `flutter create .`
5. Run the app with `flutter run`

## Notes

- Semester selection is intentionally excluded.
- Content is mock-only for now.
- Companion and uploads are placeholders only; content flow remains admin-controlled per `AGENTS.md`.
