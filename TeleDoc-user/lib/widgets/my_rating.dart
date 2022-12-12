import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter/material.dart';
import 'package:teledoc/utils/colors.dart';


class MyRating extends StatefulWidget {
  final String rating;

  const MyRating({Key key, this.rating}) : super(key: key);

  @override
  _MyRatingState createState() => _MyRatingState();
}

class _MyRatingState extends State<MyRating> {
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
        allowHalfRating: true,
        onRated: (v) {
        },
        starCount: 5,
        rating: double.parse(widget.rating),
        size: 20.0,
        isReadOnly: true,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star,
        color: CustomColor.accentColor,
        borderColor: CustomColor.secondaryColor,
        spacing:0.0
    );
  }
}
