import 'dart:convert';

class FixedDeparturesModel {
  bool status;
  String message;
  Data data;

  FixedDeparturesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FixedDeparturesModel.fromJson(String str) =>
      FixedDeparturesModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FixedDeparturesModel.fromMap(Map<String, dynamic> json) =>
      FixedDeparturesModel(
        status: json["status"],
        message: json["message"],
        data: Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };
}

class Data {
  List<FixedDeparture> fixedDepartures;

  Data({
    required this.fixedDepartures,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        fixedDepartures: List<FixedDeparture>.from(
            json["fixed_departures"].map((x) => FixedDeparture.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "fixed_departures":
            List<dynamic>.from(fixedDepartures.map((x) => x.toMap())),
      };
}

class FixedDeparture {
  int id;
  dynamic title;
  dynamic from;
  dynamic to;
  dynamic travelTo;
  dynamic price;
  int? rating;
  List<String> description;
  int status;
  int tagStatus;
  DateTime createdAt;
  DateTime updatedAt;

  FixedDeparture({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.travelTo,
    required this.price,
    this.rating,
    required this.description,
    required this.status,
    required this.tagStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FixedDeparture.fromJson(String str) =>
      FixedDeparture.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FixedDeparture.fromMap(Map<String, dynamic> json) => FixedDeparture(
        id: json["id"],
        title: json["title"],
        from: json["from"],
        to: json["to"],
        travelTo: json["travel_to"],
        price: json["price"],
        rating: json["rating"],
        description: List<String>.from(json["description"].map((x) => x)),
        status: json["status"],
        tagStatus: json["tag_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "from": from,
        "to": to,
        "travel_to": travelTo,
        "price": price,
        "rating": rating,
        "description": List<dynamic>.from(description.map((x) => x)),
        "status": status,
        "tag_status": tagStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
