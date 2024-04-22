// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:sizer/sizer.dart';

@immutable
final class CustomTextfield extends StatelessWidget {
  Function(String)? onsaved;
  final String? text;
  final String? text1;
  final TextEditingController? controller;
  final Color? color;
  final List<Color>? colors;
  final double? dynamicHeight;
  String? Function(String?)? validator;
  final Function(String)? handleForm;

  CustomTextfield({
    this.controller,
    super.key,
    this.text1,
    this.text,
    this.colors,
    this.dynamicHeight,
    this.onsaved,
    this.color,
    this.validator,
    this.handleForm,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        style: TextStyle(height: 1),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 0.9.w),
          hintStyle: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 13,
              fontFamily: 'SegoeItalic',
              color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.5)),
          hintText: text,
          errorText: text1,
          errorStyle: TextStyle(height: 0, fontSize: 8.5),
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: color ?? Color.fromRGBO(202, 202, 202, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}

@immutable
final class CustomTextfieldGrey extends StatelessWidget {
  Function(String)? onsaved;
  final String? text;
  final String? text1;
  final TextEditingController? controller;
  final double? dynamicHeight;
  final Color? color;
  String? Function(String?)? validator;
  final Function(String)? handleForm;

  CustomTextfieldGrey(
      {this.controller,
      super.key,
      this.text1,
      this.text,
      this.dynamicHeight,
      this.onsaved,
      this.validator,
      this.handleForm,
      this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        style: TextStyle(height: 1),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 12),
          hintStyle: AvailableText.helvetica,
          hintText: text,
          errorText: text1,
          errorStyle: TextStyle(height: 0, fontSize: 8.5),
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: color ?? Color.fromRGBO(183, 183, 183, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}

final class CustomTextfield1 extends StatelessWidget {
  Function(String)? onsaved;
  final String? text;
  final String? text1;
  final TextEditingController? controller;
  final Color? color;
  final List<Color>? colors;
  final double? dynamicHeight;
  String? Function(String?)? validator;
  final Function(String)? handleForm;

  CustomTextfield1({
    this.controller,
    super.key,
    this.text1,
    this.text,
    this.colors,
    this.dynamicHeight,
    this.onsaved,
    this.color,
    this.validator,
    this.handleForm,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        style: TextStyle(height: 1),
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 0.9.w),
          hintStyle: DialogText.helvetica16sandal,
          hintText: '99999 99999',
          errorText: text1,
          errorStyle: TextStyle(height: 0, fontSize: 8.5),
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: color ?? Color.fromRGBO(202, 202, 202, 1),
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}
