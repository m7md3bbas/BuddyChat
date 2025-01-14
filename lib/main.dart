import 'package:TaklyAPP/bloc_observer.dart';
import 'package:TaklyAPP/core/functions/font_size_controller.dart';
import 'package:TaklyAPP/core/functions/localization_service.dart';
import 'package:TaklyAPP/core/functions/locator.dart';
import 'package:TaklyAPP/core/themes/theme_provider.dart';
import 'package:TaklyAPP/features/auth/presentation/controller/cubit/auth_cubit.dart';
import 'package:TaklyAPP/features/auth/presentation/views/login.dart';
import 'package:TaklyAPP/features/home/presentation/views/home_view.dart';
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
  Future.delayed(const Duration(milliseconds: 500), () {
    FlutterNativeSplash.remove();
  });

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bloc.Bloc.observer = MyBlocObserver();

  await LocalizationService.loadTranslations();
  setupServiceLocator();
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
    return bloc.BlocProvider(
      create: (context) => locator<AuthCubit>()..checkAuth(),
      child: GetMaterialApp(
        locale: LocalizationService.defaultLocale,
        translations: LocalizationService(),
        supportedLocales: LocalizationService().getSupportedLocales(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: Provider.of<ThemeProvider>(context).themeData,
        home: bloc.BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            } else {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            }
          },
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
