class TopDoctor {
  final int id;
  final String name;
  final String image;
  final String specialist;
  final String available;

  const TopDoctor({
    required this.id,
    required this.name,
    required this.image,
    required this.specialist,
    required this.available,
  });
}

class TopDoctorList {
  static List<TopDoctor> list() {
    const data = <TopDoctor>[
      TopDoctor(
          id: 1,
          name: 'Dr. Jobas Kign',
          image: 'assets/images/top_doctor/1.png',
          specialist: 'Dental Specialist',
          available: '12:00pm - 03:00pm'),
      TopDoctor(
          id: 2,
          name: 'Dr. Zasica Nobo',
          image: 'assets/images/top_doctor/2.png',
          specialist: 'Gynecologists',
          available: '05:00pm - 08:00pm'),
    ];
    return data;
  }
}
