import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:scrappler_modified/model/image.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../interface/data_base.dart';

class DataBaseLogicImp implements IDataBase {
  final _modelItemListStream = BehaviorSubject<List<ImageModel>>.seeded([]);
  late List<ImageModel> _modelItemsList;
  late Future initFuture;

  // ignore: non_constant_identifier_names
  DataBaseLogicImp() {
    initFuture = init();
  }

  Future<void> init() async {
    _modelItemListStream.add([]);
    final pref = await SharedPreferences.getInstance();
    final modelItemString = pref.getString("modelItem");
    if (modelItemString != null) {
      _modelItemsList = [];
      try {
        var jsonObj = jsonDecode(modelItemString);
        jsonObj
            .map((jsonMap) => _modelItemsList.add(ImageModel(
                id: jsonMap["id"],
                title: jsonMap["title"],
                url: jsonMap["url"]?.map<String>((e) => e.toString()).toList(),
                lastElementId: jsonMap["ts"],
                isFavorite: jsonMap["favorite"],
                header: jsonMap["header"].map<String, String>(
                    (k, v) => MapEntry(k.toString(), v.toString())))))
            .toList();
      } catch (e) {
        _modelItemsList = [];
      }
    } else {
      _modelItemsList = [];
    }
    _modelItemListStream.add(_modelItemsList);
  }

  Future<void> save() async {
    await Future.wait([initFuture]);
    final pref = await SharedPreferences.getInstance();
    await pref.setString("modelItem",
        jsonEncode(_modelItemsList.map((e) => e.toJson()).toList()));
  }

  @override
  Future<List<ImageModel>> getAllItemsFromModelDB() async {
    await Future.wait([initFuture]);
    return _modelItemsList;
  }

  @override
  Future<bool> insertItemIntoModelDB(ImageModel item) async {
    await Future.wait([initFuture]);
    _modelItemsList.add(item);
    _modelItemListStream.add([]);
    await save();
    _modelItemListStream.add(_modelItemsList);
    return true;
  }

  @override
  Future<bool> deleteItemFromModelDB(ImageModel item) async {
    await Future.wait([initFuture]);
    final res = _modelItemsList.remove(item);
    _modelItemListStream.add([]);
    await save();
    _modelItemListStream.add(_modelItemsList);
    return res;
  }

  @override
  Stream<List<ImageModel>> get modelItemsList => _modelItemListStream;
}
