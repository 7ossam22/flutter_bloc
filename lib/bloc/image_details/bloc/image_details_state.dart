part of 'image_details_bloc.dart';

@immutable
abstract class ImageDetailsState {}

class ImageDetailsInitial extends ImageDetailsState {}

class ImageDetailsLoaded extends ImageDetailsState {
  final ImageModel image;

  ImageDetailsLoaded({required this.image});
}

class ImageError extends ImageDetailsState {
  final String err;

  ImageError({required this.err});
}

class ImageDetailsLoading extends ImageDetailsState {}

class ImageDataBase extends ImageDetailsState {
  final String msg;
  final bool isAdded;

  ImageDataBase({required this.msg, required this.isAdded});
}

class ImageDownloading extends ImageDetailsState {
  final double percentage;

  ImageDownloading({required this.percentage});
}

class ImageDownloaded extends ImageDetailsState {
  final String msg;

  ImageDownloaded({required this.msg});
}
