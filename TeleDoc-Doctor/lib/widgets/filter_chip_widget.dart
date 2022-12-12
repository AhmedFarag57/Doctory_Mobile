
import 'package:doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/dimensions.dart';

class FilterChipWidget extends StatefulWidget {
  final String chipName;

  FilterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
        color: CustomColor.greyColor,
        fontSize: Dimensions.defaultTextSize,
      ),
      selected: _isSelected,
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: CustomColor.secondaryColor,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
        });
      },
      selectedColor: CustomColor.primaryColor.withOpacity(0.2),
      pressElevation: 10,
    );
  }
}