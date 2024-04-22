import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'formText.dart';

@immutable
final class CustomButton extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  CustomButton({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Color.fromRGBO(98, 105, 254, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: const Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3)),
            borderRadius:
                BorderRadius.circular(20), // Adjust border radius as needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: Text(text!, style: DialogText.helvetica20),
        ),
      ),
    );
  }
}

final class CustomButton1 extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  CustomButton1({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: 164,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Color.fromRGBO(98, 105, 254, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: const Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3)),
            borderRadius:
                BorderRadius.circular(30), // Adjust border radius as needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: Text(text!, style: DialogText.helvetica20),
        ),
      ),
    );
  }
}

final class CustomButton2 extends StatelessWidget {
  final String? text1;
  final String? text2;
  Widget? child;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  CustomButton2({
    super.key,
    this.text1,
    this.text2,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: Color.fromRGBO(98, 105, 254, 1),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: const Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3)),
            borderRadius:
                BorderRadius.circular(25), // Adjust border radius as needed
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text1!, style: BookingText.helveticawhite),
            Text(text2!, style: BookingText.helveticawhitebold),
          ],
        ),
      ),
    );
  }
}

@immutable
final class CustomButton3 extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final Color? color;
  final double? dynamicHeight;
  CustomButton3({
    super.key,
    this.text,
    this.onPressed,
    this.color,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 2,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                color: const Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3)),
            borderRadius:
                BorderRadius.circular(28), // Adjust border radius as needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
          child: Text(text!, style: DialogText.helvetica20),
        ),
      ),
    );
  }
}

final class ViewButton extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final Color? colors;
  final double? dynamicHeight;
  ViewButton({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: colors,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: .5, color: const Color.fromRGBO(112, 112, 112, 1)),
            borderRadius:
                BorderRadius.circular(5.5), // Adjust border radius as needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: Text(
            text!,
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: Color.fromRGBO(98, 105, 254, 1),
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

final class EditButton extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final Color? colors;
  final double? dynamicHeight;
  EditButton({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 1,
          backgroundColor: colors,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: .5, color: const Color.fromRGBO(112, 112, 112, 1)),
            borderRadius:
                BorderRadius.circular(5.5), // Adjust border radius as needed
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
          child: Text(
            text!,
            style: TextStyle(
              fontFamily: 'Helvetica',
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

final class GradientButton extends StatelessWidget {
  final String? text;
  Widget? child;
  final Function()? onPressed;

  final List<Color>? colors;
  final double? dynamicHeight;
  GradientButton({
    super.key,
    this.text,
    this.onPressed,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(96, 105, 255, 1),
                Color.fromRGBO(123, 107, 247, 1),
              ],
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
              child: Text(text!, style: LoginpageText.helvetica16white),
            ),
          ),
        ),
      ),
    );
  }
}
