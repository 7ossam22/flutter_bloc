part of 'images_bloc.dart';

sealed class ImagesEvent {}

class ImagesLoadedEvent extends ImagesEvent {}

class ImageErrorEvent extends ImagesEvent {}
