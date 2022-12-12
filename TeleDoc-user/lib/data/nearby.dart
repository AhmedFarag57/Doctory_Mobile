class Nearby {
  final int id;
  final String name;
  final String image;
  final String specialist;
  final String available;
  final String address;

  const Nearby({this.id, this.name, this.image, this.specialist, this.available, this.address});
}

class NearbyList {
  static List<Nearby> list() {
    const data = <Nearby> [
      Nearby(
          id: 1,
          name: 'Dr. Tomas Khushiya',
          image: 'assets/images/nearby/1.png',
          specialist: 'Liver Specialist',
          available: '12:00pm - 03:00pm',
          address: 'Regent Hospital'
      ),
      Nearby(
          id: 2,
          name: 'Dr. Zecop Winner',
          image: 'assets/images/nearby/2.png',
          specialist: 'Gynecologists',
          available: '05:00pm - 08:00pm',
          address: 'Modern Hospital'
      ),
      Nearby(
          id: 3,
          name: 'Dr. Jabed Patowari',
          image: 'assets/images/nearby/3.png',
          specialist: 'Medicine Specialist',
          available: '12:00pm - 03:00pm',
          address: 'Regent Hospital'
      ),
      Nearby(
          id: 4,
          name: 'Dr. Toma Mirza',
          image: 'assets/images/nearby/4.png',
          specialist: 'Gynecologists',
          available: '05:00pm - 08:00pm',
          address: 'Modern Hospital'
      ),
    ];
    return data;
  }
}