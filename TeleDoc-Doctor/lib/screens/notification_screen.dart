import 'dart:convert';
import 'package:doctor/dialog/message_dialog.dart';
import 'package:doctor/network_utils/api.dart';
import 'package:doctor/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/widgets/back_widget.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isLoading = true;

  var notifications;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    try {
      var response = await CallApi().getDataWithToken('/notifications');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        notifications = body['data'];
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      // Show error dialog & go to Dashboard Screen
      _showErrorDialog(context, 'Error in load notification');
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
                name: Strings.notification,
                active: true,
                onTap: null,
              ),
              bodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    if (_isLoading) {
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
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
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
                                    notifications[index]['title'],
                                    style: TextStyle(
                                      fontSize: Dimensions.largeTextSize,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Dimensions.heightSize * 0.5,
                              ),
                              Text(
                                notifications[index]['description'],
                                style: TextStyle(
                                  fontSize: Dimensions.smallTextSize,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.widthSize,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            _getTimeFormated(
                                notifications[index]['created_at']),
                            style: TextStyle(color: CustomColor.greyColor),
                            textAlign: TextAlign.end,
                          ),
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

  Future<bool> _showErrorDialog(BuildContext context, message) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MessageDialog(
            title: "Error",
            subTitle: message,
            moved: DashboardScreen(),
            action: true,
            img: 'error.png',
            buttonName: Strings.ok,
          ),
        )) ??
        false;
  }

  _getTimeFormated(time) {
    DateTime tmp = DateTime.parse(time);
    String formattedDate = DateFormat('hh:mm a').format(tmp);
    return formattedDate;
  }
}
