import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledoc/dialog/message_dialog.dart';
import 'package:teledoc/network_utils/api.dart';
import 'package:teledoc/screens/dashboard_screen.dart';
import 'package:teledoc/screens/submit_review_screen.dart';
import 'package:teledoc/screens/videocall_screen.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'messaging_screen.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final myAppointment;

  const AppointmentDetailsScreen({
    Key? key,
    this.myAppointment,
  }) : super(key: key);

  @override
  _AppointmentDetailsScreenState createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  bool _isLoading = true;

  var chatId;
  var user;

  @override
  void initState() {
    super.initState();
    if (widget.myAppointment['status'] == 'accepted') {
      _loadData();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future _loadData() async {
    try {
      var response = await CallApi().getDataWithToken(
        '/appointments/' + widget.myAppointment['id'].toString() + '/chatId',
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        chatId = body['data'].toString();
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        user = jsonDecode(localStorage.get('user').toString());
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      // Handle the error
      _showErrorDialog(context, 'Error in Appointment detail. Try again');
    }
  }

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
              BackWidget(
                name: Strings.appointmentDetails,
                active: true,
              ),
              _bodyWidget(context),
              _buildContact(context),
            ],
          ),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    if (_isLoading) {
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
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      );
    } else {
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
            ),
          ),
          child: ListView(
            children: [
              _detailsWidget(context),
            ],
          ),
        ),
      );
    }
  }

  _detailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
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
                    'assets/images/nearby/1.png',
                  ),
                  SizedBox(
                    width: Dimensions.widthSize,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.myAppointment['name'],
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
                        'Liver Specialist',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: Dimensions.smallTextSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          _titleData(
            Strings.name,
            '',
            widget.myAppointment['name'],
            '',
          ),
          _titleData(
            Strings.date,
            Strings.time,
            widget.myAppointment['date'],
            _getTimeFormated(widget.myAppointment['time_from']) +
                ' - ' +
                _getTimeFormated(widget.myAppointment['time_to']),
          ),
          _titleData(
            Strings.fee,
            'Status',
            widget.myAppointment['session_price'] + " L.E",
            widget.myAppointment['status'],
          ),
        ],
      ),
    );
  }

  _buildContact(BuildContext context) {
    return widget.myAppointment['status'] == "accepted"
        ? Positioned(
            bottom: Dimensions.heightSize * 2,
            left: Dimensions.marginSize * 2,
            right: Dimensions.marginSize * 2,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Dimensions.radius * 0.5,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "start contact".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                _openContactDoctorDialog(context);
              },
            ),
          )
        : _finishButtonWidget(context);
  }

  _finishButtonWidget(BuildContext context) {
    return widget.myAppointment['status'] == "completed"
        ? Positioned(
            bottom: Dimensions.heightSize * 2,
            left: Dimensions.marginSize * 2,
            right: Dimensions.marginSize * 2,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius * 0.5),
                  ),
                ),
                child: Center(
                  child: Text(
                    Strings.finish.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SubmitReviewScreen(),
                  ),
                );
              },
            ),
          )
        : Positioned(
            bottom: Dimensions.heightSize * 2,
            left: Dimensions.marginSize * 2,
            right: Dimensions.marginSize * 2,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Dimensions.radius * 0.5,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Back".toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
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
              Text(
                title1,
                style: CustomStyle.textStyle,
              ),
              Text(
                title2,
                style: CustomStyle.textStyle,
              ),
            ],
          ),
          SizedBox(height: Dimensions.heightSize * 0.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value1,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.defaultTextSize,
                ),
              ),
              Text(
                value2,
                style: TextStyle(
                    color: Colors.black, fontSize: Dimensions.defaultTextSize),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _openContactDoctorDialog(BuildContext context) {
    showGeneralDialog(
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8),
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
                height: 300,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(bottom: 12, left: 15, right: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: Dimensions.marginSize,
                        right: Dimensions.marginSize,
                      ),
                      child: Text(
                        Strings.contactYourDoctor,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.heightSize * 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              Icons.message_outlined,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MessagingScreen(
                                  widget.myAppointment['id'],
                                  chatId,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: Dimensions.widthSize),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              Icons.call,
                            ),
                          ),
                          onTap: () {
                            // ...
                          },
                        ),
                        SizedBox(width: Dimensions.widthSize),
                        GestureDetector(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: CustomColor.primaryColor,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(
                              Icons.video_call,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VideocallScreen(
                                  callId: chatId,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Future<bool> _showErrorDialog(BuildContext context, message) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MessageDialog(
            title: "Error",
            subTitle: message,
            action: true,
            moved: DashboardScreen(),
            img: 'error.png',
            buttonName: Strings.ok,
          ),
        )) ??
        false;
  }

  String _getTimeFormated(time) {
    DateTime tmp = DateTime.parse('2023-04-26 ' + time);
    String formattedDate = DateFormat('hh:mm a').format(tmp);
    return formattedDate;
  }
}
