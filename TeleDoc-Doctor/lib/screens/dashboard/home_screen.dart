import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/dialog/message_dialog.dart';
import 'package:doctor/network_utils/api.dart';
import 'package:doctor/screens/auth/sign_in_screen.dart';
import 'package:doctor/screens/loading/loading_screen.dart';
import 'package:doctor/screens/messaging_screen.dart';
import 'package:doctor/screens/specific_notification_screen.dart';
import 'package:doctor/screens/video_call_screen.dart';
import 'package:doctor/screens/videocall_screen.dart';
import 'package:doctor/utils/laravel_echo/laravel_echo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctor/screens/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isLoading = true;

  var totalAppointed;
  var totalPatients = 0;
  var recentlyAppointed;
  var notificationCount = 0;
  var user;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not accepted permisson');
      }
    }
  }

  Future<void> _getToken() async {
    await FirebaseMessaging.instance.getToken().then(
      (token) {
        setState(() {
          if (kDebugMode) {
            print('The firebase token: $token');
          }
        });
        _saveFirebaseToken(token!);
        _updateFirebaseToken(token);
      },
    );
  }

  void _saveFirebaseToken(String token) async {
    await FirebaseFirestore.instance
        .collection("UserTokens")
        .doc("User${user['id']}")
        .set({
      'token': token,
    });
  }

  void _initInfo() {
    var andriodInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInitialize = const IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: andriodInitialize,
      iOS: iosInitialize,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        try {
          if (payload != null && payload.isNotEmpty) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) {
                  return SpecificNotificationScreen(info: payload.toString());
                }),
              ),
            );
          }
        } catch (e) {
          // ..
        }
        return;
      },
    );

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );

        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          'serenity',
          'serenity',
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true,
          sound: const RawResourceAndroidNotificationSound('notification'),
        );

        NotificationDetails platformChannel = NotificationDetails(
          android: androidNotificationDetails,
          iOS: const IOSNotificationDetails(),
        );

        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          platformChannel,
          payload: message.data['body'],
        );
      },
    );
  }

  void _updateFirebaseToken(String token) async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();

      var data = {
        'firebaseToken': token,
      };

      var response = await CallApi().postDataWithToken(
        data,
        '/firebase/token/update',
      );

      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        localStorage.setString('user', json.encode(body['data']));
      }
    } catch (e) {}
  }

  Future<void> _loadData() async {
    try {
      _requestPermission();
      await _getToken();
      _initInfo();
    } catch (e) {
      // ..
    }

    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var model = jsonDecode(localStorage.getString('model')!);
      user = jsonDecode(localStorage.getString('user')!);
      var id = model['id'];
      var response;
      var body;

      // get total appointed
      response = await CallApi().getDataWithToken(
        '/doctors/' + id.toString() + '/appointments/count',
      );

      body = json.decode(response.body);

      if (response.statusCode == 200) {
        totalAppointed = body['data'];
      } else {
        throw Exception(response.reasonPhrase);
      }

      // get total patients
      // ..

      // get recently appointed
      response = await CallApi().getDataWithToken(
        '/doctors/' + id.toString() + '/appointments',
      );

      body = json.decode(response.body);

      if (response.statusCode == 200) {
        recentlyAppointed = body['data'];
      } else {
        throw Exception(response.reasonPhrase);
      }

      // Pop the loading page
      setState(() => _isLoading = false);
    } catch (e) {
      // handle the logout process
      _handleTheLogout();
    }
  }

  @override
  Widget build(BuildContext context) => _isLoading
      ? const LoadingPage()
      : SafeArea(
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
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color(0xFF4C6BFF).withOpacity(0.8),
                          Color(0xFF4C6BFF).withOpacity(0.8),
                        ]),
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

  headerWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
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
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Icon(
                              Icons.notifications_outlined,
                              color: CustomColor.primaryColor,
                            ),
                          ),
                          if (notificationCount > 0)
                            Positioned(
                              right: -5,
                              top: -5,
                              child: Container(
                                height: 20.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.smallTextSize,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            Positioned(
                              right: -5,
                              top: -5,
                              child: Container(
                                height: 20.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                  color: CustomColor.primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    notificationCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: Dimensions.smallTextSize,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
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
                      fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 2),
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
                  borderRadius: BorderRadius.circular(Dimensions.radius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.totalPatients,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  Text(
                    totalPatients.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  color: CustomColor.accentColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.totalAppointed,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  Text(
                    totalAppointed.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Dimensions.extraLargeTextSize,
                        fontWeight: FontWeight.bold),
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
            padding: const EdgeInsets.only(left: Dimensions.marginSize),
            child: Text(
              Strings.recentlyAppointed,
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
              itemCount: recentlyAppointed.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
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
                            //Image.asset(recent.image),
                            SizedBox(
                              width: Dimensions.widthSize,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recentlyAppointed[index]['status'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.defaultTextSize,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                // Text(
                                //   recent.problem,
                                //   style: TextStyle(
                                //       color: Colors.blueAccent,
                                //       fontSize: Dimensions.smallTextSize),
                                //   textAlign: TextAlign.center,
                                // ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      recentlyAppointed[index]['time_from'] +
                                          ' to ' +
                                          recentlyAppointed[index]['time_to'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: Dimensions.smallTextSize),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      width: Dimensions.widthSize * 0.5,
                                    ),
                                    Text(
                                      recentlyAppointed[index]['date'],
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.6),
                                          fontSize: Dimensions.smallTextSize),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.heightSize * 0.5,
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // ..
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: CustomColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/message.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.widthSize * 0.5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // ..
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: CustomColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/call.png'),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.widthSize * 0.5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return VideoCallTestScreen(
                                                callId: recentlyAppointed[index]['id'],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            color: CustomColor.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                              'assets/images/video.png'),
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
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future _handleTheLogout() async {
    try {
      var response = await CallApi().getDataWithToken('/logout');
      if (response.statusCode == 200) {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.remove('user');
        localStorage.remove('token');
        localStorage.remove('model');

        LaravelEcho.instance.disconnect();

        _goToSigninScreen(context);

        showErrorDialog(
            context, 'Error in loading data, please try login again');
      } else {
        // Try to logout again
      }
    } catch (e) {
      // Show the error message
      showErrorDialog(context, 'Error in logout. please try again');
    }
  }

  _goToSigninScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) {
          return SignInScreen();
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<bool> showErrorDialog(BuildContext context, message) async {
    return (await showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) => MessageDialog(
            title: "Error",
            subTitle: message,
            action: false,
            img: 'error.png',
            buttonName: Strings.ok,
            moved: HomeScreen(),
          ),
        )) ??
        false;
  }
}
