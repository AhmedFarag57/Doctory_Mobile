import 'package:flutter/material.dart';
import 'package:teledoc/screens/appointment_summery_screen.dart';
import 'package:teledoc/utils/custom_style.dart';

import 'package:teledoc/utils/dimensions.dart';
import 'package:teledoc/utils/strings.dart';
import 'package:teledoc/utils/colors.dart';
import 'package:teledoc/widgets/back_widget.dart';
import 'dart:io';

class InputPatientDetailsScreen extends StatefulWidget {
  @override
  _InputPatientDetailsScreenState createState() => _InputPatientDetailsScreenState();
}

class _InputPatientDetailsScreenState extends State<InputPatientDetailsScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<String> sexList = ['Male', 'Female', 'Others'];
  String selectedSex;

  File file;
  File _image;
  bool checkedValue = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedSex = sexList[0].toString();

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
              BackWidget(name: Strings.inputPatientDetails,),
              bodyWidget(context),
              nextButtonWidget(context)
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
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            inputFieldWidget(context),
            SizedBox(height: Dimensions.heightSize,),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.marginSize
              ),
              child: Text(
                Strings.attachFile,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize,),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginSize
              ),
              child: imageUpload(context)
            ),
            SizedBox(height: Dimensions.heightSize,),
            Padding(
              padding: const EdgeInsets.only(
                  left: Dimensions.marginSize
              ),
              child: Text(
                '${Strings.nb}: ${Strings.ifYouHavePreviousMedicalHistoryFile}',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
            saveInformationWidget(context)
          ],
        ),
      ),
    );
  }

  inputFieldWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize * 2
      ),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 10.0,
                shadowColor: CustomColor.secondaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (String value){
                    if(value.isEmpty){
                      return Strings.pleaseFillOutTheField;
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: Strings.name,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 10.0,
                      shadowColor: CustomColor.secondaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      child: TextFormField(
                        style: CustomStyle.textStyle,
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        validator: (String value){
                          if(value.isEmpty){
                            return Strings.pleaseFillOutTheField;
                          }else{
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: Strings.age,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          labelStyle: CustomStyle.textStyle,
                          filled: true,
                          fillColor: Colors.white,
                          hintStyle: CustomStyle.textStyle,
                          focusedBorder: CustomStyle.focusBorder,
                          enabledBorder: CustomStyle.focusErrorBorder,
                          focusedErrorBorder: CustomStyle.focusErrorBorder,
                          errorBorder: CustomStyle.focusErrorBorder,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.widthSize,),
                  Expanded(
                    flex: 1,
                    child: Material(
                      elevation: 10.0,
                      shadowColor: CustomColor.secondaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius)),
                            border: Border.all(color: Colors.black.withOpacity(0.1))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: Dimensions.marginSize * 0.5, right: Dimensions
                              .marginSize * 0.5),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: Container(),
                            hint: Text(
                              selectedSex,
                              style: CustomStyle.textStyle,
                            ), // Not necessary for Option 1
                            value: selectedSex,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSex = newValue;
                              });
                            },
                            items: sexList.map((value) {
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
                  ),
                ],
              ),
              SizedBox(height: Dimensions.heightSize,),
              Material(
                elevation: 10.0,
                shadowColor: CustomColor.secondaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  validator: (String value){
                    if(value.isEmpty){
                      return Strings.pleaseFillOutTheField;
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: Strings.phone,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                  ),
                ),
              ),
              SizedBox(height: Dimensions.heightSize,),
              Material(
                elevation: 10.0,
                shadowColor: CustomColor.secondaryColor,
                borderRadius: BorderRadius.circular(Dimensions.radius),
                child: TextFormField(
                  style: CustomStyle.textStyle,
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  validator: (String value){
                    if(value.isEmpty){
                      return Strings.pleaseFillOutTheField;
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: Strings.address,
                    contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                    labelStyle: CustomStyle.textStyle,
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: CustomStyle.textStyle,
                    focusedBorder: CustomStyle.focusBorder,
                    enabledBorder: CustomStyle.focusErrorBorder,
                    focusedErrorBorder: CustomStyle.focusErrorBorder,
                    errorBorder: CustomStyle.focusErrorBorder,
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  imageUpload(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 120,
        width: 120,
        padding: EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: CustomColor.secondaryColor,
            border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(Dimensions.radius)
        ),
        child: _image == null ? Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/gallery.png',
                fit: BoxFit.cover,
                height: 120,
                width: 120,
              ),
            ),
            Center(
              child: Icon(
                Icons.add,
                size: 60,
                color: CustomColor.primaryColor,
              ),
            )
          ],
        ) : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(
            _image,
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        _openImageSourceOptions(context);
      },
    );
  }

  saveInformationWidget(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        Strings.savePatientInformation,
        style: CustomStyle.textStyle,
      ),
      value: checkedValue,
      onChanged: (newValue) {
        setState(() {
          checkedValue = newValue;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
    );
  }

  nextButtonWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize * 2,
      left: Dimensions.marginSize * 2,
      right: Dimensions.marginSize * 2,
      child: GestureDetector(
        child: Container(
          height: Dimensions.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: CustomColor.primaryColor,
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
          ),
          child: Center(
            child: Text(
              Strings.next.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimensions.largeTextSize,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
              AppointmentSummeryScreen()));
        },
      ),
    );
  }

  Future<void> _openImageSourceOptions(BuildContext context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(Icons.camera_alt, size: 40.0, color: Colors.blue,),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.photo, size: 40.0, color: Colors.green,),
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
