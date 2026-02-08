# Ani-Care Gov+NGO App

A complete, production-ready administrative platform for government officers, NGOs, and CSR managers in the Ani-Care ecosystem.

## 🚀 Features

- **Government Dashboard**: Real-time overview of active animals, rescues, emergencies, and disease alerts.
- **Smart Geo Map**: Interactive heatmap for accident hotspots, disease clusters, and danger zones.
- **AI Prediction Module**:
  - City-Wide Outbreak Risk
  - Budget Forecasting (Priority)
  - Shelter Demand Prediction
  - Emergency Surgery Analysis
  - Climate Impact Analysis
- **Training & Certification**:
  - Online Courses
  - Exam Module with Auto-evaluation
  - Branded Certificate Generator
  - NGO/Volunteer Rating System
- **Report Management**: PDF export for all analytical modules.
- **Security**: Role-based access control and secure authentication.

## 🎨 Design System

- **Primary Colors**: Teal / Blue-Green Gradient
- **UI Components**: Rounded cards (18px), soft shadows, high-contrast typography.
- **Animations**: Smooth transitions, ripple feedback, and chart animations.

## 🛠️ Tech Stack

- **Frontend**: Flutter (Android & iOS)
- **Backend**: Firebase (Auth, Firestore, Storage, Messaging)
- **AI Engine**: Python ML API (Random Forest, XGBoost, LSTM)
- **Reporting**: PDF & Printing integration

## 📦 Installation

1. Ensure you have Flutter installed (`flutter doctor`).
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Configure Firebase:
   - Create a Firebase project.
   - Add Android/iOS apps.
   - Download `google-services.json` and `GoogleService-Info.plist` to respective directories.
5. Run the app: `flutter run`.

## 📂 Project Structure

- `lib/theme/`: Global UI theme and constants.
- `lib/screens/`: All application screens organized by module.
- `lib/services/`: Backend integration and business logic.
- `lib/widgets/`: Reusable UI components.
- `lib/models/`: Data models for Firestore collections.

---
Developed for the Ani-Care Ecosystem.
