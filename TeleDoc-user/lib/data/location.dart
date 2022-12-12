class Location {
  final int id;
  final String name;
  final String image;
  final String hotLine;
  final String address;

  const Location({this.id, this.name, this.image, this.hotLine, this.address});
}

class LocationList {
  static List<Location> list() {
    const data = <Location> [
      Location(
          id: 1,
          name: 'Captown Hospital',
          image: 'assets/images/location/1.png',
          hotLine: '1245',
          address: 'Captown City 2454/2'
      ),
      Location(
          id: 2,
          name: 'Medina Lupaz Medical College',
          image: 'assets/images/location/2.png',
          hotLine: '123',
          address: 'City House Road'
      ),
      Location(
          id: 3,
          name: 'Rosebeauty Hospital',
          image: 'assets/images/location/3.png',
          hotLine: '54321',
          address: 'Mungrisdale'
      ),
      Location(
          id: 4,
          name: 'Lubanni Hospital',
          image: 'assets/images/location/4.png',
          hotLine: '3456',
          address: 'Hesket New Market'
      ),
    ];
    return data;
  }
}