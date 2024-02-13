part of 'image_list_bloc.dart';

@immutable
abstract class ImageListEvent {}

class ImageListOriginalDataRequested extends ImageListEvent {
  final ImageModel imageData;

  ImageListOriginalDataRequested({required this.imageData});
}
