import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

@immutable
class CustomRadio extends StatelessWidget {
  final String? text1;
  final String? text2;

  final Color? colors;
  final Color? textcolor1;
  final Color? textcolor2;
  int? value;
  int? groupValue;
  void Function(int?)? onChanged;
  CustomRadio({
    Key? key,
    this.text1,
    this.text2,
    this.value,
    this.groupValue,
    this.onChanged,
    this.textcolor1,
    this.textcolor2,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      padding: EdgeInsets.fromLTRB(0.1.w, 1.h, 0, 1.h),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(206, 205, 205, 1).withOpacity(0.5),
              offset: Offset(0, 1),
              spreadRadius: 0.5,
              blurRadius: 2, // changes position of shadow
            ),
          ],
          color: colors,
          borderRadius: BorderRadius.circular(19.0),
          border: Border.all(
              color: Color.fromRGBO(216, 216, 216, 1).withOpacity(0.5))),
      child: Row(
        children: [
          Transform.scale(
            scale: 0.7,
            child: Radio<int?>(
              splashRadius: 5,
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return Color.fromRGBO(98, 105, 254, 1);
                }
                return Color.fromRGBO(208, 205, 205, 1);
              }),
              hoverColor: Color.fromRGBO(98, 105, 254, 1).withOpacity(.8),
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
          Text(text1!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'SFProText',
                fontSize: 9,
                color: Color.fromRGBO(128, 118, 118, 1),
              )),
          SizedBox(
            width: 10,
          ),
          Text(
            text2!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SFProText',
              fontSize: 8,
              color: Color.fromRGBO(148, 142, 183, 1),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRadio1 extends StatelessWidget {
  final String? text1;
  final String? text2;

  final Color? colors;
  int? value;
  int? groupValue;
  void Function(int?)? onChanged;
  CustomRadio1({
    Key? key,
    this.text1,
    this.text2,
    this.value,
    this.groupValue,
    this.onChanged,
    this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Color.fromRGBO(206, 205, 205, 1).withOpacity(0.5),
          //     offset: Offset(0, 1),
          //     spreadRadius: 0.5,
          //     blurRadius: 2, // changes position of shadow
          //   ),
          // ],
          color: colors,
          borderRadius: BorderRadius.circular(35.0),
          border:
              Border.all(color: Color.fromRGBO(1, 0, 2, 1).withOpacity(0.2))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(1.w, 1.h, 1.5.w, 1.h),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Transform.scale(
                    scale: 0.8,
                    child: Radio<int?>(
                      splashRadius: 5,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Color.fromRGBO(98, 105, 254, 1);
                        }
                        return Color.fromRGBO(1, 0, 2, 1).withOpacity(0.2);
                      }),
                      hoverColor:
                          Color.fromRGBO(98, 105, 254, 1).withOpacity(.8),
                      value: value,
                      groupValue: groupValue,
                      onChanged: onChanged,
                    ),
                  ),
                  Text(text1!,
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: groupValue == value
                            ? Color.fromRGBO(16, 3, 3, 1)
                            // Selected color
                            : Color.fromRGBO(16, 3, 3, 1).withOpacity(0.5),
                      )),
                ],
              ),
              Text(text2!,
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: groupValue == value
                        ? Color.fromRGBO(16, 3, 3, 1)
                        : Color.fromRGBO(16, 3, 3, 1).withOpacity(0.5),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
