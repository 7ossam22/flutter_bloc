import 'package:flutter/material.dart';
import 'package:scrappler_modified/screens/splash/splash_screen.dart';

enum PagesName {
  splash,
}

class AppRouting {
  Route generateRout(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Container(
                  color: Colors.white,
                  child: const Center(child: Text("404 Page not found")),
                ));
    }
  }
}
