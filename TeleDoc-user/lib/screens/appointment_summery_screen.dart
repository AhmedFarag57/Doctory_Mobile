import 'package:flutter/material.dart';
import 'package:teledoc/screens/dashboard_screen.dart';
import 'package:teledoc/widgets/back_widget.dart';

import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';

class AppointmentSummeryScreen extends StatefulWidget {
  @override
  _AppointmentSummeryScreenState createState() => _AppointmentSummeryScreenState();
}

enum SingingCharacter { cash, card, mobileBanking}

class _AppointmentSummeryScreenState extends State<AppointmentSummeryScreen> {

  SingingCharacter _character = SingingCharacter.cash;

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
              BackWidget(name: Strings.appointmentSummery,),
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
            SizedBox(height: Dimensions.heightSize),
            paymentWidget(context),
            SizedBox(height: Dimensions.heightSize * 7),
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
          Text(
            Strings.appointmentDetails,
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimensions.largeTextSize,
                fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: Dimensions.heightSize),
          _titleData(Strings.name, Strings.age, Strings.demoName, '69'),
          _titleData(Strings.patientSex, Strings.patientId, 'Male', '7865KD'),
          _titleData(Strings.date, Strings.time, '22 Dec, 2020', '03:00-04:00pm'),
          _titleData(Strings.chamber, Strings.roomNo, 'Modern Hospital', '250'),
          _titleData(Strings.fee, '', '\$250', ''),
        ],
      ),
    );
  }

  paymentWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 3, left: Dimensions
          .marginSize, right: Dimensions.marginSize),
      child: Column(
        children: [
          Container(
            height: 60.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
            ),
            child: ListTile(
              title: Text(
                Strings.cash.toUpperCase(),
                style: CustomStyle.textStyle,
              ),
              leading: Radio(
                value: SingingCharacter.cash,
                toggleable : true,
                autofocus : true,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    print('value: '+_character.toString());
                  });
                },
              ),
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
            ),
            child: ListTile(
              title: Row(
                children: [
                  Image.asset(
                    'assets/images/visa.png',
                    height: 30.0,
                  ),
                  SizedBox(width: Dimensions.widthSize,),
                  Image.asset(
                    'assets/images/credit_card.png',
                    height: 30.0,
                  ),
                ],
              ),
              leading: Radio(
                value: SingingCharacter.card,
                toggleable : true,
                autofocus : true,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    print('value: '+_character.toString());
                  });
                },
              ),
            ),
          ),
          _character.toString() == 'SingingCharacter.card'? Column(
            children: [
              SizedBox(height: Dimensions.heightSize,),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.asset(
                          'assets/images/visa.png',
                          height: 100.0,
                          width: 150.0,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(width: Dimensions.widthSize,),
                        Image.asset(
                          'assets/images/credit_card.png',
                          height: 100.0,
                          width: 150.0,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(width: Dimensions.widthSize,),
                        GestureDetector(
                          child: Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                            ),
                            child: Center(
                              child: Text(
                                '${Strings.addNewCard.toUpperCase()} + ',
                                style: CustomStyle.textStyle,
                              ),
                            ),
                          ),
                          onTap: () {
                            /*Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                AddNewCardScreen()));*/
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ) : Container(),
          SizedBox(height: Dimensions.heightSize,),
          Container(
            height: 60.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
            ),
            child: ListTile(
              title: Text(
                Strings.mobileBanking.toUpperCase(),
                style: CustomStyle.textStyle,
              ),
              leading: Radio(
                value: SingingCharacter.mobileBanking,
                toggleable : true,
                autofocus : true,
                groupValue: _character,
                onChanged: (SingingCharacter value) {
                  setState(() {
                    _character = value;
                    print('value: '+_character.toString());
                  });
                },
              ),
            ),
          ),
        ],
      ),
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
              Strings.sendAppointmentRequest.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () {
          _showPaymentSuccessDialog();
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

  Future<bool> _showPaymentSuccessDialog() async {
    return (await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => new AlertDialog(
        content: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  'assets/images/tik.png'
              ),
              Text(
                Strings.successfullySendYourRequest,
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: CustomColor.primaryColor,
                    fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                child: Container(
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                  ),
                  child: Center(
                    child: Text(
                      Strings.ok.toUpperCase(),
                      style: TextStyle(
                          fontSize: Dimensions.extraLargeTextSize,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                  DashboardScreen()));
                },
              )
            ],
          ),
        ),

      ),
    )) ?? false;
  }

}
