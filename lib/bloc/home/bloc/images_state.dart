part of 'images_bloc.dart';

abstract class ImagesState {}

class ImagesInitial extends ImagesState {
  ImagesInitial();
}

class ImagesLoading extends ImagesState {}

class ImagesLoaded extends ImagesState {
  final List<ImageModel> images;

  ImagesLoaded({required this.images});
}

class ImagesError extends ImagesState {
  final String err;

  ImagesError(this.err);
}
