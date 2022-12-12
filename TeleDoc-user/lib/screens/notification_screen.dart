import 'package:flutter/material.dart';

import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/data/notifications.dart';
import 'package:teledoc/widgets/back_widget.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.secondaryColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackWidget(name: Strings.notification,),
              bodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 80,
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 2),
            topRight: Radius.circular(Dimensions.radius * 2),
          )
        ),
        child: ListView.builder(
          itemCount: NotificationList.list().length,
          itemBuilder: (context, index) {
            Notifications notification = NotificationList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.heightSize,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColor.primaryColor.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                    top: Dimensions.heightSize,
                    bottom: Dimensions.heightSize,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  notification.title,
                                  style: TextStyle(
                                      fontSize: Dimensions.largeTextSize,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.heightSize * 0.5,),
                            Text(
                              notification.subTitle,
                              style: TextStyle(
                                  fontSize: Dimensions.smallTextSize,
                                  color: Colors.grey
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Expanded(
                          flex: 1,
                          child: Text(
                            notification.time,
                            style: TextStyle(
                              color: CustomColor.greyColor
                            ),
                            textAlign: TextAlign.end,
                          )
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
