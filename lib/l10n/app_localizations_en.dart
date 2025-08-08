// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get login => 'Sign In';

  @override
  String get register => 'Sign Up';

  @override
  String get newUser => 'New user? Register';

  @override
  String get ecommerceApp => 'Ecommerce App';

  @override
  String get goToLogin => 'Go to Login';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get validEmail => 'Enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordLength => 'Password must be at least 6 characters';

  @override
  String get usernameRequired => 'Username is required';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get passwordsNotMatch => 'Passwords do not match';

  @override
  String get welcome => 'Welcome';

  @override
  String get email => 'Email';

  @override
  String get fullName => 'Full Name';

  @override
  String get firstLetterUppercase => 'First letter must be uppercase';

  @override
  String get alreadyHaveAccount => 'Already have an account? Sign In';
}
