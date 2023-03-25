import 'dart:convert';

import 'package:doctor/dialog/loading_dialog.dart';
import 'package:doctor/screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:doctor/data/message.dart';
import 'package:doctor/widgets/back_widget.dart';

import 'package:doctor/utils/colors.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network_utils/api.dart';

class MessagingScreen extends StatefulWidget {
  var appointment_id;
  var chat_id;
  MessagingScreen(var id, var chat_id) {
    this.appointment_id = id;
    this.chat_id = chat_id;
  }

  @override
  _MessagingScreenState createState() =>
      _MessagingScreenState(appointment_id, chat_id);
}

class _MessagingScreenState extends State<MessagingScreen> {
  var appointment_id;
  var chat_id;
  var messages;
  var user;
  var user_id;
  var response;
  var body;
  bool isLoading = false;

  _MessagingScreenState(var id, var chat_id) {
    this.appointment_id = id;
    this.chat_id = chat_id;
  }

  @override
  void initState() {
    // ...
    loadData();

    super.initState();
  }

  loadData() async {
    // ...
    setState(() => isLoading = true);

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    user = jsonDecode(localStorage.getString('user'));
    user_id = user['id'];

    /**
     * Load Messages of chat
     */
    response = await CallApi().getDataWithToken(
        '/appointments/chat/messages?appointment_id=' +
            appointment_id.toString() +
            '&page=1');

    body = jsonDecode(response.body);

    if (body['success']) {
      messages = body['data'];
    }

    setState(() => isLoading = false);
  }

  TextEditingController messageController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingPage()
      : SafeArea(
          child: Scaffold(
            backgroundColor: CustomColor.secondaryColor,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  BackWidget(
                    name: Strings.chatWithPatient,
                  ),
                  bodyWidget(context),
                  typeMessageWidget(context)
                ],
              ),
            ),
          ),
        );

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 80,
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
          //physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: Dimensions.heightSize,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: CustomColor.primaryColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/call.png'),
                  ),
                ),
                SizedBox(
                  width: Dimensions.widthSize,
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius * 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/video.png'),
                  ),
                ),
              ],
            ),
            detailsWidget(context),
          ],
        ),
      ),
    );
  }

  detailsWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize),
      child: messagingWidget(context),
    );
  }

  Widget messagingWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Expanded(
        child: ListView.builder(
          itemCount: messages.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Message message = MessageList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(
                bottom: Dimensions.heightSize,
              ),
              child: messages[index]['user_id'] != user_id
              ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimensions.marginSize,
                      left: Dimensions.marginSize,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: CustomColor.greenLightColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        )
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.marginSize,
                            right: Dimensions.marginSize,
                            top: Dimensions.heightSize,
                            bottom: Dimensions.heightSize,
                          ),
                          child: Text(
                            messages[index]['message'],
                            style: TextStyle(
                              color: CustomColor.greyColor,
                              fontSize: Dimensions.defaultTextSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: Dimensions.marginSize,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'seen message',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: Dimensions.extraSmallTextSize,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ],
              )
              : Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/profile.png',
                            height: 20,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messages[index]['user']['name'],
                            style: TextStyle(
                              color: CustomColor.redDarkColor,
                              fontSize: Dimensions.smallTextSize,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Text(
                            '5:20pm',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontSize: Dimensions.extraSmallTextSize,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.marginSize,
                      right: Dimensions.marginSize,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CustomColor.yellowLightColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.marginSize,
                            right: Dimensions.marginSize,
                            top: Dimensions.heightSize,
                            bottom: Dimensions.heightSize,
                          ),
                          child: Text(
                            messages[index]['message'],
                            style: TextStyle(
                              color: CustomColor.greyColor,
                              fontSize: Dimensions.defaultTextSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget typeMessageWidget(BuildContext context) {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Padding(
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: Dimensions.marginSize),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: CustomColor.redDarkColor,
                        size: 20,
                      ),
                      Icon(
                        Icons.image,
                        color: CustomColor.redDarkColor,
                        size: 20,
                      ),
                      Form(
                          key: formKey,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: TextFormField(
                              style: CustomStyle.textStyle,
                              controller: messageController,
                              keyboardType: TextInputType.name,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return Strings.typeSomething;
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: Strings.typeMessage,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                labelStyle: CustomStyle.textStyle,
                                filled: true,
                                fillColor: Colors.white,
                                hintStyle: CustomStyle.textStyle,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.send,
                      color: CustomColor.primaryColor,
                      size: 18,
                    ),
                    onPressed: () async {
                      // ....
                      if (formKey.currentState.validate()) {
                        // ....
                        var data = {
                          'chat_id': chat_id,
                          'message': messageController.text
                        };

                        messageController.clear();

                        response = await CallApi()
                            .postDataWithToken(data, '/chat_message');

                        body = jsonDecode(response.body);

                        if (body['success']) {
                          // ...
                          setState(() {
                            messages.insert(0, body['data']);
                          });
                        } else {
                          // else of body['success']
                          // ....
                          print('unsend');
                        }
                      } else {
                        // else of formKey.currentState.validate()
                        // ....
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
