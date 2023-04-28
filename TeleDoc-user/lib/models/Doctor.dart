import 'dart:convert';

List<Doctor> modelUserFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));
String modelUserToJson(List<Doctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doctor {
  int id;
  String name;
  //final String email;
  // final String phone_number;
  // final int session_price;
  // final String clinic_address;

  Doctor({this.id, this.name});
  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {"id": id, "name": name};
}