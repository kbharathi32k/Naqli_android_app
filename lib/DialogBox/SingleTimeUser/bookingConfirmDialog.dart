import 'package:flutter/material.dart';
import 'package:naqli_android_app/Users/SingleTimeUser/bookingDetails.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:sizer/sizer.dart';

import '../../Users/SingleUser/bookings.dart';

class BookingConfirmDialog extends StatefulWidget {
  @override
  _BookingConfirmDialogState createState() => _BookingConfirmDialogState();
}

class _BookingConfirmDialogState extends State<BookingConfirmDialog> {
  // void _handleItem1Tap() {
  //   setState(() {
  //     _currentContent = BookingDetails();
  //   });
  //   Navigator.pop(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 650) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Expanded(
              child: ElevationContainer(
                width: 1000,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        color: Color.fromRGBO(98, 106, 254, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'Booking Confirmation',
                                style: DialogText.dialogtext1,
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(right: 2),
                            icon: Icon(Icons.close),
                            onPressed: () {
                              // _handleItem1Tap();
                              Widget bookingdetails;
                              Navigator.pop(context);
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Bookings(    user: widget.user,),
                              //   ),
                              // );
                            },
                            color: Colors.white, // Setting icon color
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'BOOKING ID NAQXXXXXXXX Confirmed',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(104, 102, 124, 1),
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'With Advance Payment of SAR XXXXXX',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(104, 102, 124, 1),
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ElevationContainer(
              width: MediaQuery.of(context).size.width *
                  0.6, // Adjust width responsively

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      color: Color.fromRGBO(98, 106, 254, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'Booking Confirmation',
                              style: DialogText.dialogtext1,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.only(right: 2),
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.white, // Setting icon color
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0)),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'BOOKING ID NAQXXXXXXXX Confirmed',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(104, 102, 124, 1),
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'With Advance Payment of SAR XXXXXX',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(104, 102, 124, 1),
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      });
    });
  }
}
