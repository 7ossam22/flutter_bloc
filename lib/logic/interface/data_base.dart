import '../../model/image.dart';

abstract class IDataBase {
  Future<bool> insertItemIntoModelDB(ImageModel item);

  Future<bool> deleteItemFromModelDB(ImageModel item);

  Future<List<ImageModel>> getAllItemsFromModelDB();

  Stream<List<ImageModel>> get modelItemsList;
}
