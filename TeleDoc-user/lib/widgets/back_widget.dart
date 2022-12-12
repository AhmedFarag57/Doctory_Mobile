import 'package:flutter/material.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';

class BackWidget extends StatefulWidget {
  final String name;

  const BackWidget({Key key, this.name}) : super(key: key);

  @override
  _BackWidgetState createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
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
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          Strings.back,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
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
