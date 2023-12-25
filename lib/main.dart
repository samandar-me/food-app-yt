import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app_yt/core/app_router.dart';
import 'package:food_app_yt/data/manager/auth_manager.dart';
import 'package:food_app_yt/presentation/bloc/auth/auth_bloc.dart';
import 'package:food_app_yt/presentation/bloc/recipes/recipe_bloc.dart';
import 'di/injection_container.dart' as di;

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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<RecipeBloc>()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0)
          ), child: child!);
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xDD0F3B08))
        )
      ),
    );
  }
}

