import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scrappler_modified/utils/routs.dart';

void main() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  runApp(MyApp(
    appRouting: AppRouting(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouting appRouting;

  const MyApp({super.key, required this.appRouting});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.black, fontSize: 16)),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Jenine",
              fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(
              color: Colors.black, fontSize: 18, fontFamily: "Almarai"),
          bodySmall: TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: "Almarai"),
          displayLarge: TextStyle(
              fontFamily: "Jenine",
              fontSize: 60,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              fontFamily: "Jenine", fontSize: 30, color: Colors.black),
          displaySmall: TextStyle(
              fontFamily: "Jenine", fontSize: 30, color: Colors.black),
        ),
        colorScheme: Theme.of(context)
            .colorScheme
            .copyWith(secondary: Colors.black)
            .copyWith(background: Colors.white),
      ),
      darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "Jenine",
                fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: "Almarai"),
            bodySmall: TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: "Almarai"),
            displayLarge: TextStyle(
                fontFamily: "Jenine",
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            displayMedium: TextStyle(
                fontFamily: "Jenine", fontSize: 30, color: Colors.white),
            displaySmall: TextStyle(
                fontFamily: "Jenine", fontSize: 30, color: Colors.white),
          ),
          colorScheme: Theme.of(context)
              .colorScheme
              .copyWith(secondary: Colors.white)
              .copyWith(background: Colors.black)),
      onGenerateRoute: appRouting.generateRout,
      initialRoute: '/',
    );
  }
}
