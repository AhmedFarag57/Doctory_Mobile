import 'dart:async';
import 'dart:convert';
import 'package:doctor/screens/auth/sign_in_screen.dart';
import 'package:doctor/screens/help_support_screen.dart';
import 'package:doctor/screens/my_card_screen.dart';
import 'package:doctor/screens/my_profile_screen.dart';
import 'package:doctor/screens/settings_screen.dart';
import 'package:doctor/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor/dialog/loading_dialog.dart';
import 'package:doctor/network_utils/api.dart';
import 'package:doctor/utils/laravel_echo/laravel_echo.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  var user;
  var model;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      user = jsonDecode(localStorage.getString('user')!);
      model = jsonDecode(localStorage.getString('model')!);
      Timer(
        Duration(seconds: 1),
        (() {
          setState(() {
            _isLoading = false;
          });
        }),
      );
    } catch (e) {
      // Handle the error
    }
  }

  Future _logoutRequest(BuildContext context) async {
    // Show the loading dialog
    showLoadingDialog(context);
    try {
      var response = await CallApi().getDataWithToken('/logout');
      if (response.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('user');
        localStorage.remove('token');
        localStorage.remove('model');
        // Disconnect the LaravelEcho
        LaravelEcho.instance.disconnect();
        // Pop the loading dialog
        Navigator.of(context).pop();
        // Go to Signin Screen
        _goToSigninScreen(context);
      } else {
        throw Exception(response.reasonPharse);
      }
    } catch (e) {
      // Pop the loading dialog
      Navigator.of(context).pop();
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
              HeaderWidget(
                name: Strings.myAccount,
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
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
                  height: Dimensions.heightSize * 2,
                ),
                actionWidget(context)
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
              Image.asset('assets/images/profile.png'),
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
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  Text(
                    user['email'],
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: Dimensions.smallTextSize,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: Dimensions.heightSize * 0.5,
                  ),
                  Text(
                    _getMobilePhone(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: Dimensions.smallTextSize,
                    ),
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

  actionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: CustomColor.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 64.0,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize,
                          ),
                          Text(
                            Strings.myProfile,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.largeTextSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyProfileScreen(),
                      ),
                    );
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
                    height: 150,
                    decoration: BoxDecoration(
                      color: CustomColor.accentColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.wallet,
                            color: Colors.white,
                            size: 64.0,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize,
                          ),
                          Text(
                            Strings.myWallet,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.largeTextSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MyCardScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: CustomColor.accentColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 64.0,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize,
                          ),
                          Text(
                            Strings.settings,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.largeTextSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(),
                      ),
                    );
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
                    height: 150,
                    decoration: BoxDecoration(
                      color: CustomColor.primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.support_agent,
                            color: Colors.white,
                            size: 64.0,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize,
                          ),
                          Text(
                            Strings.helpSupport,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.largeTextSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => HelpSupportScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Row(
            children: [
              GestureDetector(
                child: Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 64.0,
                        ),
                        SizedBox(
                          height: Dimensions.heightSize,
                        ),
                        Text(
                          Strings.signOut,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.largeTextSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  _logoutRequest(context);
                },
              ),
            ],
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
        ],
      ),
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

  _goToSigninScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return SignInScreen();
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  String _getMobilePhone() {
    if (model['phone'] != null) {
      return model['phone'];
    } else {
      return 'Phone: Unknown';
    }
  }
}
