import 'package:flutter/material.dart';
import 'package:teledoc/screens/submit_review_screen.dart';
import 'package:teledoc/widgets/back_widget.dart';

import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';

import 'messaging_screen.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  @override
  _AppointmentDetailsScreenState createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {

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
              BackWidget(name: Strings.appointmentDetails,),
              bodyWidget(context),
              finishButtonWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
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
            )
        ),
        child: ListView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
            detailsWidget(context),
          ],
        ),
      ),
    );
  }

  detailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        top: Dimensions.heightSize
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
                    Image.asset(
                        'assets/images/nearby/1.png'
                    ),
                    SizedBox(width: Dimensions.widthSize,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.demoName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.defaultTextSize,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Dimensions.heightSize * 0.5,),
                        Text(
                          'Liver Specialist',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: Dimensions.smallTextSize
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              openContactDoctorDialog(context);
            },
          ),
          SizedBox(height: Dimensions.heightSize),
          _titleData(Strings.name, Strings.age, Strings.demoName, '69'),
          _titleData(Strings.patientSex, Strings.patientId, 'Male', '7865KD'),
          _titleData(Strings.date, Strings.time, '22 Dec, 2020', '03:00-04:00pm'),
          _titleData(Strings.chamber, Strings.roomNo, 'Modern Hospital', '250'),
          _titleData(Strings.fee, 'Status', '\$250', 'Appointment'),
        ],
      ),
    );
  }

  finishButtonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize * 2,
      left: Dimensions.marginSize * 2,
      right: Dimensions.marginSize * 2,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: CustomColor.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 0.5))
          ),
          child: Center(
            child: Text(
              Strings.finish.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SubmitReviewScreen()));
        },
      ),
    );
  }

  _titleData(String title1, String title2, String value1, String value2){
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
                  style: CustomStyle.textStyle
              ),
              Text(
                  title2,
                  style: CustomStyle.textStyle
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
                      fontSize: Dimensions.defaultTextSize
                  )
              ),
              Text(
                  value2,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Dimensions.defaultTextSize
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  openContactDoctorDialog(BuildContext context){
    showGeneralDialog(
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
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
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: Dimensions.heightSize * 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Image.asset(
                                  'assets/images/message.png'
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                  MessagingScreen()));
                            },
                          ),
                          SizedBox(width: Dimensions.widthSize),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Image.asset(
                                  'assets/images/call.png'
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                          SizedBox(width: Dimensions.widthSize),
                          GestureDetector(
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Image.asset(
                                  'assets/images/video.png'
                              ),
                            ),
                            onTap: () {

                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        });
  }
}
