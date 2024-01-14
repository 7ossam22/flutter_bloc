import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import '../../logic/implementation/data_base_logic.dart';
import '../../logic/implementation/operation_logic.dart';
import '../../logic/implementation/pixiv_logic.dart';
import '../../logic/interface/core_logic.dart';
import '../../logic/interface/data_base.dart';
import '../../logic/interface/operation_logic.dart';

part 'splash_state.dart';

enum EngineToSearch {
  artStation,
  pixiv,
  fetcherX,
  fappelo,
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void onNavigation(EngineToSearch task, BuildContext context) {
    Injector.appInstance.clearAll();
    Injector.appInstance.registerSingleton<IDataBase>(() => DataBaseLogicImp());
    Injector.appInstance
        .registerSingleton<IOperationLogic>(() => OperationLogicImp());
    switch (task) {
      case EngineToSearch.artStation:
        // Injector.appInstance
        //     .registerSingleton<CoreLogic>(() => ArtStationLogicImp());
        break;
      case EngineToSearch.pixiv:
        Injector.appInstance
            .registerSingleton<CoreLogic>(() => PixivLogicImp());
        break;
      case EngineToSearch.fetcherX:
        // Injector.appInstance
        //     .registerSingleton<CoreLogic>(() => WallPaperAbyssLogicImp());
        break;
      case EngineToSearch.fappelo:
        // Injector.appInstance
        //     .registerSingleton<CoreLogic>(() => FabbeloLogicImp());
        break;
    }
    Navigator.pushNamed(context, "/home");
  }
}
