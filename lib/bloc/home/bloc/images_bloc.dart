import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrappler_modified/logic/implementation/pixiv_logic.dart';

import '../../../model/image.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final logic = PixivLogicImp();
  List<ImageModel> images = [];

  ImagesBloc() : super(ImagesInitial()) {
    on<ImagesRequestedWithQuery>(_getImagesData);
    on<ImagesClearRequested>(_clearImages);
  }

  Future<void> _getImagesData(
      ImagesRequestedWithQuery event, Emitter emit) async {
    if (event.query.isEmpty) {
      emit(ImagesError("Search keyword cannot be empty"));
      return;
    }
    emit(ImagesLoading());
    try {
      final images =
          await logic.getData(logic.getHeader(), event.query, null, "");
      if (images.isNotEmpty) {
        for (ImageModel image in images) {
          this.images.add(image);
        }
        emit(ImagesLoaded(images: this.images));
      }
    } catch (e) {
      emit(ImagesError("Failed to load images - ${e.toString()}"));
    }
  }

  void _clearImages(ImagesClearRequested event, Emitter emit) {
    images = [];
    logic.clearSearchData();
    emit(ImagesLoaded(images: images));
  }
}
