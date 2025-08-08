import 'package:flutter/material.dart';
import 'package:proo/features/splash/splash_screen.dart';
import 'package:proo/features/auth/login_screen.dart';
import 'package:proo/features/auth/register_screen.dart';
import 'package:proo/features/home/presentation/home_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings, {
    void Function(Locale)? onChangeLocale,
  }) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(onChangeLocale: onChangeLocale),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
