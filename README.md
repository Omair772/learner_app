# Learner App

A Flutter-based learner application developed as a university project.

## Project Description

Learner App is a mobile learning application that allows users to create accounts, log in, browse learning content retrieved from an external API, view content details, save favorites locally, manage their profile, configure application settings, and test notifications.

## Technologies Used

- Flutter
- Dart
- HTTP
- SharedPreferences
- Flutter Local Notifications
- REST API
- GitHub

## Main Features

- User registration
- User login
- Home screen
- External API integration
- Content details
- Favorites
- Local data persistence
- User profile
- Settings menu
- Application settings
- Notifications

## Project Structure

```text
lib/
├── main.dart
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   ├── profile_screen.dart
│   ├── settings_menu_screen.dart
│   ├── settings_screen.dart
│   └── notifications_screen.dart
│
└── services/
    ├── auth_service.dart
    ├── storage_service.dart
    ├── api_service.dart
    └── notification_service.dart