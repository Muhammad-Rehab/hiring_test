import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/core/errors/handle_error.dart';
import 'package:hiring_test/features/get_items/data/models/item_model.dart';
import 'package:hiring_test/features/get_items/data/repository_imp/get_item_repository.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_state.dart';

class GetItemCubit extends Cubit<GetItemState> {
  GetItemRepository getItemRepository;

  GetItemCubit({required this.getItemRepository}) : super(InitialGetItemState());

  Future<void> getItems() async {
    emit(LoadingItemsState());
    final Either<Exception, List<ItemModel>> response = await getItemRepository.getItems();
    emit(
      response.fold(
        (error) {
          ErrorHandler.handle(error);
          return ErrorItemState(errorModel: ErrorHandler.errorModel);
        },
        (items) {
          print(items);
          return LoadedItemState(items: items);
        },
      ),
    );
  }

  Future<void> getItemsInfo(String url, int id) async {
    emit(LoadingItemInfoState());
    final response = await getItemRepository.getItemInfo(url, id);
    emit(
      response.fold(
        (error) {
          ErrorHandler.handle(error);
          return ErrorItemState(errorModel: ErrorHandler.errorModel);
        },
        (itemInfoModel) => LoadedItemInfoState(itemInfoModel: itemInfoModel),
      ),
    );
  }
}
