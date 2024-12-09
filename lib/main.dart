import 'package:TaklyAPP/bloc_observer.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/localization_service.dart';
import 'package:TaklyAPP/core/functions/myroutes.dart';
import 'package:TaklyAPP/core/themes/theme_provider.dart';
import 'package:TaklyAPP/features/auth/presentation/views/auth_gate.dart';
import 'package:TaklyAPP/features/auth/presentation/views/on_boarding.dart';
import 'package:TaklyAPP/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc; // Alias added
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bloc.Bloc.observer = MyBlocObserver();

  await LocalizationService.loadTranslations();
  final prefs = await SharedPreferences.getInstance();
  final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

  Get.put(FontSizeController());
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: BuddyChat(
        hasSeenOnboarding: hasSeenOnboarding,
      )));
}

class BuddyChat extends StatefulWidget {
  final bool hasSeenOnboarding;
  const BuddyChat({super.key, required this.hasSeenOnboarding});

  @override
  State<BuddyChat> createState() => _BuddyChatState();
}

class _BuddyChatState extends State<BuddyChat> {
  @override
  void initState() {
    super.initState();
    initializaition();
  }

  void initializaition() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: LocalizationService.defaultLocale,
      translations: LocalizationService(),
      supportedLocales: LocalizationService().getSupportedLocales(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: MyRoutes.myRoutes,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: widget.hasSeenOnboarding ? const AuthGate() : OnboardingScreen(),
    );
  }
}
