import 'dart:io';

import 'package:scrappler_modified/model/image.dart';

abstract class CoreLogic {
  Map<String, String> getHeader();

  Future<Directory> initDirectory(String folderName);

  Future<List<ImageModel>> getData(Map<String, String> header, String query,
      int? pageNumber, String whereToSearch);

  void clearSearchData();

  Future<ImageModel> getOriginalData(ImageModel modelItem);
}
