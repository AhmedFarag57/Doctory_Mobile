class Ambulance {
  final int id;
  final String name;
  final String image;
  final String hotLine;
  final String address;
  final String time;

  const Ambulance(
      {required this.id,
      required this.name,
      required this.image,
      required this.hotLine,
      required this.address,
      required this.time});
}

class AmbulanceList {
  static List<Ambulance> list() {
    const data = <Ambulance>[
      Ambulance(
          id: 1,
          name: 'Bd Ambulance',
          image: 'assets/images/ambulance/1.png',
          hotLine: '1245',
          address: 'Captown City 2454/2',
          time: '20'),
      Ambulance(
          id: 2,
          name: 'Labica Service',
          image: 'assets/images/ambulance/1.png',
          hotLine: '123',
          address: 'City House Road',
          time: '30'),
    ];
    return data;
  }
}
