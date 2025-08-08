import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proo/features/home/data/datasources/home_web_service.dart';
import 'package:proo/features/home/data/models/home/home.dart';
import 'package:proo/features/home/data/repositories/repo_impl.dart';
import 'package:proo/features/home/presentation/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

import 'package:proo/core/router/app_router.dart';

import 'package:proo/l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeCubit>(
          create: (_) => HomeCubit(HomeModel(), RepoImpl(HomeWebService())),
        ),
      ],
      child: MaterialApp(
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) =>
            AppRouter.onGenerateRoute(settings, onChangeLocale: setLocale),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          fontFamily: _locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
          textTheme: ThemeData.light().textTheme.apply(
            fontFamily: _locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: _locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
          textTheme: ThemeData.dark().textTheme.apply(
            fontFamily: _locale.languageCode == 'ar' ? 'Cairo' : 'Inter',
          ),
        ),
      ),
    );
  }
}
