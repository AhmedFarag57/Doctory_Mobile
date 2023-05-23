import 'package:doctor/data/recent.dart';
import 'package:doctor/screens/audio_call_screen.dart';
import 'package:doctor/screens/messaging_screen.dart';
import 'package:doctor/screens/video_call_screen.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:flutter/material.dart';

class TodayAppointmentWidget extends StatelessWidget {
  var todayAppointments;

  TodayAppointmentWidget(var todayAppointments) {
    this.todayAppointments = todayAppointments;
  }

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
              fontWeight: FontWeight.bold,
            ),
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
            itemCount: todayAppointments.length,
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
                  bottom: 10,
                ),
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
                                todayAppointments[index]['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Dimensions.defaultTextSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Text(
                                todayAppointments[index]['status'],
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: Dimensions.smallTextSize,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.watch_later,
                                    color: Colors.grey,
                                    size: 18.0,
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize * 0.5,
                                  ),
                                  Text(
                                    todayAppointments[index]['time_from'] +
                                        ' to ' +
                                        todayAppointments[index]['time_to'],
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: Dimensions.smallTextSize,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            'assets/images/message.png'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => MessagingScreen(
                                            todayAppointments[index]['id'],
                                            todayAppointments[index]['chat_id'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize * 0.5,
                                  ),
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
                                            'assets/images/call.png'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => AudioCallScreen(
                                            callId: todayAppointments[index]
                                                ['chat_id'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: Dimensions.widthSize * 0.5,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: CustomColor.primaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            'assets/images/video.png'),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => VideoCallTestScreen(
                                            callId: todayAppointments[index]
                                                ['chat_id'],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
                      todayAppointments[index]['name'],
                      todayAppointments[index]['status'],
                      todayAppointments[index]['time_from'] +
                          '-' +
                          todayAppointments[index]['time_to'],
                      todayAppointments[index]['date'],
                      todayAppointments[index]['session_price'],
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
      BuildContext context, image, name, status, time, date, sessionPrice) {
    showGeneralDialog(
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
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
                                      status,
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
                                          color: Colors.black.withOpacity(0.6),
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
                                            padding: const EdgeInsets.all(8.0),
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
                                            padding: const EdgeInsets.all(8.0),
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
                        SizedBox(height: Dimensions.heightSize),
                        _titleData(Strings.name, 'Status', name, status),
                        _titleData(Strings.date, Strings.time, date, time),
                        _titleData(Strings.fee, '', sessionPrice + ' L.E', ''),
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
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(anim),
          child: child,
        );
      },
    );
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
