
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:jankoyer/provider/championat_provider.dart';
import 'package:jankoyer/provider/navbar_provider.dart';
import 'package:jankoyer/provider/shop.dart';
import 'package:jankoyer/provider/video_controller_provider.dart';
import 'package:provider/provider.dart';

import 'provider/interviews.dart';
import 'screens/splash_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // FirebaseMessaging.onBackgroundMessage(
  //     FirebaseNotificationService.backgroundMessage);
  // await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<InterviewsProvider>(
              create: (_) => InterviewsProvider()),
          ChangeNotifierProvider<ShopProvider>(create: (_) => ShopProvider()),
          ChangeNotifierProvider<VideoControllerProvider>(create: (_) => VideoControllerProvider()),
          ChangeNotifierProvider<ChampionatProvider>(
              create: (_) => ChampionatProvider()),
          ChangeNotifierProvider<NavBarProvider>(
              create: (_) => NavBarProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Janköýer',
            // navigatorKey: Grock.navigationKey,
            // scaffoldMessengerKey: Grock.scaffoldMessengerKey,
            theme: ThemeData(
                fontFamily: 'Ubuntu',
                scaffoldBackgroundColor: AppColors.background),
            home: const SplashScreen()));
  }
}

// android:networkSecurityConfig="@xml/network_security_config"
