import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_theme.dart';
import 'core/routing/app_router.dart';
import 'core/services/notification_service.dart';
import 'core/services/analytics_service.dart';
import 'core/services/realtime_service.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/feed/presentation/providers/feed_provider.dart';
import 'features/messaging/presentation/providers/messaging_provider.dart';
import 'features/stories/presentation/providers/stories_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize services
  await NotificationService.initialize();
  await AnalyticsService.initialize();
  await RealtimeService.initialize();

  runApp(const ProviderScope(child: SocialNetworkApp()));
}

class SocialNetworkApp extends ConsumerWidget {
  const SocialNetworkApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
