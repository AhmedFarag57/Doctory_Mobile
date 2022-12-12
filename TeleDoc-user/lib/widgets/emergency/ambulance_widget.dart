import 'package:flutter/material.dart';
import 'package:teledoc/data/ambulance.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';

class AmbulanceWidget extends StatelessWidget {
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
          itemCount: AmbulanceList.list().length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Ambulance ambulance = AmbulanceList.list()[index];
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
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                            ambulance.image
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ambulance.name,
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
                                  ambulance.address,
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
                              'Hot Line - ${ambulance.hotLine}',
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: Dimensions.smallTextSize,
                                  fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: Dimensions.heightSize * 0.5,),
                            Row(
                              children: [
                                Icon(
                                  Icons.subject,
                                  size: 12,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                Text(
                                  Strings.icuSupport,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: Dimensions.smallTextSize
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(width: Dimensions.widthSize * 0.5,),
                                Icon(
                                  Icons.history,
                                  size: 12,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                                Text(
                                  '${ambulance.time} min',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: Dimensions.smallTextSize
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ],
                        ),
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
