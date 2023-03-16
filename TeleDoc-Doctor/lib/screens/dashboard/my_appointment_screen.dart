import 'dart:convert';

import 'package:doctor/widgets/appointment/appointment_request_widget.dart';
import 'package:doctor/widgets/appointment/today_appointment_widget.dart';
import 'package:doctor/widgets/header_widget.dart';
import 'package:flutter/material.dart';

import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network_utils/api.dart';
import '../loading/loading_screen.dart';

class MyAppointmentScreen extends StatefulWidget {
  @override
  _MyAppointmentScreenState createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  int totalPages = 2;
  bool isLoading = false;

  var user;
  var appointmentsRequest;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  loadData() async {
    setState(() => isLoading = true);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.getString('user'));
    var id = user['id'];
    var response;
    var body;

    response = await CallApi()
        .getDataWithToken('/doctors/' + id.toString() + '/appointments/request');

    body = jsonDecode(response.body);

    if (body['success']) {
      appointmentsRequest = body['data'];
    }


    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : SafeArea(
          child: Scaffold(
            backgroundColor: CustomColor.secondaryColor,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  HeaderWidget(
                    name: Strings.myAppointment,
                  ),
                  bodyWidget(context),
                ],
              ),
            ),
          ),
        );

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 80,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 2),
              topRight: Radius.circular(Dimensions.radius * 2),
            )),
        child: PageView.builder(
            itemCount: totalPages,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.marginSize,
                            right: Dimensions.marginSize,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Strings.appointmentRequest,
                                      style: TextStyle(
                                          color: CustomColor.primaryColor,
                                          fontSize: Dimensions.defaultTextSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: Dimensions.heightSize,
                                    ),
                                    Container(
                                      height: 2,
                                      color: index == 0
                                          ? CustomColor.primaryColor
                                          : Colors.black.withOpacity(0.7),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      Strings.todayAppointment,
                                      style: TextStyle(
                                          color: CustomColor.primaryColor,
                                          fontSize: Dimensions.defaultTextSize,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: Dimensions.heightSize,
                                    ),
                                    Container(
                                      height: 2,
                                      color: index == 1
                                          ? CustomColor.primaryColor
                                          : Colors.black.withOpacity(0.7),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: pageViewWidget(index),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  pageViewWidget(int i) {
    switch (i) {
      case 0:
        return AppointmentRequestWidget();
      case 1:
        return TodayAppointmentWidget();
    }
  }
}
