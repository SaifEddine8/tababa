import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_colors.dart';
import 'package:tababa/constant/constant_style.dart';

class CategoryWidget extends StatelessWidget {
  final String category;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onTap;
  const CategoryWidget({super.key,required this.category,
  required this.backgroundColor,
   required this.textColor,
  required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Card(
        
        elevation: 10,
        color: backgroundColor,
        child: Center(child: Text(category,style: ConstantStyle.subtitle.copyWith(color: textColor),)),
        
      ),
    );
  }
}