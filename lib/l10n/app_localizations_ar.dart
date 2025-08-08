// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home => 'الرئيسية';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'مستخدم جديد';

  @override
  String get newUser => 'مستخدم جديد؟ سجل الآن';

  @override
  String get ecommerceApp => 'تطبيق التجارة';

  @override
  String get goToLogin => 'اذهب للتسجيل';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get validEmail => 'أدخل بريد إلكتروني صحيح';

  @override
  String get password => 'كلمة المرور';

  @override
  String get passwordRequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordLength => 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';

  @override
  String get usernameRequired => 'اسم المستخدم مطلوب';

  @override
  String get confirmPassword => 'أكد كلمة المرور';

  @override
  String get passwordsNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get welcome => 'مرحبا بك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get firstLetterUppercase => 'يجب أن يبدأ الاسم بحرف كبير';

  @override
  String get alreadyHaveAccount => 'لديك حساب؟ سجل الدخول';
}
