import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scrappler_modified/model/image.dart';

part 'image_list_event.dart';
part 'image_list_state.dart';

class ImageListBloc extends Bloc<ImageListEvent, ImageListState> {
  ImageListBloc() : super(ImageListInitial()) {
    on<ImageListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
