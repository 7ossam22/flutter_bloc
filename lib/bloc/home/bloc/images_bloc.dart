import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrappler_modified/logic/implementation/pixiv_logic.dart';

import '../../../model/image.dart';

part 'images_event.dart';

part 'images_state.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final logic = PixivLogicImp();
  List<ImageModel> images = [];

  ImagesBloc() : super(ImagesInitial(images: [])) {
    on<ImagesEvent>((event, emit) {
      // TODO: implement event handler
      emit(ImagesLoaded(images: images));
    });
  }
}
