import 'package:flutter/material.dart';
import 'package:teledoc/data/top_doctor.dart';
import 'package:teledoc/screens/doctor_details_screen.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';

class DoctorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2,
        bottom: Dimensions.heightSize * 2,
      ),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: TopDoctorList.list().length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            TopDoctor topDoctor = TopDoctorList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.widthSize * 2,
                  right: Dimensions.widthSize,
                  top: 10,
                  bottom: 10
              ),
              child: GestureDetector(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          topDoctor.image
                      ),
                      SizedBox(height: Dimensions.heightSize,),
                      Text(
                        topDoctor.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Dimensions.heightSize * 0.5,),
                      Text(
                        topDoctor.specialist,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: Dimensions.smallTextSize
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Dimensions.heightSize * 0.5,),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: CustomColor.primaryColor,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      DoctorDetailsScreen(
                        image: topDoctor.image,
                        name: topDoctor.name,
                        session_price: topDoctor.specialist,
                        rating: topDoctor.available,
                      )));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
