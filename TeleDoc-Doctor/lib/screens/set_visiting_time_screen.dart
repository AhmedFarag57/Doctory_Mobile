import 'package:flutter/material.dart';
import 'package:doctor/utils/custom_style.dart';

import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/widgets/back_widget.dart';

class SetVisitingTimeScreen extends StatefulWidget {
  @override
  _SetVisitingTimeScreenState createState() => _SetVisitingTimeScreenState();
}

class _SetVisitingTimeScreenState extends State<SetVisitingTimeScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  List<String> dayList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  String selectedDay;

  List<String> startTimeList = ['01:00 pm', '02:00 pm', '03:00 pm', '04:00 am', '05:00 pm', '06:0'
      '0 pm'];
  String selectedStartTime;

  List<String> endTimeList = ['01:00 pm', '02:00 pm', '03:00 pm', '04:00 am', '05:00 pm', '06:0'
      '0 pm'];
  String selectedEndTime;

  int numberOfDayCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedDay = dayList[0].toString();
    selectedStartTime = startTimeList[0].toString();
    selectedEndTime = endTimeList[0].toString();

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
              BackWidget(name: Strings.setVisitingTime,),
              bodyWidget(context),
              buttonWidget(context)
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
        child: setTimeWidget(context),
      ),
    );
  }

  setTimeWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 60
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: numberOfDayCount,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.heightSize,
                bottom: Dimensions.heightSize,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: Material(
                elevation: 10.0,
                shadowColor: CustomColor.secondaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: DropdownButton(
                          //isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            selectedDay,
                            style: CustomStyle.textStyle,
                          ), // Not necessary for Option 1
                          value: selectedDay,
                          onChanged: (newValue) {
                            setState(() {
                              selectedDay = newValue;
                            });
                          },
                          items: dayList.map((value) {
                            return DropdownMenuItem(
                              child: new Text(
                                value,
                                style: CustomStyle.textStyle,
                              ),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DropdownButton(
                          //isExpanded: true,
                          underline: Container(),
                          hint: Text(
                            selectedStartTime,
                            style: CustomStyle.textStyle,
                          ), // Not necessary for Option 1
                          value: selectedStartTime,
                          onChanged: (newValue) {
                            setState(() {
                              selectedStartTime = newValue;
                            });
                          },
                          items: startTimeList.map((value) {
                            return DropdownMenuItem(
                              child: new Text(
                                value,
                                style: CustomStyle.textStyle,
                              ),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          child: Text(
                              'To'
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: DropdownButton(
                            //isExpanded: true,
                            underline: Container(),
                            hint: Text(
                              selectedEndTime,
                              style: CustomStyle.textStyle,
                            ), // Not necessary for Option 1
                            value: selectedEndTime,
                            onChanged: (newValue) {
                              setState(() {
                                selectedEndTime = newValue;
                              });
                            },
                            items: endTimeList.map((value) {
                              return DropdownMenuItem(
                                child: new Text(
                                  value,
                                  style: CustomStyle.textStyle,
                                ),
                                value: value,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      index == 0 ? Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            height: Dimensions.buttonHeight,
                            width: Dimensions.buttonHeight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius),
                                color: Colors.green
                            ),
                            child: Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if(numberOfDayCount < 3){
                                numberOfDayCount++;
                              }
                            });
                          },
                        ),
                      )
                          : Expanded(
                        flex: 1,
                            child: GestureDetector(
                        child: Container(
                            height: Dimensions.buttonHeight,
                            width: Dimensions.buttonHeight,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius),
                                color: Colors.red
                            ),
                            child: Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                        ),
                        onTap: () {
                            setState(() {
                              if(numberOfDayCount > 1){
                                numberOfDayCount--;
                              }
                            });
                        },
                      ),
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

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize * 2,
      right: Dimensions.marginSize * 2,
      child:  Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius)
                ),
                child: Center(
                  child: Text(
                    Strings.save.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(width: Dimensions.widthSize,),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(Dimensions.radius),
                    border: Border.all(color: Colors.black.withOpacity(0.7))
                ),
                child: Center(
                  child: Text(
                    Strings.close.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7)
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
