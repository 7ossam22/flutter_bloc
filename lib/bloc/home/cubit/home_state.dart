part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeListLoaded extends HomeState {
  final List<ImageModel> allImages;

  HomeListLoaded({required this.allImages});

  List<ImageModel> get images => allImages;
}

class HomeErrorState extends HomeState {}

class HomeLoadingState extends HomeState {}
