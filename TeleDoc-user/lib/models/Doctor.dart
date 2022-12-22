class Doctor {
  int id = 0;
  String name = "";
  String clinic_address = "";
  String specialist = "";
  String profile_pic = "";
  int rating = 0;

  // Constructor
  Doctor(int id, String name, String clinic_address, String specialist,
      String profile_pic, int rating) {
    this.id = id;
    this.name = name;
    this.clinic_address = clinic_address;
    this.specialist = specialist;
    this.profile_pic = profile_pic;
    this.rating = rating;
  }

  Doctor.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        clinic_address = json['clinic_address'],
        specialist = json['specialist'],
        profile_pic = json['profile_pic'],
        rating = json['rating'];
}
