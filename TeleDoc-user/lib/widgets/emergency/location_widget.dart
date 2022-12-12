import 'package:flutter/material.dart';
import 'package:teledoc/data/location.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';

class LocationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2,
        bottom: Dimensions.heightSize * 2,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: LocationList.list().length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Location location = LocationList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.widthSize * 2,
                  right: Dimensions.widthSize,
                  top: 10,
                  bottom: 10
              ),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.secondaryColor,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                          location.image
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            location.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              Text(
                                location.address,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: Dimensions.smallTextSize
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Text(
                            'Hot Line - ${location.hotLine}',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: Dimensions.smallTextSize,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
