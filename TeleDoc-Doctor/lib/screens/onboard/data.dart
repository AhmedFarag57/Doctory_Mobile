import 'package:doctor/utils/strings.dart';

class OnBoardingItem {
  final String title;
  final String image;
  final String subTitle;

  const OnBoardingItem(
      {required this.title, required this.image, required this.subTitle});
}

class OnBoardingItems {
  static List<OnBoardingItem> loadOnboardItem() {
    const fi = <OnBoardingItem>[
      OnBoardingItem(
        title: Strings.title1,
        image: 'assets/images/onboard/1.png',
        subTitle: Strings.subTitle1,
      ),
      OnBoardingItem(
        title: Strings.title2,
        image: 'assets/images/onboard/2.jpg',
        subTitle: Strings.subTitle2,
      ),
      OnBoardingItem(
        title: Strings.title3,
        image: 'assets/images/onboard/3.jpg',
        subTitle: Strings.subTitle3,
      ),
    ];
    return fi;
  }
}
