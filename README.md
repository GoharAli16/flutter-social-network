# 📱 Flutter Social Network

A modern social media application built with Flutter, featuring real-time messaging, stories, live streaming, and AI-powered content recommendations.

## ✨ Features

### 💬 Real-time Messaging
- **Instant Messaging**: Real-time chat with WebSocket integration
- **Group Chats**: Create and manage group conversations
- **Voice Messages**: Send and receive voice notes
- **File Sharing**: Share photos, videos, and documents
- **Message Reactions**: React to messages with emojis
- **Message Status**: Read receipts and delivery confirmations

### 📸 Stories & Media
- **24-Hour Stories**: Share temporary content that disappears
- **Photo/Video Sharing**: High-quality media sharing
- **Creative Tools**: Filters, stickers, and text overlays
- **Story Highlights**: Save important stories permanently
- **Media Gallery**: Organized photo and video collections

### 🎥 Live Streaming
- **Live Video**: Broadcast live to followers
- **Live Chat**: Real-time interaction during streams
- **Screen Sharing**: Share your screen with viewers
- **Live Reactions**: Real-time emoji reactions
- **Stream Recording**: Save live streams for later viewing

### 🤖 AI-Powered Features
- **Content Recommendations**: AI-driven feed personalization
- **Smart Filters**: Automatic content moderation
- **Face Recognition**: Tag friends in photos automatically
- **Trending Topics**: AI-identified trending content
- **Content Translation**: Real-time language translation

### 👥 Social Features
- **Friend System**: Add and manage friends
- **Follow System**: Follow interesting users
- **Social Discovery**: Find new people to connect with
- **Interest Groups**: Join communities based on interests
- **Event Creation**: Create and manage social events

### 🔒 Privacy & Security
- **End-to-End Encryption**: Secure messaging
- **Privacy Controls**: Granular privacy settings
- **Content Reporting**: Report inappropriate content
- **Block/Unblock**: Manage unwanted interactions
- **Data Protection**: GDPR compliant data handling

## 🏗️ Architecture

### State Management
- **Riverpod**: Modern state management solution
- **Provider**: Dependency injection and state sharing
- **BLoC**: Business logic separation

### Real-time Features
- **Socket.IO**: Real-time communication
- **WebSocket**: Low-latency messaging
- **Firebase**: Cloud messaging and storage
- **Agora RTC**: Live streaming and video calls

### Data Layer
- **Firebase Firestore**: Cloud database
- **Hive**: Local database for offline support
- **Isar**: High-performance local database
- **REST APIs**: External service integration

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Firebase project setup
- Agora account for live streaming

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/GoharAli16/flutter-social-network.git
   cd flutter-social-network
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Create a Firebase project
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Enable Authentication, Firestore, and Cloud Messaging

4. **Configure Agora RTC**
   - Create an Agora account
   - Get your App ID and App Certificate
   - Update configuration in `lib/core/config/app_config.dart`

5. **Run the application**
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── core/
│   ├── config/          # App configuration
│   ├── theme/           # UI themes and styling
│   ├── routing/         # Navigation setup
│   └── services/        # Core services
├── features/
│   ├── auth/            # Authentication
│   ├── feed/            # Social feed
│   ├── messaging/       # Chat and messaging
│   ├── stories/         # Stories feature
│   ├── live/            # Live streaming
│   ├── profile/         # User profiles
│   └── discovery/       # Social discovery
├── shared/
│   ├── widgets/         # Reusable widgets
│   ├── models/          # Data models
│   └── utils/           # Utility functions
└── main.dart
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:

```env
# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_PROJECT_ID=your_project_id

# Agora RTC Configuration
AGORA_APP_ID=your_agora_app_id
AGORA_APP_CERTIFICATE=your_agora_certificate

# Socket.IO Configuration
SOCKET_URL=wss://api.socialnetwork.com
```

### Feature Flags
Enable/disable features in `lib/core/config/app_config.dart`:

```dart
static const bool enableLiveStreaming = true;
static const bool enableStories = true;
static const bool enableAIRecommendations = true;
static const bool enableVoiceMessages = true;
static const bool enableFileSharing = true;
```

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Integration Tests
```bash
flutter test integration_test/
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

## 📊 Analytics & Monitoring

### Firebase Analytics
- User engagement tracking
- Content interaction metrics
- Real-time user monitoring
- Custom event logging

### Performance Monitoring
- App startup time
- Screen load performance
- Memory usage tracking
- Network request monitoring

## 🔒 Security

### Data Protection
- End-to-end encryption for messages
- Secure API communication (HTTPS)
- Biometric authentication support
- Content moderation and reporting

### Privacy
- GDPR compliance
- Data anonymization
- User consent management
- Right to be forgotten

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 📈 Performance

### Optimization Techniques
- Lazy loading for images and videos
- Code splitting and tree shaking
- Efficient state management
- Memory leak prevention
- Network request optimization

### Metrics
- App size: ~30MB (APK)
- Startup time: <3 seconds
- Memory usage: <120MB
- Battery optimization: Efficient background processing

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Agora for live streaming capabilities
- Open source community contributors

## 📞 Support

For support, email iamgoharali25@gmail.com or join our Discord community.

---

**Made with ❤️ using Flutter**
