import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_bloc.dart';
import 'package:food_app_yt/presentation/screen/main_screen.dart';
import 'package:food_app_yt/presentation/screen/onboarding_screen.dart';
import 'di/injection_container.dart' as di;
import 'package:bloc/bloc.dart';

import 'di/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  runApp(FoodApp());
}
class FoodApp extends StatelessWidget {
  FoodApp({super.key});

  final _auth = sl<AuthManager>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0)
          ), child: child!);
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x90076935))
        ),
        home: _auth.getCurrentUser() == null ? OnBoardingScreen() : MainScreen(),
      ),
    );
  }
}

