import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 70.0,
);
const kCityTextStyle = TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 30.0,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'ZenLoop',
  fontSize: 40.0,
  fontWeight: FontWeight.bold,

);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',

);

const kConditionTextStyle = TextStyle(
  fontSize: 90.0,
);

const kWheatherTextStyle=TextStyle(
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w300,
  fontSize: 12.0,
);
const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide.none,
  ),
);
