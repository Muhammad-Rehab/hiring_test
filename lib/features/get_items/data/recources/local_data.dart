import 'package:hiring_test/core/util/app_constants.dart';
import 'package:hiring_test/features/get_items/data/models/item_info_model.dart';
import 'package:hiring_test/features/get_items/data/models/item_model.dart';
import 'package:sqflite/sqflite.dart';

class GetItemsLocalResource {
  Database database;

  GetItemsLocalResource({required this.database});

  Future<List<ItemModel>> fetchItems() async {
    Database db = await openDatabase(database.path);
    List<Map<String, dynamic>> list = await db.query(AppConstants.itemsTable);
    List<ItemModel> items = [];
    for (var item in list) {
      items.add(ItemModel.fromJson(item));
    }
    await db.close();
    return items;
  }

  Future<ItemInfoModel> fetchItemInfo(String url) async {
    Database db = await openDatabase(database.path);
    List<Map<String, dynamic>> item = await db.query(AppConstants.itemsInfoTable, where: "url = $url");
    await db.close();
    return ItemInfoModel.fromJson(item.first);
  }

  insertItems(List<ItemModel> items) async {
    Database db = await openDatabase(database.path);
    for (var element in items) {
      await db.insert(AppConstants.itemsTable, element.toJson(), conflictAlgorithm: ConflictAlgorithm.ignore);
    }
    await db.close();
  }

  insertItemInfo(ItemInfoModel itemInfoModel) async {
    Database db = await openDatabase(database.path);
    await db.insert(AppConstants.itemsInfoTable, itemInfoModel.toJson(),conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.close();
  }
}
