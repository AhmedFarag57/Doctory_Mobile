import 'dart:convert';

import 'package:doctor/data/recent.dart';
import 'package:doctor/screens/messaging_screen.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:flutter/material.dart';

import '../../network_utils/api.dart';

class TodayAppointmentWidget extends StatelessWidget {
  var patients;

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize),
          child: Text(
            Strings.todayAppointment,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: Dimensions.heightSize,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: RecentList.list().length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Recent recent = RecentList.list()[index];
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
                          Image.asset(recent.image),
                          SizedBox(
                            width: Dimensions.widthSize,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recent.name,
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
                                recent.problem,
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: Dimensions.smallTextSize),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Text(
                                '${recent.time} ${recent.date}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: Dimensions.smallTextSize),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            'assets/images/message.png'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MessagingScreen()));
                                    },
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize * 0.5,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: CustomColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Image.asset('assets/images/call.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize * 0.5,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: CustomColor.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                          'assets/images/video.png'),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    openPatientDetailsDialog(
                      context,
                      recent.image,
                      recent.name,
                      recent.problem,
                      recent.time,
                      recent.date,
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  openPatientDetailsDialog(
      BuildContext context, image, name, problem, time, date) {
    showGeneralDialog(
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.6),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (_, __, ___) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: CustomColor.secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                      top: Dimensions.heightSize * 2,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      CustomColor.primaryColor.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(image),
                                  SizedBox(
                                    width: Dimensions.widthSize,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                                Dimensions.defaultTextSize,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: Dimensions.heightSize * 0.5,
                                      ),
                                      Text(
                                        problem,
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: Dimensions.smallTextSize),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: Dimensions.heightSize * 0.5,
                                      ),
                                      Text(
                                        '$time $date',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: Dimensions.smallTextSize),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: Dimensions.heightSize * 0.5,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: CustomColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  'assets/images/message.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.widthSize * 0.5,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: CustomColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  'assets/images/call.png'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.widthSize * 0.5,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: CustomColor.primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                  'assets/images/video.png'),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.heightSize),
                          _titleData(Strings.name, Strings.age, name, '69'),
                          _titleData(Strings.patientSex, Strings.patientId,
                              'Male', '7865KD'),
                          _titleData(Strings.date, Strings.time, date, time),
                          _titleData(Strings.chamber, Strings.roomNo,
                              'Modern Hospital', '250'),
                          _titleData(
                              Strings.fee, 'Status', '\$250', 'Appointment'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        });
  }

  _titleData(String title1, String title2, String value1, String value2) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize,
        bottom: Dimensions.heightSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title1, style: CustomStyle.textStyle),
              Text(title2, style: CustomStyle.textStyle),
            ],
          ),
          SizedBox(height: Dimensions.heightSize * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value1,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.defaultTextSize)),
              Text(value2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.defaultTextSize)),
            ],
          ),
        ],
      ),
    );
  }
}
