part of 'images_bloc.dart';

sealed class ImagesEvent {}

class ImagesRequestedWithQuery extends ImagesEvent {
  final String query;

  ImagesRequestedWithQuery({required this.query});
}

class ImagesClearRequested extends ImagesEvent {}
