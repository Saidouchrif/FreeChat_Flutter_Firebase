# 📱 FreeChat - Realtime Messaging Application

<p align="center">
  <img src="images/logo_bien.png" alt="FreeChat Logo" width="200" height="200">
</p>

<p align="center">
  <strong>A modern, secure, and scalable realtime chat application built with Flutter and Firebase</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#screenshots">Screenshots</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#installation">Installation</a> •
  <a href="#usage">Usage</a> •
  <a href="#contributing">Contributing</a>
</p>

---

## 📖 Overview

FreeChat is a feature-rich realtime messaging application that demonstrates modern mobile development practices using Flutter and Firebase. Built with scalability and security in mind, it provides a complete chat experience with user authentication, instant messaging, media sharing, and real-time updates.

The application showcases best practices in Flutter development, Firebase integration, and mobile app architecture, making it an excellent learning resource for developers interested in building chat applications.

## ✨ Features

### 🔐 Authentication & Security
- **User Registration & Login**: Secure email/password authentication
- **Firebase Authentication**: Industry-standard authentication service
- **Session Management**: Persistent login sessions
- **Password Reset**: Secure password recovery mechanism

### 💬 Realtime Messaging
- **Instant Messaging**: Real-time message delivery using Firebase Firestore
- **Message History**: Persistent chat history storage
- **Typing Indicators**: See when contacts are typing
- **Message Status**: Delivery and read receipts
- **Push Notifications**: Real-time notifications for new messages

### 🎨 User Interface
- **Modern Design**: Clean, intuitive Material Design interface
- **Responsive Layout**: Adapts to different screen sizes
- **Smooth Animations**: Enhanced user experience with Flutter animations
- **Dark/Light Theme**: Support for both color schemes
- **Customizable UI**: Easy to theme and customize

### 📱 Core Functionality
- **Contact Management**: Add and manage chat contacts
- **Group Chats**: Create and participate in group conversations
- **Media Sharing**: Send images, videos, and documents
- **Message Reactions**: React to messages with emojis
- **Search Functionality**: Find messages and contacts quickly
- **Offline Support**: Basic functionality when offline

### 🔧 Technical Features
- **Real-time Database**: Firebase Firestore for instant updates
- **Cloud Storage**: Firebase Storage for media files
- **Scalable Architecture**: Well-structured codebase
- **Error Handling**: Comprehensive error management
- **Performance Optimized**: Efficient data loading and caching
  
## 🛠 Tech Stack

### Frontend
- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language for Flutter
- **Material Design**: UI component library
- **Provider**: State management solution

### Backend & Services
- **Firebase Authentication**: User authentication service
- **Firebase Firestore**: NoSQL cloud database
- **Firebase Storage**: Cloud storage for media files
- **Firebase Cloud Messaging**: Push notifications

### Development Tools
- **Android Studio / VS Code**: IDEs for development
- **Flutter DevTools**: Debugging and profiling tools
- **Git**: Version control system

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio or VS Code
- Firebase account
- Android/iOS development environment

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Saidouchrif/freechat-flutter-firebase.git
   cd freechat-flutter-firebase
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication, Firestore, and Storage services
   - Download `google-services.json` for Android and `GoogleService-Info.plist` for iOS
   - Place these files in their respective directories:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`

4. **Configure Firebase**
   ```bash
   # For web (if applicable)
   flutterfire configure
   ```

5. **Run the application**
   ```bash
   # For Android
   flutter run
   
   # For iOS
   flutter run
   
   # For web
   flutter run -d chrome
   ```

## 📱 Usage

### First Time Setup
1. Launch the application
2. Tap "Register" to create a new account
3. Enter your email and password
4. Verify your email address
5. Sign in with your credentials

### Sending Messages
1. Navigate to the chat screen
2. Select a contact or create a new chat
3. Type your message in the input field
4. Press send or hit enter
5. View real-time message updates

### Media Sharing
1. Tap the attachment icon in the chat interface
2. Select image, video, or document
3. Choose from gallery or camera
4. Send the media file

## 🏗 Project Structure

```
lib/
├── Screens/
│   ├── chat_screen.dart          # Main chat interface
│   ├── registration_screen.dart   # User registration
│   ├── signin_screen.dart         # User login
│   └── welcome_screen.dart        # Welcome/Landing screen
├── widgets/
│   └── my_button.dart             # Custom button widget
└── main.dart                      # Entry point

android/
├── app/
│   └── google-services.json       # Firebase configuration
└── ...

ios/
├── Runner/
│   └── GoogleService-Info.plist   # Firebase configuration
└── ...
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:

```env
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
```

### Firebase Rules

**Firestore Security Rules:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    match /chats/{chatId} {
      allow read, write: if request.auth != null;
    }
    match /messages/{messageId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Run integration tests:
```bash
flutter drive --target=test_driver/app.dart
```

## 📈 Performance

- **Optimized Rendering**: Efficient widget rebuilding
- **Lazy Loading**: Load messages on demand
- **Caching**: Local data caching for offline access
- **Connection Management**: Handle network connectivity changes

## 🐛 Troubleshooting

### Common Issues

**Firebase Configuration Error**
- Ensure `google-services.json` and `GoogleService-Info.plist` are correctly placed
- Check Firebase project settings match your app configuration

**Build Failures**
- Run `flutter clean` and `flutter pub get`
- Update Flutter to the latest version
- Check Android/iOS SDK versions

**Authentication Issues**
- Verify Firebase Authentication is enabled
- Check internet connectivity
- Ensure correct API keys are configured

## 🤝 Contributing

We welcome contributions to FreeChat! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow Flutter style guide
- Write meaningful commit messages
- Add tests for new features
- Update documentation
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Authors

- **Your Name** - *Initial work* - [YourGitHub](https://github.com/saidouchrif)

See also the list of [contributors](https://github.com/Saidouchrif/freechat-flutter-firebase/contributors) who participated in this project.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- All contributors and testers
- Open source community

## 📞 Support

For support, email saidouchrif16@gmail.com or join our Slack channel.

---

<p align="center">
  Made with ❤️ using Flutter and Firebase
</p>
