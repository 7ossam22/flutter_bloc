// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scrappler_modified/logic/implementation/data_base_logic.dart';

import '../../../logic/implementation/pixiv_logic.dart';
import '../../../model/image.dart';

part 'image_details_state.dart';

class ImageDetailsCubit extends Cubit<ImageDetailsState> {
  final PixivLogicImp logic = PixivLogicImp();
  final DataBaseLogicImp db = DataBaseLogicImp();

  ImageDetailsCubit() : super(ImageDetailsInitial());

  Future<ImageModel> getModelItem(ImageModel modelItem) async {
    emit(ImageDetailsLoading());
    final image = await logic.getOriginalData(modelItem);
    if (image.url.isNotEmpty) {
      emit(ImageDetailsLoaded(image: image));
    } else {
      emit(ImageErrorLoading());
    }
    return image;
  }

  dispose() => close();
}
