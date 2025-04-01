import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ios_fl_sweet_bonanza_3290/cubit/event_cubit/event_cubit.dart';
import 'package:ios_fl_sweet_bonanza_3290/cubit/saved_objectives/saved_objectives_cubit.dart';
import 'package:ios_fl_sweet_bonanza_3290/pages/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CalendarEventCubit()),
        BlocProvider(create: (context) => SavedObjectivesCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/main_background.png',
                  fit: BoxFit.cover,
                ),
              ),
              child ?? const SizedBox.shrink(),
            ],
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFF9EE1),),
          scaffoldBackgroundColor: Color(0xFFFF9EE1),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
