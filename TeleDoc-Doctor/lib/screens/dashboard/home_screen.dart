import 'package:doctor/data/recent.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';

import '../notification_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.radius * 4),
                bottomRight: Radius.circular(Dimensions.radius * 4),
              ),
              child: Image.asset(
                'assets/images/home_bg.png',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
                //colorBlendMode: BlendMode.dst,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient (
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [
                        Color(0xFF4C6BFF).withOpacity(0.8),
                        Color(0xFF4C6BFF).withOpacity(0.8),
                      ]
                  ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius * 4),
                  bottomRight: Radius.circular(Dimensions.radius * 4),
                ),
              ),
            ),
            headerWidget(context),
          ],
        ),
      ),
    );
  }

  headerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: Dimensions.heightSize
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          //physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
                top: Dimensions.heightSize,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 40,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0)
                              ),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: CustomColor.primaryColor,
                              )
                          ),
                          Positioned(
                            right: -5,
                            top: -5,
                            child: Container(
                              height: 20.0,
                              width: 20.0,
                              decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Center(
                                child: Text(
                                  '02',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.smallTextSize
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      NotificationScreen()));
                    },
                  ),
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
                    Strings.letsFindYourAppointedPatient,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize * 1.6,
                        fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
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
        top: Dimensions.heightSize * 2
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            statisticWidgets(context),
            recentlyAppointedWidget(context)
          ],
        ),
      ),
    );
  }

  statisticWidgets(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.totalPatients,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize,),
                  Text(
                    '12,265',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: Dimensions.widthSize,),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: CustomColor.accentColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.totalAppointed,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize,),
                  Text(
                    '25',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  recentlyAppointedWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: Dimensions.heightSize * 2,
        bottom: Dimensions.heightSize * 2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: Dimensions.marginSize
            ),
            child: Text(
              Strings.recentlyAppointed,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: RecentList.list().length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Recent recent = RecentList.list()[index];
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                                recent.image
                            ),
                            SizedBox(width: Dimensions.widthSize,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recent.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: Dimensions.heightSize * 0.5,),
                                Text(
                                  recent.problem,
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: Dimensions.smallTextSize
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: Dimensions.heightSize * 0.5,),
                                Row(
                                  children: [
                                    Text(
                                      recent.time,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: Dimensions.smallTextSize
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(width: Dimensions.widthSize * 0.5,),
                                    Text(
                                      recent.date,
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: Dimensions.smallTextSize
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize * 0.5,),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: CustomColor.primaryColor,
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          'assets/images/message.png'
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.widthSize * 0.5,),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            'assets/images/call.png'
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.widthSize * 0.5,),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                            'assets/images/video.png'
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {

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
