import 'dart:async';
import 'dart:convert';

import 'package:doctor/data/recent.dart';
import 'package:doctor/screens/dashboard/home_screen.dart';
import 'package:doctor/screens/loading/loading_screen.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dialog/loading_dialog.dart';
import '../../network_utils/api.dart';

class AppointmentRequestWidget extends StatelessWidget {
  var appointmentsRequest;

  AppointmentRequestWidget(var appointmentsRequest) {
    this.appointmentsRequest = appointmentsRequest;
  }

  accept_reject(var appointment_id, bool action, BuildContext context) async {
    
    var response;
    var body;

    var data = {
      'appointment_id': appointment_id,
      'action': action
    };

    response = await CallApi()
        .postDataWithToken(data, '/doctors/appointments/request');

    body = jsonDecode(response.body);

    if (body['success']) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize),
          child: Text(
            Strings.requestForAppointment,
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
            itemCount: appointmentsRequest.length,
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
                          Expanded(
                            flex: 1,
                            child: Image.asset(recent.image),
                          ),
                          SizedBox(
                            width: Dimensions.widthSize,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  appointmentsRequest[index]['name'],
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
                                  appointmentsRequest[index]['status'],
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: Dimensions.smallTextSize),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  '${appointmentsRequest[index]['time']} / ${appointmentsRequest[index]['date']}',
                                  //'${recent.time} ${recent.date}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: Dimensions.smallTextSize),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: Dimensions.widthSize,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                GestureDetector(
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: CustomColor.primaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius)),
                                    child: Center(
                                      child: Text(
                                        Strings.accept,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showLoadingDialog(context);
                                    accept_reject(
                                        appointmentsRequest[index]['id'], true, context);
                                    /*
                                    Timer(Duration(seconds: 2), () {
                                      Navigator.of(context).pop();
                                    });
                                    */
                                  },
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize,
                                ),
                                GestureDetector(
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                        color: CustomColor.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius)),
                                    child: Center(
                                      child: Text(
                                        Strings.reject,
                                        style: TextStyle(
                                            color: CustomColor.primaryColor),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    showLoadingDialog(context);
                                    accept_reject(
                                        appointmentsRequest[index]['id'],
                                        false, context);
                                    /*
                                    Timer(Duration(seconds: 2), () {
                                      Navigator.of(context).pop();
                                    });
                                    */
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    openPatientDetailsDialog(
                        context,
                        recent.image,
                        appointmentsRequest[index]['name'],
                        appointmentsRequest[index]['status'],
                        appointmentsRequest[index]['time'],
                        appointmentsRequest[index]['date']);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<bool> showLoadingDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => LoadingDialog(),
        )) ??
        false;
  }

  openPatientDetailsDialog(
      BuildContext context, image, name, status, time, date) {
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
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: Dimensions.smallTextSize),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: Dimensions.heightSize * 0.5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Dimensions.heightSize),
                          _titleData(Strings.name, 'Status', name, status),
                          _titleData(Strings.date, Strings.time, date, time),
                          _titleData(Strings.fee, '', '\$250', ''),
                          SizedBox(height: Dimensions.heightSize),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: Dimensions.buttonHeight,
                                  decoration: BoxDecoration(
                                      color: CustomColor.primaryColor,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius)),
                                  child: Center(
                                    child: Text(
                                      Strings.accept.toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.widthSize,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: Dimensions.buttonHeight,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.7))),
                                  child: Center(
                                    child: Text(
                                      Strings.reject.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
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
