import 'package:flutter/material.dart';
import 'package:tokomobil/static_data.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInputMultiLine extends StatelessWidget {
  final String title;
  final Widget icon;
  final TextEditingController controller;
  final bool obsecure;
  final bool autofocus;
  final TextInputType type;
  final Function validator;

  const MyInputMultiLine(
      {this.title,
      this.icon,
      this.controller,
      this.obsecure = false,
      this.type = TextInputType.multiline,
      this.validator,
      this.autofocus = false});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: TextFormField(
          maxLines: 5,
          autofocus: autofocus,
          keyboardType: type,
          obscureText: obsecure,
          controller: controller,
          validator: validator,
          style: TextStyle(color: StaticData.inputColor, fontSize: 14.ssp),
          decoration: InputDecoration(
            labelText: "$title",
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            hintText: "$title",
            suffixIcon: icon,
          ),
        ),
      ),
    );
  }
}
