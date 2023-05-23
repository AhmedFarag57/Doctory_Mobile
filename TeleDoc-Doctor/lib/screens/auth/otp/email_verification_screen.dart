import 'package:flutter/material.dart';
import 'package:doctor/screens/auth/otp/otp_confirmation.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/dialog/success_dialog.dart';
import 'package:doctor/screens/dashboard_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String emailAddress;

  const EmailVerificationScreen({Key? key, required this.emailAddress})
      : super(key: key);

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  TextEditingController emailController = TextEditingController();
  String? _emailAddress;

  @override
  void initState() {
    super.initState();
    _emailAddress = widget.emailAddress;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.secondaryColor,
        body: OtpConfirmation(
          emailAddress: _emailAddress.toString(),
          otpLength: 4,
          validateOtp: validateOtp,
          routeCallback: moveToNextScreen,
          titleColor: Colors.black,
          themeColor: Colors.black,
          bottomColor: Colors.transparent,
          topColor: Colors.transparent,
          image: '',
          keyboardBackgroundColor: Colors.transparent,
          isGradientApplied: false,
        ),
      ),
    );
  }

  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "1234") {
      moveToNextScreen(context);
      return "OTP is Successfully Verified";
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    showSuccessDialog(context);
    print('open dialog');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }

  Future<bool> showSuccessDialog(BuildContext context) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => SuccessDialog(
            title: Strings.success,
            subTitle: Strings.nowCheckYourEmail,
            buttonName: Strings.ok,
            moved: DashboardScreen(),
          ),
        )) ??
        false;
  }
}
