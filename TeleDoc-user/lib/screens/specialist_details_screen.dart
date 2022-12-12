import 'package:flutter/material.dart';
import 'package:teledoc/data/category.dart';
import 'package:teledoc/data/doctor.dart';

import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'package:teledoc/widgets/my_rating.dart';

class SpecialistDetailsScreen extends StatefulWidget {
  final Category specialist;

  const SpecialistDetailsScreen({Key key, this.specialist}) : super(key: key);

  @override
  _SpecialistDetailsScreenState createState() => _SpecialistDetailsScreenState();
}

class _SpecialistDetailsScreenState extends State<SpecialistDetailsScreen> {
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
              BackWidget(name: widget.specialist.name,),
              bodyWidget(context),
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
        child: ListView.builder(
          itemCount: DoctorList.list().length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Doctor doctor = DoctorList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.widthSize * 2,
                  right: Dimensions.widthSize,
                  top: 10,
                  bottom: 10
              ),
              child: Container(
                width: 150,
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
                          doctor.image
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctor.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Text(
                            doctor.specialist,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: Dimensions.smallTextSize
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Text(
                            doctor.available,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: Dimensions.smallTextSize
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          MyRating(rating: doctor.rating,),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
