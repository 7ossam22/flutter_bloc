part of 'images_bloc.dart';

abstract class ImagesState {}

class ImagesInitial extends ImagesState {
  final List<ImageModel> images;

  ImagesInitial({required this.images});
}

class ImagesLoaded extends ImagesState {
  final List<ImageModel> images;

  ImagesLoaded({required this.images});
}

class ImageError extends ImagesState {}
