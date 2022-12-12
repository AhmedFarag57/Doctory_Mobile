import 'package:flutter/material.dart';
import 'package:teledoc/data/category.dart';
import 'package:teledoc/data/doctor.dart';
import 'package:teledoc/data/nearby.dart';
import 'package:teledoc/screens/specialist_details_screen.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';

class SearchResultScreen extends StatefulWidget {
  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {

  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              'assets/images/search_bg.png',
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              //colorBlendMode: BlendMode.dst,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  gradient: LinearGradient (
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.5),
                        Color(0xFF4C6BFF),
                      ]
                  )
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/bg.png',
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            ),
            bodyWidget(context)
          ],
        ),
      ),
    );
  }

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.heightSize
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
                top: Dimensions.heightSize,
              ),
              child: GestureDetector(
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      Text(
                        Strings.back,
                        style: TextStyle(
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2,
                  ),
                  child: Text(
                    Strings.searchResult,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize * 1.6,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 2,),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize * 2,
                    right: Dimensions.marginSize * 2,
                  ),
                  child: Container(
                    height: Dimensions.buttonHeight,
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      validator: (String value){
                        if(value.isEmpty){
                          return Strings.pleaseFillOutTheField;
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.searchDoctor,
                        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal:
                        5.0),
                        labelStyle: CustomStyle.textStyle,
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.searchBox,
                        enabledBorder: CustomStyle.searchBox,
                        focusedErrorBorder: CustomStyle.searchBox,
                        errorBorder: CustomStyle.searchBox,
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          onPressed: (){

                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Dimensions.heightSize * 2,),
            detailsWidget(context)
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
          shrinkWrap: true,
          children: [
            categoryWidget(context),
            onlineDoctorWidget(context),
            doctorWidget(context)
          ],
        ),
      ),
    );
  }

  categoryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2
      ),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: CategoryList.list().length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Category category = CategoryList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.widthSize * 2,
                  right: Dimensions.widthSize,
                top: 10,
                bottom: 10
              ),
              child: GestureDetector(
                child: Container(
                  height: 100,
                  width: 80,
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
                          category.image
                      ),
                      SizedBox(height: Dimensions.heightSize,),
                      Text(
                        category.name,
                        style: TextStyle(
                            color: Colors.black,
                          fontSize: Dimensions.smallTextSize
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      SpecialistDetailsScreen(specialist: category,)));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  onlineDoctorWidget(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: DoctorList.list().length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          Doctor doctor = DoctorList.list()[index];
          return Padding(
            padding: const EdgeInsets.only(
              left: Dimensions.marginSize
            ),
            child: Container(
              height: 60,
              width: 60,
              child: Stack(
                children: [
                  Image.asset(
                    doctor.image,
                    height: 60,
                    width: 60,
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  doctorWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2,
        bottom: Dimensions.heightSize * 2,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: NearbyList.list().length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            Nearby nearby = NearbyList.list()[index];
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
                          nearby.image
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nearby.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Text(
                            nearby.specialist,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: Dimensions.smallTextSize
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Text(
                            nearby.available,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: Dimensions.smallTextSize
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Dimensions.heightSize * 0.5,),
                          Text(
                            nearby.address,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: Dimensions.smallTextSize
                            ),
                            textAlign: TextAlign.center,
                          ),
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
