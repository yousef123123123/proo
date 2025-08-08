import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proo/l10n/app_localizations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          Localizations.localeOf(context).languageCode == 'ar'
              ? 'مرحبا بك'
              : 'Welcome',
          style: TextStyle(
            fontFamily: Localizations.localeOf(context).languageCode == 'ar'
                ? 'Cairo'
                : 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/lolo.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Lottie.asset(
                        'assets/splash.json',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                Localizations.localeOf(context).languageCode == 'ar'
                    ? 'تطبيق التجارة'
                    : 'Ecommerce App',
                style: TextStyle(
                  fontFamily:
                      Localizations.localeOf(context).languageCode == 'ar'
                      ? 'Cairo'
                      : 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: Colors.deepPurple,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                    ),
                    icon: const Icon(Icons.login),
                    label: Text(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? 'تسجيل الدخول'
                          : 'Sign In',
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      side: const BorderSide(
                        color: Colors.deepPurple,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.person_add_alt_1),
                    label: Text(
                      Localizations.localeOf(context).languageCode == 'ar'
                          ? 'مستخدم جديد'
                          : 'Sign Up',
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/register');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
