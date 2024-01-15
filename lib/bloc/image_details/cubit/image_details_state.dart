part of 'image_details_cubit.dart';

@immutable
abstract class ImageDetailsState {}

class ImageDetailsInitial extends ImageDetailsState {}

class ImageDetailsLoaded extends ImageDetailsState {
  final ImageModel image;

  ImageDetailsLoaded({required this.image});
}

class ImageErrorLoading extends ImageDetailsState {}

class ImageDetailsLoading extends ImageDetailsState {}
