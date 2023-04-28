import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teledoc/data/emergency_category.dart';
import 'package:teledoc/dialog/message_dialog.dart';
import 'package:teledoc/network_utils/api.dart';
import 'package:teledoc/screens/dashboard_screen.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'package:teledoc/widgets/emergency/heathcare_widget.dart';
//import 'package:teledoc/widgets/emergency/ambulance_widget.dart';
//import 'package:teledoc/widgets/emergency/doctor_widget.dart';
//import 'package:teledoc/widgets/emergency/location_widget.dart';

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isLoading = true;
  int currentIndex = 0;

  var doctors;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future _loadData() async {
    try {
      var response = await CallApi().getDataWithToken('/doctors');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        doctors = body['data'];
        setState(() {
          _isLoading = false;
        });
      } else {
        throw Exception();
      }
    } catch (e) {
      // Handle the error
      _showErrorDialog(context, 'Error in load doctors. Please try again');
    }
  }

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
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.5),
                    Color(0xFF4C6BFF),
                  ],
                ),
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
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
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
                    Strings.emergency,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.extraLargeTextSize * 1.6,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Dimensions.heightSize * 2,
                ),
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.searchDoctor,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 5.0,
                        ),
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
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Dimensions.heightSize * 2,
            ),
            detailsWidget(context),
          ],
        ),
      ),
    );
  }

  detailsWidget(BuildContext context) {
    if (_isLoading) {
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
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      );
    } else {
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
            ),
          ),
          child: ListView(
            //physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              categoryWidget(context),
              goToWidget(currentIndex),
            ],
          ),
        ),
      );
    }
  }

  categoryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
      child: Container(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: EmergencyCategoryList.list().length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            EmergencyCategory category = EmergencyCategoryList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.widthSize * 2,
                right: Dimensions.widthSize,
                top: 10,
                bottom: 10,
              ),
              child: GestureDetector(
                child: Container(
                  height: 100,
                  width: 80,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? CustomColor.accentColor
                        : Colors.white,
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
                      Image.asset(category.image),
                      SizedBox(
                        height: Dimensions.heightSize,
                      ),
                      Text(
                        category.name,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.smallTextSize,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  goToWidget(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HealthCareWidget(doctors);
      // case 1:
      //   return AmbulanceWidget();
      // case 2:
      //   return LocationWidget();
      // case 3:
      //   return DoctorWidget();
    }
  }

  Future<bool> _showErrorDialog(BuildContext context, message) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MessageDialog(
            title: "Error",
            subTitle: message,
            action: true,
            moved: DashboardScreen(),
            img: 'error.png',
            buttonName: Strings.ok,
          ),
        )) ??
        false;
  }
}
