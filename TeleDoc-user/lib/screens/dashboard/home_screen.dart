import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:teledoc/data/category.dart';
import 'package:teledoc/data/nearby.dart';
import 'package:teledoc/data/top_doctor.dart';
import 'package:teledoc/screens/doctor_details_screen.dart';
import 'package:teledoc/screens/drawer/change_password_screen.dart';
import 'package:teledoc/screens/drawer/help_support_screen.dart';
import 'package:teledoc/screens/drawer/my_appointment_screen.dart';
import 'package:teledoc/screens/drawer/my_card_screen.dart';
import 'package:teledoc/screens/drawer/pill_reminder_screen.dart';
import 'package:teledoc/screens/notification_screen.dart';
import 'package:teledoc/screens/search_result_screen.dart';
import 'package:teledoc/screens/specialist_details_screen.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/custom_style.dart';
import 'package:teledoc/screens/auth/sign_in_screen.dart';
import 'package:teledoc/network_utils/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teledoc/models/Doctor.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var user;
  var doctors;

  @override
  void initState() {
    _getUserData();
    _getAllDoctors();

    super.initState();
  }

  _getUserData() async {
    // Get the user data from phone storage
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.get('user'));
  }

  _getAllDoctors() async {
    var response = await CallApi().getDataWithToken('/doctors');
    var body = jsonDecode(response.body);

    if (body['success']) {
      doctors = body['data'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Container(
            color: CustomColor.primaryColor,
            child: ListView(
              //portant: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: profileWidget(context),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                  ),
                ),
                listData('assets/images/icon/appointment.png',
                    Strings.myAppointment, MyAppointmentScreen(id: user['id'])),
                listData('assets/images/icon/change.png',
                    Strings.changePassword, ChangePasswordScreen()),
                listData('assets/images/icon/card.png', Strings.myCard,
                    MyCardScreen()),
                listData('assets/images/icon/reminder.png',
                    Strings.pillReminder, PillReminderScreen()),
                listData('assets/images/icon/settings.png', Strings.helpSupport,
                    HelpSupportScreen()),
                logoutListData('assets/images/icon/signout.png',
                    Strings.signOut, SignInScreen()),
              ],
            ),
          ),
        ),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              'assets/images/home_bg.png',
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
                  ])),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/bg.png',
                height: MediaQuery.of(context).size.height * 0.5,
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

  profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 3,
      ),
      child: ListTile(
        leading: Image.asset(
          'assets/images/profile.png',
        ),
        title: Text(
          user['name'],
          //Strings.demoName,
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.largeTextSize,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          user['phone_number'],
          //Strings.demoPhoneNumber,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.defaultTextSize,
          ),
        ),
      ),
    );
  }

  logoutListData(String icon, String title, Widget goTo) {
    return ListTile(
      leading: Image.asset(icon),
      title: Text(
        title,
        style: CustomStyle.listStyle,
      ),
      onTap: () async {
        var response = await CallApi().getDataWithToken('/logout');

        var body = json.decode(response.body);

        if (body['success']) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.remove('user');
          localStorage.remove('token');

          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => goTo));
        }
      },
    );
  }

  listData(String icon, String title, Widget goTo) {
    return ListTile(
      leading: Image.asset(icon),
      title: Text(
        title,
        style: CustomStyle.listStyle,
      ),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => goTo));
      },
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
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      if (scaffoldKey.currentState.isDrawerOpen) {
                        scaffoldKey.currentState.openEndDrawer();
                      } else {
                        scaffoldKey.currentState.openDrawer();
                      }
                    },
                  ),
                  // GestureDetector(
                  //   child: Container(
                  //     height: 40,
                  //     width: 40,
                  //     child: Stack(
                  //       clipBehavior: Clip.none,
                  //       children: [
                  //         Container(
                  //             height: 40,
                  //             width: 40.0,
                  //             decoration: BoxDecoration(
                  //                 color: CustomColor.primaryColor,
                  //                 borderRadius: BorderRadius.circular(20.0)),
                  //             child: Icon(
                  //               Icons.notifications_outlined,
                  //               color: Colors.white,
                  //             )),
                  //         Positioned(
                  //           right: -5,
                  //           top: -5,
                  //           child: Container(
                  //             height: 20.0,
                  //             width: 20.0,
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(10.0)),
                  //             child: Center(
                  //               child: Text(
                  //                 '02',
                  //                 style: TextStyle(
                  //                     color: CustomColor.primaryColor,
                  //                     fontSize: Dimensions.smallTextSize),
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => NotificationScreen()));
                  //   },
                  // ),
                ],
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
                    Strings.letsFindYourSpecialist,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize * 1.6,
                        fontWeight: FontWeight.bold),
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
                            vertical: 5.0, horizontal: 5.0),
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchResultScreen()));
                          },
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
            )),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            //categoryWidget(context),
            //topDoctorWidget(context),
            nearbyDoctorWidget(context)
          ],
        ),
      ),
    );
  }

  categoryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
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
                  bottom: 10),
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
                      Image.asset(category.image),
                      SizedBox(
                        height: Dimensions.heightSize,
                      ),
                      Text(
                        category.name,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.smallTextSize),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SpecialistDetailsScreen(
                            specialist: category,
                          )));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  topDoctorWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Text(
              Strings.topDoctor,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Container(
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
                      bottom: 10),
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
                          Image.asset(topDoctor.image),
                          SizedBox(
                            height: Dimensions.heightSize,
                          ),
                          Text(
                            topDoctor.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: Dimensions.defaultTextSize,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 0.5,
                          ),
                          Text(
                            topDoctor.specialist,
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: Dimensions.smallTextSize),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: Dimensions.heightSize * 0.5,
                          ),
                          Text(
                            topDoctor.available,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: Dimensions.smallTextSize),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DoctorDetailsScreen(
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
        ],
      ),
    );
  }

  nearbyDoctorWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2,
        bottom: Dimensions.heightSize * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Text(
              Strings.nearbyDoctor,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Dimensions.heightSize,
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: doctors.length,
              //itemCount: NearbyList.list().length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Nearby nearby = NearbyList.list()[index];
                // Doctor doctor = doctors[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: Dimensions.widthSize * 2,
                      right: Dimensions.widthSize,
                      top: 10,
                      bottom: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(nearby.image),
                            SizedBox(
                              width: Dimensions.widthSize,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. " + doctors[index]['name'],
                                  //nearby.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  "Session Price: " + doctors[index]['session_price'].toString(),
                                  //nearby.specialist,
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: Dimensions.smallTextSize),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  'Rating: ' + doctors[index]['rating'],
                                  //nearby.available,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: Dimensions.smallTextSize),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Text(
                                  doctors[index]['clinic_address'],
                                  //nearby.address,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6),
                                      fontSize: Dimensions.smallTextSize),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DoctorDetailsScreen(
                              id: doctors[index]['id'].toString(),
                              image: nearby.image,
                              name: doctors[index]['name'],
                              session_price: doctors[index]['session_price'],
                              rating: doctors[index]['rating'],
                              clinic_address: doctors[index]['clinic_address'],
                            )));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
