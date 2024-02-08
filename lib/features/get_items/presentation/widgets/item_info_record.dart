
import 'package:flutter/material.dart';

class ItemInfoRecord extends StatelessWidget {
  const ItemInfoRecord({Key? key,required this.value,required this.title}) : super(key: key);
  final String title ;
  final String value ;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: RichText(
          text: TextSpan(children: [
            TextSpan(text: title,style: Theme.of(context).textTheme.bodyLarge,),
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color:Theme.of(context).hintColor),
            ),
          ])),
    );
  }
}
