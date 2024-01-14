// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:bloc/bloc.dart';
import 'package:injector/injector.dart';
import 'package:meta/meta.dart';

import '../../../logic/interface/core_logic.dart';
import '../../../model/image.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final logic = Injector.appInstance.get<CoreLogic>();
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
      addError("Images list is empty");
      emit(HomeErrorState());
    }
    return this.images;
  }

  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);
    print("Home Cubit State changed - $change");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("Home Cubit error - $error");
  }

  clear() {
    images.clear();
  }
}
