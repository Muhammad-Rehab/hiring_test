
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:hiring_test/core/util/app_constants.dart';
import 'package:hiring_test/features/get_items/data/models/item_info_model.dart';
import 'package:hiring_test/features/get_items/data/models/item_model.dart';

class GetItemRemoteRecourse {
  final Dio dio ;
  GetItemRemoteRecourse({required this.dio});

  Future<List<ItemModel>> getItems() async {
    final response = await dio.get(AppConstants.dataUrl);
    List<ItemModel> itemModels = [];
    for(var item in response.data){
      itemModels.add(ItemModel.fromJson(item));
    }
    return itemModels ;
  }

  Future<ItemInfoModel> getItemInfo (String url) async {
    final response = await dio.get(url);
    return ItemInfoModel.fromJson(jsonDecode(response.data));
  }
}