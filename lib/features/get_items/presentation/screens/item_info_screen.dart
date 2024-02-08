import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_cubit.dart';
import 'package:hiring_test/features/get_items/presentation/cubit/get_item_state.dart';
import 'package:hiring_test/features/get_items/presentation/widgets/item_info_record.dart';
import 'package:hiring_test/features/theme/presentation/cubit/theme_cubit.dart';

class ItemInfoScreen extends StatefulWidget {
  const ItemInfoScreen({Key? key}) : super(key: key);

  @override
  State<ItemInfoScreen> createState() => _ItemInfoScreenState();
}

class _ItemInfoScreenState extends State<ItemInfoScreen> with WidgetsBindingObserver{

  String? url;

  getItemInfoModel() {
    BlocProvider.of<GetItemCubit>(context).getItemsInfo(url!);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    Brightness brightness = Theme.of(context).brightness;
    BlocProvider.of<ThemeCubit>(context).toggleTheme(brightness == Brightness.dark);
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      url = ModalRoute.of(context)!.settings.arguments as String;
      getItemInfoModel();
    }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        child: url == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Warning",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No data found for this item",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Back",
                          style: Theme.of(context).textTheme.titleMedium,
                        )),
                  )
                ],
              )
            : BlocBuilder<GetItemCubit, GetItemState>(builder: (context, state) {
                if (state is LoadingItemInfoState) {
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
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  );
                } else if (state is LoadedItemInfoState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50,),
                      // name record
                      Row(
                        children: [
                          Text(
                            state.itemInfoModel.name,
                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColor),
                          ),
                          const Spacer(),
                          const Icon(Icons.star),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("${state.itemInfoModel.forks}"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // owner text
                      ItemInfoRecord(value: state.itemInfoModel.ownerName, title: "Owner:  "),
                      // watchers
                      ItemInfoRecord(value: state.itemInfoModel.watchers.toString(), title: "Watchers:  "),
                      // forks
                      ItemInfoRecord(value: state.itemInfoModel.forks.toString(), title: "Forks:  "),
                      // subscribers
                      ItemInfoRecord(value: state.itemInfoModel.subscribers.toString(), title: "Subscribers:  "),
                      // created at
                      ItemInfoRecord(value: state.itemInfoModel.createdAt, title: "Created at:  "),
                      // updated at
                      ItemInfoRecord(value: state.itemInfoModel.updatedAt, title: "Updated at:  "),
                      const SizedBox(height: 10,),
                      // Link text
                      Text("URL: ",style: Theme.of(context).textTheme.bodyLarge,),
                      const SizedBox(height: 5,),
                      Text(state.itemInfoModel.url,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).primaryColor),),
                      const SizedBox(height: 10,),
                      // description
                      ItemInfoRecord(value: state.itemInfoModel.description, title: "Description:  "),
                      const SizedBox(height: 10,),
                      // button
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text(
                                "Back",
                                style: Theme.of(context).textTheme.titleMedium,
                              )),
                        ),
                      )
                    ],
                  );
                }
                return Container();
              }),
      ),
    );
  }
}
