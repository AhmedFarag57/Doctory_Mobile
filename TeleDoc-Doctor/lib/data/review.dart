class Review {
  final int id;
  final String name;
  final String image;
  final String comment;
  final String rating;
  final String date;

  const Review({this.id, this.name, this.image, this.comment, this.rating, this.date});
}

class ReviewList {
  static List<Review> list() {
    const data = <Review> [
      Review(
          id: 1,
          name: 'Jefika Sabnam',
          image: 'assets/images/recent/1.png',
          comment: 'Contrary to popular besimp and world is a class random text. It has roots',
          rating: '4',
          date: '2 feb, 2021'
      ),
      Review(
          id: 2,
          name: 'Tomas Mudar',
          image: 'assets/images/recent/2.png',
          comment: 'Contrary to popular besimp and world is a class random text. It has roots',
          rating: '5',
          date: '28 jan, 2021'
      ),
      Review(
          id: 3,
          name: 'William Coster',
          image: 'assets/images/recent/3.png',
          comment: 'Contrary to popular besimp and world is a class random text. It has roots',
          rating: '4',
          date: '25 jan, 2021'
      ),
      Review(
          id: 4,
          name: 'Justin Trudo',
          image: 'assets/images/recent/4.png',
          comment: 'Contrary to popular besimp and world is a class random text. It has roots',
          rating: '5',
          date: '19 jan, 2021'
      ),
      Review(
          id: 5,
          name: 'Tom Cruise',
          image: 'assets/images/recent/5.png',
          comment: 'Contrary to popular besimp and world is a class random text. It has roots',
          rating: '4',
          date: '01 jan, 2021'
      ),
    ];
    return data;
  }
}