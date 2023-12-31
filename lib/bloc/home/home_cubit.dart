import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../logic/implementation/pixiv_logic.dart';
import '../../model/image.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final PixivLogicImp logic;
  List<ImageModel> images = [];

  HomeCubit({required this.logic}) : super(HomeInitial());
  var lastItemId = 1;

  Future<List<ImageModel>> getAllImages(String query) async {
    emit(HomeLoadingState());
    final images =
        await logic.getData(logic.getHeader(), query, lastItemId, "");
    if (images.isNotEmpty) {
      for (ImageModel image in images) {
        this.images.add(image);
      }
      emit(HomeListLoaded(allImages: this.images));
      lastItemId++;
    } else {
      emit(HomeErrorState());
    }
    return this.images;
  }
}
