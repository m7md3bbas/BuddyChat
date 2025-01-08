import 'package:TaklyAPP/bloc_observer.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/localization_service.dart';
import 'package:TaklyAPP/core/functions/myroutes.dart';
import 'package:TaklyAPP/core/themes/theme_provider.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/bindings/auth_binding.dart';
import 'package:TaklyAPP/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:TaklyAPP/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc; // Alias added
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Future.delayed(const Duration(seconds: 1), () {
    FlutterNativeSplash.remove();
    Get.find<AuthCubit>().checkAuth();
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bloc.Bloc.observer = MyBlocObserver();

  await LocalizationService.loadTranslations();

  Get.put(FontSizeController());
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const BuddyChat()));
}

class BuddyChat extends StatelessWidget {
  const BuddyChat({
    super.key,
  });

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
      initialBinding: AuthBinding(),
      getPages: MyRoutes.myRoutes,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
