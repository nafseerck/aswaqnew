import 'dart:convert';

BannerModel bannerModelFromJson(String str) => BannerModel.fromJson(json.decode(str));

String bannerModelToJson(BannerModel data) => json.encode(data.toJson());

class BannerModel {
  BannerModel({
    this.id,
    this.identifier,
    this.title,
    this.content,
    this.creationTime,
    this.updateTime,
    this.active,
  });

  int id;
  String identifier;
  String title;
  String content;
  DateTime creationTime;
  DateTime updateTime;
  bool active;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
    id: json["id"],
    identifier: json["identifier"],
    title: json["title"],
    content: json["content"],
    creationTime: DateTime.parse(json["creation_time"]),
    updateTime: DateTime.parse(json["update_time"]),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "identifier": identifier,
    "title": title,
    "content": content,
    "creation_time": creationTime.toIso8601String(),
    "update_time": updateTime.toIso8601String(),
    "active": active,
  };
}
