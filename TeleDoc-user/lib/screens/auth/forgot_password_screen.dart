import 'package:teledoc/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BackWidget(name: Strings.forgotPassword,),
            bodyWidget(context)
          ],
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
          height: height * 0.4,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius * 2)
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.marginSize,
              right: Dimensions.marginSize,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                headingWidget(context),
                inputFieldWidget(context),
                SizedBox(height: Dimensions.heightSize * 2,),
                sendCodeButtonWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  headingWidget(BuildContext context) {
    return Text(
      Strings.forgotPassword,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.extraLargeTextSize
      ),
    );
  }

  inputFieldWidget(BuildContext context) {
    return Form(
        key: formKey,
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
                validator: (String value){
                  if(value.isEmpty){
                    return Strings.pleaseFillOutTheField;
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoEmail,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
          ],
        )
    );
  }

  sendCodeButtonWidget(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: Dimensions.buttonHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: CustomColor.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
        ),
        child: Center(
          child: Text(
            Strings.sendCode.toUpperCase(),
            style: TextStyle(
                color: Colors.white,
                fontSize: Dimensions.largeTextSize
            ),
          ),
        ),
      ),
      onTap: () {

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
        style: TextStyle(
            color: Colors.black
        ),
      ),
    );
  }

}
