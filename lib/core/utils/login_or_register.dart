
import 'package:TaklyAPP/features/auth/presentation/views/login.dart';
import 'package:TaklyAPP/features/auth/presentation/views/register.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Define an enum for the active page
  AuthPage currentPage = AuthPage.login;

  // Function to toggle between pages
  void setPage(AuthPage page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case AuthPage.login:
        return Login(
          toogleAuthGate: () => setPage(AuthPage.register),
        );
      case AuthPage.register:
        return Register(
          toogleAuthGate: () => setPage(AuthPage.login),
        );
    }
  }
}

// Enum for defining pages
enum AuthPage { login, register }
