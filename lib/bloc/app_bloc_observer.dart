// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("Bloc named - ${bloc.runtimeType} is created!");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("Bloc named - ${bloc.runtimeType} change is - $change!");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print(
        "Bloc named - ${bloc.runtimeType} error is - $error! with stack trace -$stackTrace");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("Bloc named - ${bloc.runtimeType} is closed!");
  }
}
