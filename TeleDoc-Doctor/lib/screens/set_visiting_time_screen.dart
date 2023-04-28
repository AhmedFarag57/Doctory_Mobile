import 'dart:convert';
import 'package:doctor/dialog/loading_dialog.dart';
import 'package:doctor/dialog/message_dialog.dart';
import 'package:doctor/dialog/success_dialog.dart';
import 'package:doctor/network_utils/api.dart';
import 'package:doctor/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/widgets/back_widget.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetVisitingTimeScreen extends StatefulWidget {
  @override
  _SetVisitingTimeScreenState createState() => _SetVisitingTimeScreenState();
}

class _SetVisitingTimeScreenState extends State<SetVisitingTimeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  List<String> dayList = [];
  String selectedDay;

  List<String> startTimeList = [
    '01:00 AM',
    '02:00 AM',
    '03:00 AM',
    '04:00 AM',
    '05:00 AM',
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
  ];
  String selectedStartTime;

  List<String> endTimeList = [
    '01:00 AM',
    '02:00 AM',
    '03:00 AM',
    '04:00 AM',
    '05:00 AM',
    '06:00 AM',
    '07:00 AM',
    '08:00 AM',
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
  ];
  String selectedEndTime;

  List<String> selectedStartTimes = [];
  List<String> selectedEndTimes = [];
  List<String> selectedDate = [];

  int numberOfDayCount = 1;

  int numberOfTimes = 0;

  bool _isLoading = true;

  var model;
  var dates = [];
  var timesFrom = [];
  var timesTo = [];

  @override
  void initState() {
    super.initState();
    _setDatesForList();
    selectedDay = dayList[0].toString();
    selectedStartTime = startTimeList[0].toString();
    selectedEndTime = endTimeList[0].toString();
    _loadData();
  }

  Future _loadData() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      model = jsonDecode(localStorage.getString('model'));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Pop the Set Session Secreen
      Navigator.of(context).pop();
    }
  }

  Future _saveTimeRequest(BuildContext context) async {
    try {
      // Show the loading dialog
      showLoadingDialog(context);
      // Prepare date to send it
      _prepareDataToSend();
      // Data
      var data = {
        'dates': dates,
        'timesFrom': timesFrom,
        'timesTo': timesTo,
      };
      //Send request to save the times
      var response = await CallApi().postDataWithToken(
        data,
        '/doctors/' + model['id'].toString() + '/times',
      );
      if (response.statusCode == 200) {
        // Pop the Loading Dialog
        Navigator.of(context).pop();
        // Show success message
        showSuccessDialog(context);
      } else {
        throw Exception(response.reasonPharse);
      }
    } catch (e) {
      // Pop the Loading Dialog
      Navigator.of(context).pop();
      // Clean the data
      dates.clear();
      timesFrom.clear();
      timesTo.clear();
      // Handle the error
      showErrorDialog(context, 'Error in save times, Try Again !');
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
                name: Strings.setSessionTime,
                active: true,
              ),
              bodyWidget(context),
              buttonWidget(context)
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
          child: setTimeWidget(context),
        ),
      );
    }
  }

  setTimeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: numberOfDayCount,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.heightSize,
                bottom: Dimensions.heightSize,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: Material(
                elevation: 10.0,
                shadowColor: CustomColor.secondaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      index == 0 ? _buildSetTime() : _buildFixedTime(index - 1),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildSetTime() {
    return Row(
      children: [
        _buildDayDM(),
        _buildStartTimeDM(),
        Expanded(
          flex: 1,
          child: Align(
            child: Text('To'),
          ),
        ),
        _buildEndTimeDM(),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        _buildAddBtn()
      ],
    );
  }

  _buildFixedTime(index) {
    return Row(
      children: [
        _buildDayFixed(index),
        _buildStartTimeFixed(index),
        Expanded(
          flex: 1,
          child: Align(
            child: Text('To'),
          ),
        ),
        _buildEndTimeFixed(index),
        SizedBox(
          width: Dimensions.widthSize,
        ),
        _buildDeleteBtn(index)
      ],
    );
  }

  _buildDayDM() {
    return Expanded(
      flex: 2,
      child: DropdownButton(
        underline: Container(),
        hint: Text(
          selectedDay,
          style: CustomStyle.textStyle,
        ),
        value: selectedDay,
        onChanged: (newValue) {
          setState(() {
            selectedDay = newValue;
          });
        },
        items: dayList.map((value) {
          return DropdownMenuItem(
            child: new Text(
              value,
              style: CustomStyle.textStyle,
            ),
            value: value,
          );
        }).toList(),
      ),
    );
  }

  _buildStartTimeDM() {
    return Expanded(
      flex: 2,
      child: DropdownButton(
        menuMaxHeight: 256.0,
        underline: Container(),
        hint: Text(
          selectedStartTime,
          style: CustomStyle.textStyle,
        ),
        value: selectedStartTime,
        onChanged: (newValue) {
          setState(() {
            selectedStartTime = newValue;
          });
        },
        items: startTimeList.map((value) {
          return DropdownMenuItem(
            child: new Text(
              value,
              style: CustomStyle.textStyle,
            ),
            value: value,
          );
        }).toList(),
      ),
    );
  }

  _buildEndTimeDM() {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.topRight,
        child: DropdownButton(
          menuMaxHeight: 256.0,
          underline: Container(),
          hint: Text(
            selectedEndTime,
            style: CustomStyle.textStyle,
          ),
          value: selectedEndTime,
          onChanged: (newValue) {
            setState(() {
              selectedEndTime = newValue;
            });
          },
          items: endTimeList.map((value) {
            return DropdownMenuItem(
              child: new Text(
                value,
                style: CustomStyle.textStyle,
              ),
              value: value,
            );
          }).toList(),
        ),
      ),
    );
  }

  _buildAddBtn() {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          width: Dimensions.buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.radius,
            ),
            color: Colors.green,
          ),
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
        onTap: () {
          setState(() {
            if (numberOfDayCount < 3) {
              selectedStartTimes.add(selectedStartTime);
              selectedEndTimes.add(selectedEndTime);
              selectedDate.add(selectedDay);
              numberOfTimes++;
              numberOfDayCount++;
            }
          });
        },
      ),
    );
  }

  _buildDayFixed(index) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(selectedDate[index]),
      ),
    );
  }

  _buildStartTimeFixed(index) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(selectedStartTimes[index]),
      ),
    );
  }

  _buildEndTimeFixed(index) {
    return Expanded(
      flex: 2,
      child: Align(
        alignment: Alignment.topRight,
        child: Text(selectedEndTimes[index]),
      ),
    );
  }

  _buildDeleteBtn(index) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          width: Dimensions.buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Dimensions.radius,
            ),
            color: Colors.red,
          ),
          child: Icon(
            Icons.delete,
            size: 30,
            color: Colors.white,
          ),
        ),
        onTap: () {
          setState(() {
            if (numberOfDayCount > 1) {
              selectedStartTimes.removeAt(index);
              selectedEndTimes.removeAt(index);
              selectedDate.removeAt(index);
              numberOfTimes--;
              numberOfDayCount--;
            }
          });
        },
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize * 2,
      right: Dimensions.marginSize * 2,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                child: Center(
                  child: Text(
                    Strings.save.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                if (numberOfTimes > 0) {
                  _saveTimeRequest(context);
                } else {
                  _showInSnackBar('You have to add at least one time');
                }
              },
            ),
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                child: Center(
                  child: Text(
                    Strings.close.toUpperCase(),
                    style: TextStyle(color: Colors.black.withOpacity(0.7)),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  _setDatesForList() {
    DateTime dateNow = DateTime.now();
    String formattedDate = DateFormat('EEEE').format(dateNow);
    dayList.add(_getDay(formattedDate));
  }

  _prepareDataToSend() {
    for (var element in selectedStartTimes) {
      timesFrom.add(_getTime(element).toString());
    }
    for (var element in selectedEndTimes) {
      timesTo.add(_getTime(element).toString());
    }
    for (var element in selectedDate) {
      dates.add(_getDate().toString());
    }
  }

  _getDay(day) {
    // 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'
    switch (day) {
      case 'Monday':
        return 'Mon';
        break;
      case 'Tuesday':
        return 'Tue';
        break;
      case 'Wednesday':
        return 'Wed';
        break;
      case 'Thursday':
        return 'Thu';
        break;
      case 'Friday':
        return 'Fri';
        break;
      case 'Saturday':
        return 'Sat';
        break;
      case 'Sunday':
        return 'Sun';
        break;
    }
  }

  _getDate() {
    DateTime dateNow = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateNow);
    return formattedDate;
  }

  _getTime(time) {
    switch (time) {
      case '12:00 AM':
        return '00:00:00';
        break;
      case '01:00 AM':
        return '01:00:00';
        break;
      case '02:00 AM':
        return '02:00:00';
        break;
      case '03:00 AM':
        return '03:00:00';
        break;
      case '04:00 AM':
        return '04:00:00';
        break;
      case '05:00 AM':
        return '05:00:00';
        break;
      case '06:00 AM':
        return '06:00:00';
        break;
      case '07:00 am':
        return '07:00:00';
        break;
      case '08:00 AM':
        return '08:00:00';
        break;
      case '09:00 AM':
        return '09:00:00';
        break;
      case '10:00 AM':
        return '10:00:00';
        break;
      case '11:00 AM':
        return '11:00:00';
        break;
      case '12:00 PM':
        return '12:00:00';
        break;
      case '01:00 PM':
        return '13:00:00';
        break;
      case '02:00 PM':
        return '14:00:00';
        break;
      case '03:00 PM':
        return '15:00:00';
        break;
      case '04:00 PM':
        return '16:00:00';
        break;
      case '05:00 PM':
        return '17:00:00';
        break;
      case '06:00 PM':
        return '18:00:00';
        break;
      case '07:00 PM':
        return '19:00:00';
        break;
      case '08:00 PM':
        return '20:00:00';
        break;
      case '09:00 PM':
        return '21:00:00';
        break;
      case '10:00 PM':
        return '22:00:00';
        break;
      case '11:00 PM':
        return '23:00:00';
        break;
    }
  }

  Future<bool> showLoadingDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => LoadingDialog(),
        )) ??
        false;
  }

  Future<bool> showSuccessDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => SuccessDialog(
            title: Strings.success,
            subTitle: "Times recorded successfully",
            buttonName: Strings.ok,
            moved: DashboardScreen(),
          ),
        )) ??
        false;
  }

  Future<bool> showErrorDialog(BuildContext context, message) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MessageDialog(
            title: "Error",
            subTitle: message,
            action: false,
            img: 'error.png',
            buttonName: Strings.ok,
          ),
        )) ??
        false;
  }

  void _showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: new Text(value),
      duration: Duration(seconds: 3),
    ));
  }
}
