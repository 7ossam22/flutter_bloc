// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../logic/implementation/pixiv_logic.dart';
import '../../model/image.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PixivLogicImp logic = PixivLogicImp();
  List<ImageModel> images = [];

  HomeCubit() : super(HomeInitial());

  Future<List<ImageModel>> getAllImages(String query) async {
    emit(HomeLoadingState());
    final images = await logic.getData(logic.getHeader(), query, null, "");
    if (images.isNotEmpty) {
      for (ImageModel image in images) {
        this.images.add(image);
      }
      emit(HomeListLoaded(allImages: this.images));
    } else {
      emit(HomeErrorState());
    }
    return this.images;
  }
}
