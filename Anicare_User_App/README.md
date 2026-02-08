# Ani-Care Flutter App

Ani-Care is a community-driven stray animal care, health monitoring, prediction, and emergency response platform focused on Indian cities.

## Features

- **Authentication**: Secure login/signup using Firebase.
- **Dashboard**: Real-time health risk and distress predictions with 15s auto-refresh.
- **Distress Mode**: Manual location reporting for animals in need.
- **Community Feed**: Area-based updates and observations.
- **Pet Profiles**: Digital management of stray/pet health and vaccination status.
- **Rewards & Certificates**: Earn points for rescues and download achievement certificates.
- **Charts**: Visual insights into animal health trends and rescue activities.
- **AI Chatbot**: First-aid guidance and animal care assistance.

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Firebase Account

### Setup

1. **Clone the project**
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Firebase Configuration**:
   - Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com).
   - Add Android and iOS apps to your Firebase project.
   - Download `google-services.json` and place it in `android/app/`.
   - Download `GoogleService-Info.plist` and place it in `ios/Runner/`.
   - Enable Authentication (Email/Password), Firestore, and Storage.
4. **Run the app**:
   ```bash
   flutter run
   ```

## Project Structure

- `lib/models/`: Data models.
- `lib/providers/`: State management using Provider.
- `lib/screens/`: UI screens for each module.
- `lib/services/`: Firebase, ML, and PDF services.
- `lib/utils/`: Constants and theme definitions.
- `lib/widgets/`: Reusable UI components.

## ML Prediction Engine

The app features a mock ML engine that simulates predictions for:
- Health Risk
- Distress Probability
- Disease Outbreak
- Feeding Shortage
- Construction Impact

These predictions refresh every 15 seconds to provide real-time insights.
