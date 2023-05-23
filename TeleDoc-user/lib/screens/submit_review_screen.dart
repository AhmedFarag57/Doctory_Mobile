import 'package:flutter/material.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'package:teledoc/widgets/my_rating.dart';

class SubmitReviewScreen extends StatefulWidget {
  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {

  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: CustomColor.secondaryColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              BackWidget(
                name: Strings.submitReview,
                active: true,
              ),
              bodyWidget(context),
              nextButtonWidget(context)
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
          profileWidget(context),
          SizedBox(height: Dimensions.heightSize),
          reviewWidget(context)
        ],
      ),
    );
  }

  profileWidget(BuildContext context) {
    return GestureDetector(
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
    );
  }

  nextButtonWidget(BuildContext context) {
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
          
        },
      ),
    );
  }
 
  reviewWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.giveYourRating,
          style: TextStyle(
            fontSize: Dimensions.extraLargeTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.behaviour,
                    style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5),
                  MyRating(rating: '5'),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.service,
                    style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5),
                  MyRating(rating: '5')
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.cost,
                    style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5),
                  MyRating(rating: '5')
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.skill,
                    style: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5),
                  MyRating(rating: '5')
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize * 3),
        Text(
          Strings.yourComment,
          style: TextStyle(
              fontSize: Dimensions.extraLargeTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        TextFormField(
          style: CustomStyle.textStyle,
          controller: commentController,
          keyboardType: TextInputType.name,
          validator: (value) {
            if(value!.isEmpty){
              return Strings.pleaseFillOutTheField;
            }
            else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: Strings.contraryToPopular,
            contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
            labelStyle: CustomStyle.textStyle,
            filled: true,
            fillColor: Colors.black.withOpacity(0.1),
            hintStyle: CustomStyle.hintTextStyle,
            focusedBorder: CustomStyle.focusBorder,
            enabledBorder: CustomStyle.focusErrorBorder,
            focusedErrorBorder: CustomStyle.focusErrorBorder,
            errorBorder: CustomStyle.focusErrorBorder,
          ),
        ),
      ],
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
                              /*
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MessagingScreen(),
                                ),
                              );
                              */
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
