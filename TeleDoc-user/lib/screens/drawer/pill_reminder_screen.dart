import 'package:flutter/material.dart';
import 'package:teledoc/data/pill_reminder.dart';
import 'package:teledoc/screens/set_pill_reminder_screen.dart';

import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/widgets/back_widget.dart';

class PillReminderScreen extends StatefulWidget {

  @override
  _PillReminderScreenState createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.secondaryColor,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              right: Dimensions.marginSize,
              bottom: Dimensions.heightSize,
          ),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  SetPillReminderScreen()));
            },
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackWidget(name: Strings.pillReminder,),
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
          itemCount: PillReminderList.list().length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            PillReminder reminder = PillReminderList.list()[index];
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
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: CustomColor.secondaryColor,
                          borderRadius: BorderRadius.circular(25)
                        ),
                        child: Image.asset(
                            'assets/images/pill.png'
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reminder.name,
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
                                Icons.history,
                                size: 15,
                              ),
                              SizedBox(width: Dimensions.widthSize * 0.5,),
                              Text(
                                reminder.time,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.smallTextSize
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 15,
                              ),
                              SizedBox(width: Dimensions.widthSize * 0.5,),
                              Text(
                                reminder.day,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: Dimensions.smallTextSize
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
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
