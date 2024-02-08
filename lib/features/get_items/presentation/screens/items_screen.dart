import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/core/routing/routes.dart';
import 'package:hiring_test/features/get_items/data/models/item_model.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_cubit.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_state.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({Key? key}) : super(key: key);

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  List<ItemModel> items = [];
  List<ItemModel> filteredItems = [];
  bool isFiltered = false;
  int page = 0;
  final ScrollController scrollController = ScrollController();

  getItems() {
    BlocProvider.of<GetItemCubit>(context).getItems();
  }

  filterItems(String query) {
    setState(() {
      filteredItems = items
          .where((item) => (item.fistName.toLowerCase().contains(query.toLowerCase()) || item.lastName.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  // note that, The pagination is not necessary in terms of use in this case
  fetchMoreItems() {
    setState(() {
      filteredItems.addAll(items.sublist(page * 10, (page * 10 + 10 >= items.length) ? items.length : page * 10 + 10));
    });
    page++;
  }

  @override
  void initState() {
    getItems();
    // note that, The pagination is not necessary in terms of use in this case
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        fetchMoreItems();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "GitHub Viewer",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: BlocBuilder<GetItemCubit, GetItemState>(
          buildWhen: (previousState , currentState)=>
          (currentState is LoadingItemsState || currentState is ErrorItemState || currentState is LoadedItemState),
          builder: (context, state) {
            if (state is LoadingItemsState) {
              return Center(
                child: Text(
                  "Loading",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              );
            } else if (state is ErrorItemState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${state.errorModel.code}",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${state.errorModel.message}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              );
            } else if (state is LoadedItemState) {
              items = state.items;
              if (!isFiltered) {
                filteredItems = state.items.sublist(page * 10, page * 10 + 10);
                page++;
                isFiltered = true;
              }
              return Column(
                children: [
                  // search field
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                      onChanged: (val) {
                        filterItems(val);
                      },
                    ),
                  ),
                  // items list view
                  (filteredItems.isEmpty)
                      ? Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 40),
                          child: Text(
                            "No Data match your query",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            controller: scrollController,
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, AppRoutes.itemInfoScreenRoute,
                                  arguments: filteredItems[index].url
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 10),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.background,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        offset: const Offset(0, 4),
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        filteredItems[index].fistName,
                                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                              color: Theme.of(context).primaryColor,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        filteredItems[index].lastName,
                                        style: Theme.of(context).textTheme.titleMedium!,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        filteredItems[index].description ?? '',
                                        style: Theme.of(context).textTheme.bodyLarge!,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
