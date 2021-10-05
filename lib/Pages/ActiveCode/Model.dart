// To parse this JSON data, do
//
//     final activeCodeModel = activeCodeModelFromJson(jsonString);

import 'dart:convert';

ActiveCodeModel activeCodeModelFromJson(String str) => ActiveCodeModel.fromJson(json.decode(str));

String activeCodeModelToJson(ActiveCodeModel data) => json.encode(data.toJson());

class ActiveCodeModel {
  ActiveCodeModel({
    this.data,
    this.status,
    this.message,
  });

  Data data;
  String status;
  String message;

  factory ActiveCodeModel.fromJson(Map<String, dynamic> json) => ActiveCodeModel(
    data: Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  Data({
    this.id,
    this.fullname,
    this.phone,
    this.email,
    this.image,
    this.token,
    this.country,
    this.city,
  });

  int id;
  String fullname;
  String phone;
  String email;
  String image;
  String token;
  dynamic country;
  dynamic city;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    fullname: json["fullname"],
    phone: json["phone"],
    email: json["email"],
    image: json["image"],
    token: json["token"],
    country: json["country"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullname": fullname,
    "phone": phone,
    "email": email,
    "image": image,
    "token": token,
    "country": country,
    "city": city,
  };
}
