class Recent {
  final int id;
  final String name;
  final String image;
  final String problem;
  final String time;
  final String date;

  const Recent({this.id, this.name, this.image, this.problem, this.time, this.date});
}

class RecentList {
  static List<Recent> list() {
    const data = <Recent> [
      Recent(
          id: 1,
          name: 'Jefika Sabnam',
          image: 'assets/images/recent/1.png',
          problem: 'Bleeding From The Mouth',
          time: '12:00pm - 03:00pm',
          date: '2 feb, 2021'
      ),
      Recent(
          id: 2,
          name: 'Tomas Mudar',
          image: 'assets/images/recent/2.png',
          problem: 'Shortness of Breath Problem',
          time: '05:00pm - 08:00pm',
          date: '28 jan, 2021'
      ),
      Recent(
          id: 3,
          name: 'William Coster',
          image: 'assets/images/recent/3.png',
          problem: 'Drug Addicted',
          time: '12:00pm - 03:00pm',
          date: '25 jan, 2021'
      ),
      Recent(
          id: 4,
          name: 'Justin Trudo',
          image: 'assets/images/recent/4.png',
          problem: 'Depressed',
          time: '05:00pm - 08:00pm',
          date: '19 jan, 2021'
      ),
      Recent(
          id: 5,
          name: 'Tom Cruise',
          image: 'assets/images/recent/5.png',
          problem: 'Heart Disease',
          time: '08:00pm - 09:00pm',
          date: '01 jan, 2021'
      ),
    ];
    return data;
  }
}