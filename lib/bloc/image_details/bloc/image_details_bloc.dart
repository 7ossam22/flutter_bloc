import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/implementation/data_base_logic.dart';
import '../../../logic/implementation/pixiv_logic.dart';
import '../../../model/image.dart';

part 'image_details_event.dart';

part 'image_details_state.dart';

class ImageDetailsBloc extends Bloc<ImageDetailsEvent, ImageDetailsState> {
  final logic = PixivLogicImp();
  final db = DataBaseLogicImp();

  ImageDetailsBloc() : super(ImageDetailsInitial()) {
    on<ImageOriginalDataRequested>(_getImageOriginalData);
    on<ImageAddOrRemoveToDataBaseRequested>(_addOrRemoveImageFromDataBase);
  }

  Future<void> _getImageOriginalData(
      ImageOriginalDataRequested event, Emitter emit) async {
    emit(ImageDetailsLoading());
    try {
      final image = await logic.getOriginalData(event.imageModel);
      emit(ImageDetailsLoaded(image: image));
    } catch (e) {
      emit(ImageError(err: "Error - $e"));
    }
  }

  Future<void> _addOrRemoveImageFromDataBase(
      ImageAddOrRemoveToDataBaseRequested event, Emitter emit) async {
    switch (event.imageModel.isFavorite) {
      case true:
        {
          event.imageModel.isFavorite = !event.imageModel.isFavorite!;
          await db.deleteItemFromModelDB(event.imageModel);
          emit(ImageDataBase(
              msg: "Image ${event.imageModel.title} removed successfully",
              isAdded: false));
        }
      case false:
        {
          event.imageModel.isFavorite = !event.imageModel.isFavorite!;
          await db.insertItemIntoModelDB(event.imageModel);
          emit(ImageDataBase(
              msg: "Image ${event.imageModel.title} added successfully",
              isAdded: true));
        }
      default:
        {}
    }
    emit(ImageDetailsLoaded(image: event.imageModel));

  }
}
