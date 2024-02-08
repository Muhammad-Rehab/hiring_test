import 'package:equatable/equatable.dart';


class ItemInfoModel extends Equatable {
  final int id;
  final String name ;
  final String ownerName;
  final int watchers;
  final int forks;
  final int subscribers;
  final String createdAt;
  final String updatedAt;
  final String url;
  final String description;

  const ItemInfoModel({
    required this.id,
    required this.description,
    required this.name,
    required this.ownerName,
    required this.watchers,
    required this.forks,
    required this.subscribers,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemInfoModel.fromJson(Map<String, dynamic> json) {
    List<String> name = json['full_name'].split('/');
    return ItemInfoModel(
      id: json['id'],
      name: name.last,
      ownerName: name.first,
      description: json['description'],
      watchers: json['watchers'],
      forks: json['forks_count'],
      subscribers: json['subscribers_count'],
      url: json['url'],
      createdAt: json['created_at'].substring(0, 10),
      updatedAt: json['updated_at'].substring(0, 10),
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "id":id,
      "description":description,
      "full_name": "$ownerName/$name",
      "watchers":watchers,
      "forks_count": forks,
      "subscribers_count":subscribers,
      "url":url,
      "created_at":createdAt,
      "updated_at": updatedAt,
    };
  }

  @override
  List<Object?> get props => [id];
}
