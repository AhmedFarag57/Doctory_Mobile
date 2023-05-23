import 'dart:convert';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    _loadUserDataFromDevice();
    super.initState();
  }

  Future _loadUserDataFromDevice() async {
    try {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      user = jsonDecode(localStorage.get('user').toString());
    } catch (e) {
      // ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: 1460279720,
          appSign:
              "f20a8f018d56d319f2955b3a72fe1f4396be452043cde05c1d1ddabecde2bd67",
          callID: widget.callId.toString(),
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
            ..onOnlySelfInRoom = (context) => Navigator.pop(context),
          userID: user['id'].toString(),
          userName: user['name'].toString(),
        ),
      ),
    );
  }
}
