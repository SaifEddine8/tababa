import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_colors.dart';

class ConstantStyle {

  
  
  
  //titles
  static TextStyle title=TextStyle(
    fontWeight: .bold,
    fontSize: 22,
    color: ConstantColors.primary
  );
  static TextStyle subtitle=TextStyle(
    fontWeight: .bold,
    fontSize: 16,
    color: ConstantColors.primary
  );







  //button
  static TextStyle textButtonStyle=TextStyle(
    color: ConstantColors.tertiary,
    fontWeight: .bold,
    fontSize: 16
  );
  static ButtonStyle buttonStyle=ElevatedButton.styleFrom(

    backgroundColor: ConstantColors.primary,
    shape:RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12)
    )
  );

}