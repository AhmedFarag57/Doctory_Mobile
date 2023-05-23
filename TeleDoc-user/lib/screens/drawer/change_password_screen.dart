import 'package:flutter/material.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'package:teledoc/screens/dashboard_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

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
                name: Strings.changePassword,
                active: true,
              ),
              bodyWidget(context)
            ],
          ),
        ),
      ),
    );
  }

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
          height: height * 0.6,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputFiledWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              buttonWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  inputFiledWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(
            top: Dimensions.heightSize * 2,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleData(Strings.oldPassword),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: oldPasswordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.typePassword,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
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
            _titleData(Strings.newPassword),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: newPasswordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.typePassword,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
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
            _titleData(Strings.confirmNewPassword),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: confirmPasswordController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.typePassword,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
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
            SizedBox(height: Dimensions.heightSize),
          ],
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: GestureDetector(
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: CustomColor.primaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(Dimensions.radius),
            ),
          ),
          child: Center(
            child: Text(
              Strings.changePassword.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        onTap: () {
          if (formKey.currentState!.validate()) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ),
            );
          }
        },
      ),
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
}
