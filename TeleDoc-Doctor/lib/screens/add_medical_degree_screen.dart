import 'package:flutter/material.dart';
import 'package:doctor/utils/custom_style.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'package:doctor/widgets/back_widget.dart';

class AddMedicalDegreeScreen extends StatefulWidget {
  @override
  _AddMedicalDegreeScreenState createState() => _AddMedicalDegreeScreenState();
}

class _AddMedicalDegreeScreenState extends State<AddMedicalDegreeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  List<String> typeList = ['MBBS', 'FCPS', 'CBMS'];
  String? selectedDegree;

  List<String> specialist = ['Medicine', 'Cardiology', 'FCO'];
  String? selectedSpecialist;

  int numberOfDegreeCount = 1;

  @override
  void initState() {
    super.initState();
    selectedDegree = typeList[0].toString();
    selectedSpecialist = specialist[0].toString();
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
                name: Strings.addMedicalDegree,
                active: true,
                onTap: null,
              ),
              bodyWidget(context),
              buttonWidget(context),
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
        child: inputFieldWidget(context),
      ),
    );
  }

  inputFieldWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Form(
        key: formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: numberOfDegreeCount,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  top: Dimensions.heightSize,
                  bottom: Dimensions.heightSize,
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          Strings.nameOfDegree,
                          style: CustomStyle.textStyle,
                        ),
                        index == 0
                            ? GestureDetector(
                                child: Container(
                                  height: Dimensions.buttonHeight,
                                  width: Dimensions.buttonHeight,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius),
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (numberOfDegreeCount < 3) {
                                      numberOfDegreeCount++;
                                    }
                                  });
                                },
                              )
                            : GestureDetector(
                                child: Container(
                                  height: Dimensions.buttonHeight,
                                  width: Dimensions.buttonHeight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      Dimensions.radius,
                                    ),
                                    color: Colors.red,
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    if (numberOfDegreeCount > 1) {
                                      numberOfDegreeCount--;
                                    }
                                  });
                                },
                              ),
                      ],
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5),
                    Material(
                      elevation: 10.0,
                      shadowColor: CustomColor.secondaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.marginSize * 0.5,
                            right: Dimensions.marginSize * 0.5,
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            hint: Text(
                              selectedDegree!,
                              style: CustomStyle.textStyle,
                            ), // Not necessary for Option 1
                            value: selectedDegree,
                            onChanged: (newValue) {
                              setState(() {
                                selectedDegree = newValue!;
                              });
                            },
                            items: typeList.map((value) {
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
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    Text(
                      Strings.concentrationMajorGroup,
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5),
                    Material(
                      elevation: 10.0,
                      shadowColor: CustomColor.secondaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.radius),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: Dimensions.marginSize * 0.5,
                            right: Dimensions.marginSize * 0.5,
                          ),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            hint: Text(
                              selectedSpecialist!,
                              style: CustomStyle.textStyle,
                            ), // Not necessary for Option 1
                            value: selectedSpecialist,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSpecialist = newValue!;
                              });
                            },
                            items: specialist.map((value) {
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
                    ),
                    SizedBox(height: Dimensions.heightSize),
                    Text(
                      Strings.instituteName,
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5),
                    Material(
                      elevation: 10.0,
                      shadowColor: CustomColor.secondaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      child: TextFormField(
                        style: CustomStyle.textStyle,
                        controller: nameController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return Strings.pleaseFillOutTheField;
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: Strings.name,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          labelStyle: CustomStyle.textStyle,
                          focusedBorder: CustomStyle.focusBorder,
                          enabledBorder: CustomStyle.focusErrorBorder,
                          focusedErrorBorder: CustomStyle.focusErrorBorder,
                          errorBorder: CustomStyle.focusErrorBorder,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: CustomStyle.textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  buttonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize * 2,
      right: Dimensions.marginSize * 2,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                  color: CustomColor.primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                ),
                child: Center(
                  child: Text(
                    Strings.save.toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          SizedBox(
            width: Dimensions.widthSize,
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              child: Container(
                height: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                child: Center(
                  child: Text(
                    Strings.close.toUpperCase(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
