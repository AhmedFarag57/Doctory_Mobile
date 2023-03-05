import 'dart:convert';

import 'package:doctor/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/widgets/back_widget.dart';
import 'package:doctor/screens/auth/otp/email_verification_screen.dart';

import '../../dialog/success_dialog.dart';
import '../../network_utils/api.dart';
import '../loading/loading_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ssnController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;
  bool isLoading = false;

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
                  BackWidget(
                    name: Strings.createAnAccount,
                  ),
                  bodyWidget(context)
                ],
              ),
            ),
          ),
        );

  bodyWidget(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        ),
        child: Container(
          height: height * 0.7,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                headingWidget(context),
                SizedBox(
                  height: Dimensions.heightSize * 2,
                ),
                inputFieldWidget(context),
                termsCheckBoxWidget(context),
                signUpButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  headingWidget(BuildContext context) {
    return Text(
      Strings.createAnAccount,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.extraLargeTextSize),
    );
  }

  inputFieldWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleData(Strings.name),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Type your name",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                ),
              ),
            ),
            _titleData(Strings.email),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoEmail,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                ),
              ),
            ),
            _titleData(Strings.password),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: passwordController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.typePassword,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _toggleVisibility = !_toggleVisibility;
                      });
                    },
                    icon: _toggleVisibility
                        ? Icon(
                            Icons.visibility_off,
                            color: CustomColor.greyColor,
                          )
                        : Icon(
                            Icons.visibility,
                            color: CustomColor.greyColor,
                          ),
                  ),
                ),
                obscureText: _toggleVisibility,
              ),
            ),
            _titleData("SSN"),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: ssnController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Type SSN",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize),
          ],
        ));
  }

  termsCheckBoxWidget(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "I accept the ",
            style: CustomStyle.textStyle,
          ),
          GestureDetector(
            child: Text(
              "Terms and Conditions",
              style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.blueColor,
                  decoration: TextDecoration.underline),
            ),
            onTap: () {
              print('go to privacy url');
              _showTermsConditions();
            },
          ),
        ],
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  signUpButton(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: Dimensions.buttonHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: CustomColor.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))),
        child: Center(
          child: Text(
            Strings.signUp.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onTap: () async {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => EmailVerificationScreen(
        //           emailAddress: emailController.text,
        //         )));
        if (formKey.currentState.validate()) {
          setState(() => isLoading = true);

          var data = {
            'name': nameController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'ssn': ssnController.text,
            'isDoctor': true
          };

          var response = await CallApi().postData(data, '/doctors');

          var body = json.decode(response.body);

          if (body['success']) {
            setState(() => isLoading = false);

            showSuccessDialog(context);
          } else {
            
            // ...
          }
        }
      },
    );
  }

  _titleData(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: Dimensions.heightSize * 0.5,
        top: Dimensions.heightSize,
      ),
      child: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Future<bool> _showTermsConditions() async {
    return (await showDialog(
          context: context,
          builder: (context) => Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: CustomColor.primaryColor,
            child: Stack(
              children: [
                Positioned(
                    top: -35.0,
                    left: -50.0,
                    child: Image.asset('assets/images/splash_logo.png')),
                Positioned(
                    right: -35.0,
                    bottom: -20.0,
                    child: Image.asset('assets/images/splash_logo.png')),
                Padding(
                  padding: const EdgeInsets.only(
                      top: Dimensions.defaultPaddingSize * 2,
                      bottom: Dimensions.defaultPaddingSize * 2),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: AlertDialog(
                        content: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 45,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Dimensions.heightSize * 2,
                                ),
                                Text(
                                  Strings.ourPolicyTerms,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accentColor,
                                          fontSize:
                                              Dimensions.extraLargeTextSize),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'simply random text. It has roots in a piece of classical Latin literature ',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accentColor,
                                          fontSize:
                                              Dimensions.extraLargeTextSize),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Distracted by the readable content of a page when looking at its layout.',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accentColor,
                                          fontSize:
                                              Dimensions.extraLargeTextSize),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Available, but the majority have suffered alteration',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 2,
                                ),
                                Text(
                                  'When do we contact information ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 2,
                                ),
                                Text(
                                  'Do we use cookies ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 35.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          color: CustomColor.secondaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Center(
                                        child: Text(
                                          Strings.decline,
                                          style: TextStyle(
                                              color: CustomColor.primaryColor,
                                              fontSize:
                                                  Dimensions.defaultTextSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  GestureDetector(
                                    child: Container(
                                      height: 35.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0))),
                                      child: Center(
                                        child: Text(
                                          Strings.agree,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.defaultTextSize,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                  ),
                ),
              ],
            ),
          ),
        )) ??
        false;
  }

  Future<bool> showSuccessDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => SuccessDialog(
            title: Strings.success,
            subTitle: "Account created successfully",
            buttonName: Strings.ok,
            moved: SignInScreen(),
          ),
        )) ??
        false;
  }
}
