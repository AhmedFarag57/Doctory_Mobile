import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'package:teledoc/screens/dashboard_screen.dart';
import 'package:teledoc/screens/auth/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledoc/utils/laravel_echo/laravel_echo.dart';
import 'package:teledoc/dialog/loading_dialog.dart';
import 'package:teledoc/dialog/message_dialog.dart';
import 'package:teledoc/network_utils/api.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;

  Future _loginRequest(BuildContext context) async {
    // Show the Loading Dialog
    _showLoadingDialog(context);

    var data = {
      'email': emailController.text,
      'password': passwordController.text,
      'app': 'patient',
    };

    try {
      var response = await CallApi().postData(data, '/login');
      var body = json.decode(response.body);
      if (response.statusCode == 201) {
        // ..
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', json.encode(body['data']['token']));
        localStorage.setString('user', json.encode(body['data']['user']));
        localStorage.setString('model', json.encode(body['data']['model']));

        print(body['data']['token']);

        LaravelEcho.init(token: body['data']['token']);

        Navigator.of(context).pop();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DashboardScreen(),
          ),
        );
      } else {
        // Pop the loading dialog
        Navigator.of(context).pop();
        // Show the server error message
        _showErrorDialog(context, body['message']);
      }
    } catch (e) {
      // Pop the loading dialog
      Navigator.of(context).pop();
      // Show the error in Error dialog
      _showErrorDialog(context, 'Error in signin. please try again');
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
                name: Strings.signInAccount,
                active: false,
              ),
              bodyWidget(context)
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
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
          height: height * 0.7,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              headingWidget(context),
              inputFiledWidget(context),
              SizedBox(height: Dimensions.heightSize),
              rememberForgotWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              signInButtonWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              alreadyHaveAccountWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  headingWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
      child: Text(
        Strings.welcomeBack,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Dimensions.extraLargeTextSize),
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
          right: Dimensions.marginSize,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleData(Strings.email),
            Material(
              elevation: 10.0,
              shadowColor: CustomColor.secondaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius),
              child: TextFormField(
                style: CustomStyle.textStyle,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return Strings.pleaseFillOutTheField;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoEmail,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
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

  rememberForgotWidget(BuildContext context) {
    return CheckboxListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.rememberMe,
            style: CustomStyle.textStyle,
          ),
          GestureDetector(
            child: Text(
              Strings.forgotPassword,
              style: CustomStyle.textStyle,
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ForgotPasswordScreen(),
                ),
              );
            },
          ),
        ],
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue!;
        });
      },
      controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
    );
  }

  signInButtonWidget(BuildContext context) {
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
              Strings.signIn.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          if (formKey.currentState!.validate()) {
            _loginRequest(context);
          }
        },
      ),
    );
  }

  alreadyHaveAccountWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.ifYouHaveNoAccount,
          style: CustomStyle.textStyle,
        ),
        GestureDetector(
          child: Text(
            Strings.signUp.toUpperCase(),
            style: TextStyle(
                color: CustomColor.primaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        )
      ],
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

  Future<bool> _showLoadingDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => LoadingDialog(),
        )) ??
        false;
  }

  Future<bool> _showErrorDialog(BuildContext context, message) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MessageDialog(
            title: "Error",
            subTitle: message,
            action: false,
            moved: SignInScreen(),
            img: 'error.png',
            buttonName: Strings.ok,
          ),
        )) ??
        false;
  }
}
