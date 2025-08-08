import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proo/features/home/data/datasources/home_web_service.dart';
import 'package:proo/features/home/data/models/home/home.dart';
import 'package:proo/features/home/data/repositories/repo_impl.dart';
import 'package:proo/features/home/presentation/cubit/home_cubit.dart';
import 'package:proo/features/home/presentation/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create: (context) => HomeCubit(
          HomeModel(), // Initial empty HomeModel
          RepoImpl(
            HomeWebService(),
          ), // Assuming HomeWebService is defined elsewhere
        ),
        child: HomeScreen(),
      ),
    );
  }
}
