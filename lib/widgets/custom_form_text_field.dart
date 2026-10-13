import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;
  final IconData? preIcon;
  final Widget? sufIcon;
  final bool obScure;
  final String? Function(String?)? validator;
  const CustomFormTextField({super.key,
  required this.hint,
  required this.label,
  required this.controller,
  required this.validator,
   this.preIcon,
   this.sufIcon,
   this.obScure=false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obScure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        hintText:hint,
        labelText:label,
        prefixIcon: Icon(preIcon),
        suffixIcon: sufIcon,
        
        
      ),
    );
  }
}