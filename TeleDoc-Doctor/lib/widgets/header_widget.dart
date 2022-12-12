import 'package:flutter/material.dart';
import 'package:doctor/utils/dimensions.dart';

class HeaderWidget extends StatefulWidget {
  final String name;

  const HeaderWidget({Key key, this.name}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: 70,
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
