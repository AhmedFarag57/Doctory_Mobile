import 'package:flutter/material.dart';
import 'package:teledoc/data/nearby.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';

class HealthCareWidget extends StatelessWidget {
  final doctors;

  HealthCareWidget(this.doctors);

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
          itemCount: doctors.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Nearby nearby = NearbyList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.widthSize * 2,
                  right: Dimensions.widthSize,
                  top: 10,
                  bottom: 10),
              child: GestureDetector(
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
                        Image.asset(nearby.image),
                        SizedBox(
                          width: Dimensions.widthSize,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. ' + doctors[index]['name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.defaultTextSize,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: Dimensions.heightSize * 0.5,
                            ),
                            Text(
                              nearby.specialist,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: Dimensions.smallTextSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: Dimensions.heightSize * 0.5,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 30,
                              decoration: BoxDecoration(
                                color: CustomColor.primaryColor,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      color: CustomColor.secondaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      Icons.call,
                                      color: CustomColor.primaryColor,
                                      size: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize,
                                  ),
                                  Text(
                                    Strings.callNow,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  // ..
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
