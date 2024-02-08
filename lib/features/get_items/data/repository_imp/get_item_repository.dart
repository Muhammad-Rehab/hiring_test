
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hiring_test/core/errors/cash_errors.dart';
import 'package:hiring_test/features/get_items/data/models/item_info_model.dart';
import 'package:hiring_test/features/get_items/data/models/item_model.dart';
import 'package:hiring_test/features/get_items/data/recources/local_data.dart';
import 'package:hiring_test/features/get_items/data/recources/remote_data.dart';
import 'package:sqflite/sqflite.dart';

class GetItemRepository {
  final Connectivity connectivity ;
  GetItemRemoteRecourse getItemRemoteRecourse;
  GetItemsLocalResource getItemsLocalResource ;
  GetItemRepository({ required this.connectivity, required this.getItemsLocalResource,required this.getItemRemoteRecourse});

  Future<Either<Exception,List<ItemModel>>> getItems () async {
   try{
     final connectivityResult = await (connectivity.checkConnectivity());
     if(connectivityResult != ConnectivityResult.none){
       List<ItemModel> items = await getItemRemoteRecourse.getItems();
       await getItemsLocalResource.insertItems(items);
       return Right(items);
     }else {
       return Right(await getItemsLocalResource.fetchItems());
     }
   } catch(exception){
     debugPrint("error : getItemRepo getItems()");
     debugPrint(exception.toString());
     if(exception is DioException){
       return Left(exception);
     }else if (exception is DatabaseException){
       return Left(CashError());
     }else {
       return Left(DefaultError());
     }
   }
  }

  Future<Either<Exception,ItemInfoModel>> getItemInfo(String url) async {
    try{
      final connectivityResult = await (connectivity.checkConnectivity());
      if(connectivityResult != ConnectivityResult.none){
        ItemInfoModel itemInfo = await getItemRemoteRecourse.getItemInfo(url);
        await getItemsLocalResource.insertItemInfo(itemInfo);
        return Right(itemInfo);
      }else {
        return Right(await getItemsLocalResource.fetchItemInfo(url));
      }
    } catch(exception){
      debugPrint("error : getItemRepo getItemInfo()");
      debugPrint(exception.toString());
      if(exception is DioException){
        return Left(exception);
      }else if (exception is DatabaseException){
        return Left(CashError());
      }else {
        return Left(DefaultError());
      }
    }
  }


}