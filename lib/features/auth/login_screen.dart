import 'package:flutter/material.dart';
import 'package:proo/l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

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
              ? 'تسجيل الدخول'
              : 'Sign In',
          style: TextStyle(
            fontFamily: isArabic ? 'Cairo' : 'Inter',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/lolo.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText:
                                Localizations.localeOf(context).languageCode ==
                                    'ar'
                                ? 'البريد الإلكتروني'
                                : 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'ar'
                                  ? 'البريد الإلكتروني مطلوب'
                                  : 'Email is required';
                            }
                            if (!value.contains('@')) {
                              return Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'ar'
                                  ? 'أدخل بريد إلكتروني صحيح'
                                  : 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText:
                                Localizations.localeOf(context).languageCode ==
                                    'ar'
                                ? 'كلمة المرور'
                                : 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'ar'
                                  ? 'كلمة المرور مطلوبة'
                                  : 'Password is required';
                            }
                            if (value.length < 6) {
                              return Localizations.localeOf(
                                        context,
                                      ).languageCode ==
                                      'ar'
                                  ? 'كلمة المرور يجب أن تكون 6 أحرف على الأقل'
                                  : 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 6,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      isArabic
                                          ? 'تم تسجيل الدخول'
                                          : 'Login Successful',
                                    ),
                                    content: Text(
                                      isArabic
                                          ? 'مرحباً بك في التطبيق!'
                                          : 'Welcome to the app!',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(
                                            context,
                                          ).pushReplacementNamed('/home');
                                        },
                                        child: Text(
                                          isArabic ? 'إغلاق' : 'Close',
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text(
                              Localizations.localeOf(context).languageCode ==
                                      'ar'
                                  ? 'تسجيل الدخول'
                                  : 'Sign In',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed('/register');
                          },
                          child: Text(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? 'مستخدم جديد؟ سجل الآن'
                                : 'New user? Register',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
