import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrappler_modified/bloc/home/bloc/images_bloc.dart';
import 'package:scrappler_modified/bloc/splash/splash_cubit.dart';
import 'package:scrappler_modified/model/image.dart';
import 'package:scrappler_modified/screens/coming_soon/coming_soon.dart';
import 'package:scrappler_modified/screens/home/home.dart';
import 'package:scrappler_modified/screens/image_details/image_details.dart';
import 'package:scrappler_modified/screens/splash/splash_screen.dart';

import '../bloc/image_details/bloc/image_details_bloc.dart';

class AppRouting {
  Route generateRout(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SplashCubit(),
                  child: const SplashScreen(),
                ));
      case '/home':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ImagesBloc(),
                  child: const HomeScreen(),
                ));
      case '/image_details':
        final imageArgs = settings.arguments as ImageModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ImageDetailsBloc(),
                  child: ImageDetailsScreen(image: imageArgs),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Container(
                  color: Colors.white,
                  child: const ComingSoon(),
                ));
    }
  }
}
