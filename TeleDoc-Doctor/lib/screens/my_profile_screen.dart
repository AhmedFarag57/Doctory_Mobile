import 'dart:async';
import 'dart:convert';
import 'package:doctor/network_utils/api.dart';
import 'package:doctor/screens/add_medical_degree_screen.dart';
import 'package:doctor/screens/set_visiting_time_screen.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:smart_select/smart_select.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  var user;
  var model;
  var times;

  bool _isLoading = true;

  File _image;
  File file;

  List<int> specialistValue = [1, 2];
  List<S2Choice<int>> specialistItemList = [
    S2Choice<int>(value: 1, title: 'Medicine Specialist'),
    S2Choice<int>(value: 2, title: 'Liver Specialist'),
    S2Choice<int>(value: 3, title: 'FCO Medicine'),
    S2Choice<int>(value: 4, title: 'Dental Specialist'),
    S2Choice<int>(value: 5, title: 'Child Specialist'),
    S2Choice<int>(value: 6, title: 'Eye Specialist'),
    S2Choice<int>(value: 7, title: 'Heart Specialist'),
    S2Choice<int>(value: 8, title: 'Psychologists'),
    S2Choice<int>(value: 9, title: 'Cardiologists'),
    S2Choice<int>(value: 10, title: 'Gynecologists'),
  ];

  List<int> hospitalValue = [4, 2];
  List<S2Choice<int>> hospitalItemList = [
    S2Choice<int>(value: 1, title: 'Modern Hospital'),
    S2Choice<int>(value: 2, title: 'Family Support Hospital'),
    S2Choice<int>(value: 3, title: 'Baliroad Medical'),
    S2Choice<int>(value: 4, title: 'Bibakor Medical College'),
    S2Choice<int>(value: 5, title: 'Mother Liver Care'),
    S2Choice<int>(value: 6, title: 'Neuro Hospital'),
    S2Choice<int>(value: 7, title: 'Cancer Reacher Center'),
    S2Choice<int>(value: 8, title: 'Child Care Hospital'),
    S2Choice<int>(value: 9, title: 'Green Life Hospital'),
    S2Choice<int>(value: 10, title: 'Premero Hospital'),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      user = jsonDecode(localStorage.getString('user'));
      model = jsonDecode(localStorage.getString('model'));

      var response = await CallApi().getDataWithToken(
        '/doctors/' + model['id'].toString() + '/times',
      );

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        times = body['data'];
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception(response.reasonPharse);
      }
    } catch (e) {
      // Handle the error
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
                name: Strings.myProfile,
                active: true,
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                infoWidget(context),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                contactInfo(Icons.phone, _getMobilePhone()),
                contactInfo(Icons.email, user['email']),
                contactInfo(Icons.rate_review, '35yr Experience'),
                contactInfo(Icons.monetization_on, model['session_price']),
                SizedBox(
                  height: Dimensions.heightSize,
                ),
                //specialistWidget(context),
                //_divider(),
                //medicalDegreeWidget(context),
                //_divider(),
                //hospitalWidget(context),
                //_divider(),
                visitingTimeWidget(context),
                _divider(),
              ],
            ),
          ),
        ),
      );
    }
  }

  infoWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize,
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Container(
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
              Container(
                height: 80,
                width: 80,
                child: Stack(
                  children: [
                    _image == null
                        ? Image.asset('assets/images/profile.png')
                        : Image.file(
                            _image,
                            fit: BoxFit.cover,
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: CustomColor.secondaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: CustomColor.primaryColor,
                          ),
                        ),
                        onTap: () {
                          _openImageSourceOptions(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: Dimensions.widthSize,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. ' + user['name'],
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
                    Strings.demoSpecialist,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: Dimensions.smallTextSize),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  contactInfo(icon, name) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize,
      ),
      child: Container(
        height: Dimensions.buttonHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(Dimensions.radius)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon),
              Text(
                name,
                style: TextStyle(color: Colors.black.withOpacity(0.7)),
              )
            ],
          ),
        ),
      ),
    );
  }

  specialistWidget(BuildContext context) {
    return SmartSelect<int>.multiple(
      title: Strings.specialist,
      value: specialistValue,
      choiceItems: specialistItemList,
      onChange: (state) => setState(() => specialistValue = state.value),
    );
  }

  medicalDegreeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.medicalDegree,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.mode_edit,
                    color: CustomColor.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddMedicalDegreeScreen()));
                  })
            ],
          ),
          _title('MBBS (DMCH)'),
          _title('FCPS (UK)'),
          _title('CBMS (America)'),
        ],
      ),
    );
  }

  hospitalWidget(BuildContext context) {
    return SmartSelect<int>.multiple(
      title: Strings.hospital,
      value: hospitalValue,
      choiceItems: hospitalItemList,
      onChange: (state) => setState(() => specialistValue = state.value),
    );
  }

  visitingTimeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.visitingTime,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.mode_edit,
                  color: CustomColor.primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SetVisitingTimeScreen(),
                    ),
                  );
                },
              )
            ],
          ),
          for (int index = 0; index < times.length; index++)
            _doctorTime(
              times[index]['date'],
              _getTimeFormated(times[index]['time_from']),
              _getTimeFormated(times[index]['time_to']),
            )
        ],
      ),
    );
  }

  _title(value) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 0.5),
      child: Text(
        value,
        style: CustomStyle.textStyle,
      ),
    );
  }

  _doctorTime(date, timeFrom, timeTo) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 0.5),
      child: Text(
        '${date} / ${timeFrom} - ${timeTo}',
        style: CustomStyle.textStyle,
      ),
    );
  }

  _divider() {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Divider(
        color: Colors.grey.withOpacity(0.5),
      ),
    );
  }

  Future<void> _openImageSourceOptions(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.camera_alt,
                    size: 40.0,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Icon(
                    Icons.photo,
                    size: 40.0,
                    color: Colors.green,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  _getTimeFormated(time) {
    DateTime tmp = DateTime.parse('2023-04-26 '+ time);
    String formattedDate = DateFormat('hh:mm a').format(tmp);
    return formattedDate;
  }

  String _getMobilePhone() {
    if (model['phone'] != null) {
      return model['phone'];
    } else {
      return 'Unknown';
    }
  }
}
