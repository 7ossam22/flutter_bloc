import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrappler_modified/bloc/home/cubit/home_cubit.dart';
import 'package:scrappler_modified/bloc/image_details/image_details_cubit.dart';
import 'package:scrappler_modified/logic/implementation/data_base_logic.dart';
import 'package:scrappler_modified/model/image.dart';
import 'package:scrappler_modified/screens/coming_soon/coming_soon.dart';
import 'package:scrappler_modified/screens/home/home.dart';
import 'package:scrappler_modified/screens/image_details/image_details.dart';
import 'package:scrappler_modified/screens/splash/splash_screen.dart';

import '../logic/implementation/pixiv_logic.dart';

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
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/home':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen());
      case '/image_details':
        final imageArgs = settings.arguments as ImageModel;
        return MaterialPageRoute(
            builder: (_) => ImageDetailsScreen(image: imageArgs));
      default:
        return MaterialPageRoute(
            builder: (_) => Container(
                  color: Colors.white,
                  child: const ComingSoon(),
                ));
    }
  }
}
