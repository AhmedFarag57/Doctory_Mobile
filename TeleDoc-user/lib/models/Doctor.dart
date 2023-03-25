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


/*
class Doctor {
  int id = 0;
  int user_id = 0;
  String name = "";
  String email = "";
  String phone_number = "";
  String gender = "";
  String ssn = "";
  int accepted = 0;
  int session_price = 0;
  String date_of_birth = "";
  bool isDoctor = false;
  bool blocked = false;
  String clinic_address = "";
  String profile_pic = "";
  int rating = 0;

  // Constructor
  Doctor(
      int id,
      int user_id,
      String name,
      String email,
      String phone_number,
      String gender,
      String clinic_address,
      String ssn,
      int accepted,
      int session_price,
      String date_of_birth,
      bool isDoctor,
      bool blocked,
      String profile_pic,
      int rating) {
    this.id = id;
    this.user_id = user_id;
    this.name = name;
    this.email = email;
    this.phone_number = phone_number;
    this.gender = gender;
    this.ssn = ssn;
    this.accepted = accepted;
    this.session_price = session_price;
    this.date_of_birth = date_of_birth;
    this.isDoctor = isDoctor;
    this.blocked = blocked;
    this.clinic_address = clinic_address;
    this.profile_pic = profile_pic;
    this.rating = rating;
  }

  Doctor.fromJson(Map json)
      : id = json['id'],
        user_id = json['user_id'],
        phone_number = json['phone_number'],
        ssn = json['ssn'],
        accepted = json['accepted'],
        session_price = json['session_price'],
        email = json['email'],
        name = json['name'],
        date_of_birth = json['date_of_birth'],
        isDoctor = json['isDoctor'],
        gender = json['gender'],
        blocked = json['blocked'],
        clinic_address = json['clinic_address'],
        profile_pic = json['profile_pic'],
        rating = json['rating'];
}
*/
