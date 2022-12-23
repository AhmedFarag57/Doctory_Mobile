import 'package:flutter/material.dart';
import 'package:teledoc/screens/input_patient_details_screen.dart';

import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'package:teledoc/widgets/filter_chip_widget.dart';
import 'package:teledoc/widgets/my_rating.dart';

class SetAppointmentScreen extends StatefulWidget {
  final String image, name, specialist, available;

  const SetAppointmentScreen({Key key, this.image, this.name, this.specialist, this.available}) : super(key: key);
  @override
  _SetAppointmentScreenState createState() => _SetAppointmentScreenState();
}

class _SetAppointmentScreenState extends State<SetAppointmentScreen> {

  DateTime selectedDate = DateTime.now();
  String date = 'Select date';

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
              BackWidget(name: Strings.setAppointment,),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            profileWidget(context),
            SizedBox(height: Dimensions.heightSize * 3,),
            selectDateWidget(context),
            SizedBox(height: Dimensions.heightSize * 3,),
            selectTimeWidget(context)
          ],
        ),
      ),
    );
  }

  profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                widget.image,
                height: 60,
                width: 60,
              ),
              SizedBox(width: Dimensions.widthSize,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  Text(
                    widget.specialist,
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: Dimensions.smallTextSize
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  Text(
                    widget.available,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: Dimensions.smallTextSize
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  Text(
                    'Fee \$200',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: Dimensions.smallTextSize,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  MyRating(rating: '5',)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  selectDateWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.selectDate,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Dimensions.largeTextSize
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          GestureDetector(
            child: Container(
              height: Dimensions.buttonHeight,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1)),
                borderRadius: BorderRadius.circular(Dimensions.radius)
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7)
                      ),
                    ),
                    Image.asset(
                      'assets/images/calender.png'
                    )
                  ],
                ),
              ),
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
        ],
      ),
    );
  }

  selectTimeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.selectTime,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.largeTextSize
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Align
              (
              alignment: Alignment.centerLeft,
              child: Container(
                child: Wrap(
                  spacing: 5.0,
                  runSpacing: 5.0,
                  children: <Widget>[
                    FilterChipWidget(chipName: '8:00 am'),
                    FilterChipWidget(chipName: '9:00 am'),
                    FilterChipWidget(chipName: '10:00 am'),
                    FilterChipWidget(chipName: '11:00 am'),
                    FilterChipWidget(chipName: '12:00 pm'),
                    FilterChipWidget(chipName: '1:00 pm'),
                    FilterChipWidget(chipName: '2:00 am'),
                    FilterChipWidget(chipName: '3:00 am'),
                    FilterChipWidget(chipName: '4:00 am'),
                    FilterChipWidget(chipName: '5:00 am'),
                    FilterChipWidget(chipName: '6:00 pm'),
                    FilterChipWidget(chipName: '7:00 pm'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
        print('date: '+date);
      });
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
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
          ),
          child: Center(
            child: Text(
              Strings.next.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              InputPatientDetailsScreen()));
        },
      ),
    );
  }

}