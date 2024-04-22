import 'package:flutter/material.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/formText.dart';

class BookingSuccessDialog extends StatefulWidget {
  final String? bookingId;
  BookingSuccessDialog({this.bookingId});
  @override
  _BookingSuccessDialogState createState() => _BookingSuccessDialogState();
}

class _BookingSuccessDialogState extends State<BookingSuccessDialog> {
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
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                      color: Color.fromRGBO(98, 106, 254, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text('Booking XXXXXX',
                                    style: DialogText.helvetica21)),
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
                  Center(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text('Payment Successful !',
                            textAlign: TextAlign.center,
                            style: DialogText.helvetica40),
                      ),
                    ),
                  ),
                ],
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
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Booking XXXXXX',
                                  style: DialogText.helvetica21),
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
                  Center(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text('Payment Successful !',
                            textAlign: TextAlign.center,
                            style: DialogText.helvetica40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      });
    });
  }
}
