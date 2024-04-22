import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

@immutable
final class ColorContainer extends StatelessWidget {
  final String? text1;
  final String? text2;
  Widget? child;

  final Color? colors;
  final double? dynamicHeight;
  ColorContainer({
    super.key,
    this.text1,
    this.text2,
    this.colors,
    this.dynamicHeight,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(216, 216, 216, 1),
              offset: Offset(0, 1),
              blurRadius: 0.1, // changes position of shadow
            ),
          ],
          color: colors,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Color.fromARGB(246, 245, 242, 242))),
      child: Padding(
        padding: EdgeInsets.fromLTRB(1.w, 0.5.h, 1.w, 0.5.h),
        child: Center(
          child: Row(
            children: [
              Text(text1!,
                  style: const TextStyle(
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                      color: Color.fromRGBO(128, 118, 118, 1))),
              SizedBox(
                width: 1.w,
              ),
              Text(
                text2!,
                style: const TextStyle(
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                    color: Color.fromRGBO(127, 106, 255, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class ElevationContainer extends StatelessWidget {
  final String? text1;
  final String? text2;
  Widget? child;
  final double? width;
  final Color? colors;
  final double? height;
  final double? bottomright;
  final double? bottomleft;
  ElevationContainer({
    super.key,
    this.text1,
    this.text2,
    this.colors,
    this.height,
    this.bottomleft,
    this.bottomright,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3),
                offset: Offset(0, 1),
                blurRadius: 20, // changes position of shadow
              ),
            ],
            color: Colors.white,
            border: Border.all(
                width: 0.4,
                color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.2)),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: child);
  }
}

@immutable
final class ElevationUnitsContainer extends StatelessWidget {
  final String? text1;
  final String? imgpath;
  ElevationUnitsContainer({
    super.key,
    this.text1,
    this.imgpath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.6),
      child: Container(
        width: 155,
        height: 156,
        decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                width: 150,
                height: 100,
                image: NetworkImage(imgpath!),
              ),
              Divider(
                color: Color.fromRGBO(112, 112, 112, 1),
              ),
              SizedBox(height: 2),
              Text(
                text1!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 14,
                    fontFamily: 'SFProText',
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class ElevationUnitContainer extends StatelessWidget {
  final String? text1;
  final String? imgpath;
  ElevationUnitContainer({
    super.key,
    this.text1,
    this.imgpath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.6),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                width: 160,
                height: 80,
                image: NetworkImage(imgpath!),
              ),
              SizedBox(width: 75),
              Text(
                text1!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 18,
                    fontFamily: "Helvetica",
                    color: Color.fromRGBO(0, 0, 0, 1)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
