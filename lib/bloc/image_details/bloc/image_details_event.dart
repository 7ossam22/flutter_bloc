part of 'image_details_bloc.dart';

@immutable
abstract class ImageDetailsEvent {}

class ImageOriginalDataRequested extends ImageDetailsEvent {
  final ImageModel imageModel;

  ImageOriginalDataRequested({required this.imageModel});
}

class ImageAddOrRemoveToDataBaseRequested extends ImageDetailsEvent {
  final ImageModel imageModel;

  ImageAddOrRemoveToDataBaseRequested({required this.imageModel});
}

class ImageDownloadRequested extends ImageDetailsEvent {
  final ImageModel imageModel;

  ImageDownloadRequested({required this.imageModel});
}
