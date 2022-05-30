import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  String status;
  String message;
  List<DataItem> data;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        status: json["status"],
        message: json["message"],
        data: List<DataItem>.from(json["data"].map((x) => DataItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataItem {
  DataItem({
    required this.id,
    required this.title,
    required this.images,
    required this.description,
  });

  int id;
  String title;
  String? images;
  String description;

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        id: json["id"],
        title: json["title"],
        images: json["images"] is String ? json["images"] : json["images"][0],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "images": images,
        "description": description,
      };
}
