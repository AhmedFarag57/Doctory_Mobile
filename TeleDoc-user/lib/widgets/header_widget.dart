import 'package:flutter/material.dart';
import 'package:teledoc/utils/dimensions.dart';

class HeaderWidget extends StatefulWidget {
  final String name;

  const HeaderWidget({Key key, this.name}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radius * 2),
            bottomRight: Radius.circular(Dimensions.radius * 2)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Center(
        child: Text(
          widget.name,
          style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
      ),
    );
  }
}
