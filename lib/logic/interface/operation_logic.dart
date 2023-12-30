import 'dart:io';

import '../../model/image.dart';

abstract class IOperationLogic {
  Stream<double?> get downloadingProgress;

  Future<void> downloadData(
    Map<String, String> header,
    ImageModel modelItem,
    Directory directoryInitialized,
  );
}
