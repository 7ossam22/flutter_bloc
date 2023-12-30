import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'json_converter/json_converter.dart';

class ImageModel implements IJsonSerializable {
  final String id;
  final String title;
  List<String> url;
  final int subImagesSize;
  List<String>? subImages;
  final int lastElementId;
  bool? isFavorite;
  Map<String, String> header;

  ImageModel(
      {required this.id,
      required this.title,
      required this.url,
      required this.lastElementId,
      this.subImagesSize = 1,
      this.subImages,
      required this.isFavorite,
      required this.header});

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "title": title,
        "ts": lastElementId,
        "favorite": isFavorite,
        "header": header
      };

  String getUrlString(String url) {
    return url;
  }

  Future<Uint8List> getUrlUInt8list(String url) async {
    var res = await http.get(Uri.parse(url));

    return res.bodyBytes;
  }
}

class ModelItemFactory implements IModelFactory<ImageModel> {
  @override
  ImageModel fromJson(Map<String, dynamic> jsonMap) => ImageModel(
      id: jsonMap["_id"],
      title: jsonMap["_id"] + " " + jsonMap["context"],
      url: jsonMap["medias"]?.map<String>((e) => e["url"].toString()).toList(),
      lastElementId: jsonMap["ts"],
      isFavorite: jsonMap["favorite"],
      header: jsonMap["header"]);
}
