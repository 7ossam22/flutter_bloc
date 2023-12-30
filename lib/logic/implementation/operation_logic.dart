import 'dart:io';

import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../model/image.dart';
import '../interface/operation_logic.dart';

class OperationLogicImp implements IOperationLogic {
  final _loadingProgress = BehaviorSubject<double?>.seeded(0);

  @override
  Future<void> downloadData(Map<String, String> header, ImageModel modelItem,
      Directory directoryInitialized) async {
    var dir = await AndroidPathProvider.downloadsPath;
    String saveName = "${modelItem.title.replaceAll("/", "")}.png";
    String savePath = "$dir/Scrappler/$saveName";
    try {
      await Dio().download(modelItem.url[0], savePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          print("${(received / total * 100).toStringAsFixed(0)}%");
          _loadingProgress.add((received / total) * 100);
        }
      }, options: Options(headers: modelItem.header));
      print("File is saved to download folder.");
      _loadingProgress.add(null);
    } on DioError catch (e) {
      print(e.message);
      _loadingProgress.add(null);
    }
  }

  @override
  Stream<double?> get downloadingProgress => _loadingProgress;
}
