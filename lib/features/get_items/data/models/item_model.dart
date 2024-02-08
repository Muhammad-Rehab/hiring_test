
import 'package:equatable/equatable.dart';

class ItemModel extends Equatable{
  final int id ;
  final String fistName ;
  final String lastName ;
  final String ? description ;
  final String ? url ;

  const ItemModel({
    required this.id,
    required this.fistName,
    required this.lastName,
    required this.description,
    required this.url,
});

  factory ItemModel.fromJson(Map<String,dynamic>json){
    List<String> name = json['full_name'].split('/');
    return ItemModel(
      id : json['id'],
      fistName: name.last,
      lastName: name.first,
      description: json['description'],
      url: json['url']
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id": id,
      "full_name": "$lastName/$fistName",
      "description": description,
      "url": url
    };
  }

  @override
  List<Object?> get props => [id];

}