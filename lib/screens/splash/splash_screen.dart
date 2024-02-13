import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrappler_modified/bloc/splash/splash_cubit.dart';
import 'package:scrappler_modified/bloc/splash/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String splashScreenRoute = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Color.fromRGBO(18, 0, 66, 1),
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/logo.png",
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Welcome to Scrapler",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "A place to find a beautiful images\nand download all of them just with one click!",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            BlocBuilder<SplashCubit, SplashState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/fetcher.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/artstation.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    InkWell(
                      onTap: () => context
                          .read<SplashCubit>()
                          .onNavigation(EngineToSearch.pixiv, context),
                      child: Image.asset(
                        "assets/pixiv.png",
                        width: 50,
                        height: 50,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Image.asset(
                        "assets/uwu.gif",
                        width: 50,
                        height: 50,
                      ),
                    )
                  ],
                );
              },
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
