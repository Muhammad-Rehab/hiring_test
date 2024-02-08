

import 'package:hiring_test/core/errors/error_model.dart';
import 'package:hiring_test/features/get_items/data/models/item_info_model.dart';
import 'package:hiring_test/features/get_items/data/models/item_model.dart';

abstract class GetItemState {}

class InitialGetItemState extends GetItemState {}

class LoadingItemsState extends GetItemState {}

class LoadedItemState extends GetItemState {
  List<ItemModel> items ;
  LoadedItemState({required this.items});
}

class LoadingItemInfoState extends GetItemState {}

class LoadedItemInfoState extends GetItemState {
  ItemInfoModel itemInfoModel ;
  LoadedItemInfoState({required this.itemInfoModel});
}

class ErrorItemState extends GetItemState {
  ErrorModel errorModel ;
  ErrorItemState({required this.errorModel});
}