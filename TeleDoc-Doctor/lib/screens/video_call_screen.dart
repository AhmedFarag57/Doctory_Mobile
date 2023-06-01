import 'dart:convert';
import 'dart:ui';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/laravel_echo/laravel_echo.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/widgets/back_widget.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallTestScreen extends StatefulWidget {
  final callId;
  const VideoCallTestScreen({super.key, this.callId});

  @override
  State<VideoCallTestScreen> createState() => _VideoCallTestScreenState();
}

class _VideoCallTestScreenState extends State<VideoCallTestScreen> {
  var user;

  bool _isLoading = true;
  bool _isLoaded = false;
  bool _isBlurred = true;

  @override
  void initState() {
    _loadUserDataFromDevice();
    _listenVideoChannel();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _listenVideoChannel() {
    LaravelEcho.instance.private('video.${widget.callId}').listen('.video.blur',
        (e) {
      print(e);
      if (e is PusherEvent) {
        if (e.data != null) {
          _handleNewEvent(jsonDecode(e.data!));
        }
      }
    }).error((err) {
      // ...
    });
  }

  void _handleNewEvent(var data) {
    setState(() {
      _isBlurred = data['blurred'];
    });
  }

  void _leaveVideoChannel() {
    try {
      LaravelEcho.instance.leave('video.${widget.callId}');
    } catch (err) {
      print(err);
    }
  }

  Future _loadUserDataFromDevice() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      user = jsonDecode(localStorage.getString('user')!);
      setState(() {
        _isLoaded = true;
      });
    } catch (e) {
      // ...
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
              BackWidget(
                name: Strings.videoWithDoctor,
                active: true,
                onTap: () {
                  _leaveVideoChannel();
                },
              ),
              bodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    if (_isLoading) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 80,
          left: Dimensions.marginSize,
          right: Dimensions.marginSize,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 2),
              topRight: Radius.circular(Dimensions.radius * 2),
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          ),
        ),
      );
    } else {
      if (_isLoaded) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 80,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 2),
                topRight: Radius.circular(Dimensions.radius * 2),
              ),
            ),
            child: Stack(
              children: [
                _buildVideoCallWidget(),
                _isBlurred ? _buildBlurOverlay() : SizedBox()
              ],
            ),
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(
            top: 80,
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 2),
                topRight: Radius.circular(Dimensions.radius * 2),
              ),
            ),
            child: _buildErrorInLoadWidget(),
          ),
        );
      }
    }
  }

  Widget _buildVideoCallWidget() {
    return ZegoUIKitPrebuiltCall(
      appID: 678472265,
      appSign:
          "d4db5a2435abf583fae61036965aa2b9fe7b060ea065017cbd4d940a5d8fb28d",
      callID: widget.callId.toString(),
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.pop(context),
      userID: user['id'].toString(),
      userName: user['name'].toString(),
    );
  }

  Widget _buildErrorInLoadWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/images/error.png',
            height: 80,
            width: 80,
          ),
          Text(
            'Error in setup the video call',
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: CustomColor.primaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'You can try again by click the button below and join again.',
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: CustomColor.primaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            child: Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.radius),
                ),
              ),
              child: Center(
                child: Text(
                  'back'.toUpperCase(),
                  style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBlurOverlay() {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 25,
          sigmaY: 25,
        ),
        child: Container(),
      ),
    );
  }
}
