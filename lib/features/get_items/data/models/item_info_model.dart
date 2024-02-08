import 'package:equatable/equatable.dart';


class ItemInfoModel extends Equatable {
  final int id;
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
    required this.ownerName,
    required this.watchers,
    required this.forks,
    required this.subscribers,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ItemInfoModel.fromJson(Map<String, dynamic> json) {
    return ItemInfoModel(
      id: json['id'],
      description: json['description'],
      ownerName: json['name'],
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
      "name": ownerName,
      "watchers":watchers,
      "fork": forks,
      "subscribers":subscribers,
      "url":url,
      "created_at":createdAt,
      "updated_at": updatedAt,
    };
  }

  @override
  List<Object?> get props => [id];
}
