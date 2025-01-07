
  import 'package:TaklyAPP/features/auth/presentation/views/auth_gate.dart';
  import 'package:TaklyAPP/features/auth/presentation/views/on_boarding.dart';
  import 'package:TaklyAPP/features/home/presentation/views/add_contact.dart';
  import 'package:TaklyAPP/features/home/presentation/views/drawer.dart';
  import 'package:TaklyAPP/features/home/presentation/views/home_view.dart';
  import 'package:TaklyAPP/features/home/presentation/views/profile_photo.dart';
  import 'package:TaklyAPP/features/settings/presentation/bindings/font_size_binding.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/account_setting.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/chat_settings.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/setting_page.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/widgets/delete_account.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/widgets/update_email.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/widgets/update_name.dart';
  import 'package:TaklyAPP/features/settings/presentation/views/widgets/update_password.dart';
  import 'package:get/get_navigation/src/routes/get_route.dart';
  import 'package:get/get_navigation/src/routes/transitions_type.dart';

  class MyRoutes {
    static List<GetPage<dynamic>> get myRoutes {
      return [
        GetPage(
          name: '/',
          page: () => const AuthGate(),
          bindings: [FontSizeBinding()],
          transition: Transition.leftToRight, // Transition effect
        ),
        GetPage(
          name: '/home',
          page: () => const HomeView(),
          transition: Transition.leftToRight, // Transition effect
        ),
        GetPage(
          name: '/addContact',
          page: () => const AddContact(),
          bindings: [
            FontSizeBinding(),
          ],
          transition: Transition.rightToLeft, // Transition effect
        ),
        GetPage(
            name: '/drawer',
            page: () => const BuildDrawer(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/setting',
            page: () => const Setting(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/PhotoProfile',
            page: () => const ProfilePhoto(),
            bindings: [FontSizeBinding()],
            transition: Transition.zoom),
        GetPage(
            name: '/account',
            page: () => const Account(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/chats',
            page: () => const ChatSetting(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/changeName',
            page: () => const ChangeName(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/updateEmail',
            page: () => const UpdateEmail(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/updatePassword',
            page: () => const UpdatePassword(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/deleteAccount',
            page: () => const DeleteAccount(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
        GetPage(
            name: '/onboarding',
            page: () => OnboardingScreen(),
            bindings: [FontSizeBinding()],
            transition: Transition.leftToRight),
      ];
      
    }
  }
