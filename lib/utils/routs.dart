import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrappler_modified/bloc/home/cubit/home_cubit.dart';
import 'package:scrappler_modified/bloc/splash/splash_cubit.dart';
import 'package:scrappler_modified/model/image.dart';
import 'package:scrappler_modified/screens/coming_soon/coming_soon.dart';
import 'package:scrappler_modified/screens/home/home.dart';
import 'package:scrappler_modified/screens/image_details/image_details.dart';
import 'package:scrappler_modified/screens/splash/splash_screen.dart';

import '../bloc/image_details/image_details_cubit.dart';

class AppRouting {
  // late HomeCubit homeCubit;
  // // late ImageDetailsCubit imageDetailsCubit;
  // late DataBaseLogicImp db;
  // late PixivLogicImp logic;

  // AppRouting() {
  //   _init();
  // }

  // _init() {
  //   logic = PixivLogicImp();
  //   // db = DataBaseLogicImp();
  //   homeCubit = HomeCubit(logic: logic);
  //   // imageDetailsCubit = ImageDetailsCubit(logic: logic, db: db);
  // }

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
                  create: (context) => HomeCubit(),
                  child: const HomeScreen(),
                ));
      case '/image_details':
        final imageArgs = settings.arguments as ImageModel;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => ImageDetailsCubit(),
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
