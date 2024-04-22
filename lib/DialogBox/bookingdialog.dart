import 'package:flutter/material.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/DialogBox/bookingSuccessful.dart';
import 'package:sizer/sizer.dart';

class BookingDialog extends StatefulWidget {
  const BookingDialog();

  @override
  _BookingDialogState createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(50.w, 2.h, 3.w, 2.h),
      child: Dialog(
        child: Material(
          child: SingleChildScrollView(
            child: Container(
              height: 370,
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      color: Color.fromRGBO(98, 105, 254, 1),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Booking XXXXXX',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10.w, 2.h, 10.w, 2.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: FormTextStyle.poppins10,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    'Phone Number',
                                    style: FormTextStyle.poppins10,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    'Booking ID',
                                    style: FormTextStyle.poppins10,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "Mode",
                                    style: FormTextStyle.poppins10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Jackson Maine",
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "+8424599721",
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    '#2343543',
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "XXXX",
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'From',
                                    style: FormTextStyle.poppins10,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "To",
                                    style: FormTextStyle.poppins10,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    'Extra Labour',
                                    style: FormTextStyle.poppins10,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "To",
                                    style: FormTextStyle.poppins10,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'XXXX',
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "XXXX",
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    'XXXX',
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                  SizedBox(height: 25),
                                  Text(
                                    "XXXX",
                                    style: FormTextStyle.poppinsblack,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BookingSuccessful();
                                    },
                                  );
                                },
                                text: 'Pay Advance: XXXX',
                              ),
                              SizedBox(width: 20),
                              CustomButton(
                                onPressed: () {},
                                text: 'Pay: XXXX',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
