import 'package:flutter/material.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/customRadio.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/DialogBox/bookingdialog.dart';
import 'package:sizer/sizer.dart';

class TriggerBooking extends StatefulWidget {
  TriggerBooking();
  @override
  State<TriggerBooking> createState() => _TriggerBookingState();
}

class _TriggerBookingState extends State<TriggerBooking> {
  bool value = false;
  bool isButtonEnabled = false;
  bool isButtonEnabled1 = false;
  bool isButtonEnabled2 = false;
  int? selectedRadioValue;
  int? selectedRadioValue1;
  int? selectedRadioValue2;
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  final ScrollController _scrollController = ScrollController();
  final ScrollController _Scroll = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 950) {
          return SingleChildScrollView(
              child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            padding: EdgeInsets.fromLTRB(3.w, 5.h, 3.w, 3.h),
            child: Column(
              children: [
                Scrollbar(
                  controller: _Scroll,
                  thumbVisibility:
                      true, // Set to true to always show the scrollbar
                  child: SingleChildScrollView(
                    controller: _Scroll,
                    scrollDirection: Axis.horizontal,
                    child: ElevationContainer(
                      width: 1100,
                      child: Column(
                        children: [
                          Container(
                            height: 55,
                            color: Color.fromRGBO(75, 61, 82, 1), // Brown color
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  1.5.w, 1.5.h, 1.5.w, 1.5.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Trigger Booking',
                                      style: TabelText.headerText),
                                  Text(
                                    "Actions",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Helvetica",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(1.w, 2.h, 1.w, 1.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          splashRadius: 1,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide()),
                                          value: checkbox1,
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              value = newValue!;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Trip 1',
                                                style: TabelText.text1),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Booking ID Xxxxxx",
                                              style: TabelText.text2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomRadio(
                                            onChanged: (val) {
                                              // setState(
                                              //     () {
                                              //   if (selectedRadioValue ==
                                              //       val) {
                                              //     // Disable button
                                              //   } else {
                                              //     selectedRadioValue =
                                              //         val as int?;
                                              //     isButtonEnabled1 =
                                              //         true; // Enable button
                                              //   }
                                              // });
                                              setState(() {
                                                selectedRadioValue =
                                                    val; // Unselect if already selected
                                                isButtonEnabled = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue,
                                            value: 1,
                                            colors: Color.fromRGBO(
                                                200, 251, 253, 1),
                                            text1: 'Vendor 3',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        CustomRadio(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue =
                                                    val; // Unselect if already selected
                                                isButtonEnabled = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue,
                                            value: 2,
                                            colors: Color.fromRGBO(
                                                224, 253, 200, 1),
                                            text1: 'Vendor 2',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        CustomRadio(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue =
                                                    val; // Unselect if already selected
                                                isButtonEnabled = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue,
                                            value: 3,
                                            colors: Color.fromRGBO(
                                                245, 253, 200, 1),
                                            text1: 'Vendor 3',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {},
                                            icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {},
                                            icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: isButtonEnabled
                                                ? () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return BookingDialog();
                                                      },
                                                    );
                                                  }
                                                : null,
                                            style: isButtonEnabled
                                                ? ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            212, 213, 248, 1),
                                                    side: BorderSide(
                                                      color: Color.fromARGB(255,
                                                              196, 196, 196)
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                : ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            212, 213, 248, 1),
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12,
                                                fontFamily: "Helvetica",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 1.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          splashRadius: 1,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide()),
                                          value: checkbox2,
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              value = newValue!;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Equipment Hire',
                                                style: TabelText.text1),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Booking ID Xxxxxx",
                                              style: TabelText.text2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomRadio(
                                            onChanged: (val) {
                                              // setState(
                                              //     () {
                                              //   if (selectedRadioValue ==
                                              //       val) {
                                              //     // Disable button
                                              //   } else {
                                              //     selectedRadioValue =
                                              //         val as int?;
                                              //     isButtonEnabled1 =
                                              //         true; // Enable button
                                              //   }
                                              // });
                                              setState(() {
                                                selectedRadioValue1 =
                                                    val; // Unselect if already selected
                                                isButtonEnabled1 = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue1,
                                            value: 1,
                                            colors: Color.fromRGBO(
                                                200, 251, 253, 1),
                                            text1: 'Vendor 3',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        CustomRadio(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue1 =
                                                    val; // Unselect if already selected
                                                isButtonEnabled1 = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue1,
                                            value: 2,
                                            colors: Color.fromRGBO(
                                                224, 253, 200, 1),
                                            text1: 'Vendor 2',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        CustomRadio(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue1 =
                                                    val; // Unselect if already selected
                                                isButtonEnabled1 = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue1,
                                            value: 3,
                                            colors: Color.fromRGBO(
                                                245, 253, 200, 1),
                                            text1: 'Vendor 3',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {},
                                            icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {},
                                            icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: isButtonEnabled1
                                                ? () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return BookingDialog();
                                                      },
                                                    );
                                                    print(
                                                        'Elevated Button Pressed!');
                                                  }
                                                : null,
                                            style: isButtonEnabled1
                                                ? ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            212, 213, 248, 1),
                                                    side: BorderSide(
                                                      color: Color.fromARGB(255,
                                                              196, 196, 196)
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                : ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            212, 213, 248, 1),
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12,
                                                fontFamily: "Helvetica",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(1.w, 1.h, 1.w, 2.h),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          splashRadius: 1,
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide()),
                                          value: checkbox3,
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              value = newValue!;
                                            });
                                          },
                                        ),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Bus Trip',
                                                style: TabelText.text1),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Booking ID Xxxxxx",
                                              style: TabelText.text2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomRadio(
                                            onChanged: (val) {
                                              // setState(
                                              //     () {
                                              //   if (selectedRadioValue ==
                                              //       val) {
                                              //     // Disable button
                                              //   } else {
                                              //     selectedRadioValue =
                                              //         val as int?;
                                              //     isButtonEnabled1 =
                                              //         true; // Enable button
                                              //   }
                                              // });
                                              setState(() {
                                                selectedRadioValue2 =
                                                    val; // Unselect if already selected
                                                isButtonEnabled2 = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue2,
                                            value: 1,
                                            colors: Color.fromRGBO(
                                                200, 251, 253, 1),
                                            text1: 'Vendor 3',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        CustomRadio(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue2 =
                                                    val; // Unselect if already selected
                                                isButtonEnabled2 = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue2,
                                            value: 2,
                                            colors: Color.fromRGBO(
                                                224, 253, 200, 1),
                                            text1: 'Vendor 2',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        CustomRadio(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue2 =
                                                    val; // Unselect if already selected
                                                isButtonEnabled2 = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue2,
                                            value: 3,
                                            colors: Color.fromRGBO(
                                                245, 253, 200, 1),
                                            text1: 'Vendor 3',
                                            textcolor1: Colors.black54,
                                            text2: "Xxxxx SAR",
                                            textcolor2: Colors.black38),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {},
                                            icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
                                        SizedBox(
                                          width: 1.w,
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: BoxConstraints(),
                                            onPressed: () {},
                                            icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SizedBox(
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: isButtonEnabled2
                                                ? () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return BookingDialog();
                                                      },
                                                    );
                                                  }
                                                : null,
                                            style: isButtonEnabled2
                                                ? ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            212, 213, 248, 1),
                                                    side: BorderSide(
                                                      color: Color.fromARGB(255,
                                                              196, 196, 196)
                                                          .withOpacity(0.1),
                                                    ),
                                                  )
                                                : ElevatedButton.styleFrom(
                                                    elevation: 2,
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            212, 213, 248, 1),
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                  ),
                                            child: Text(
                                              'Pay Now',
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 12,
                                                fontFamily: "Helvetica",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Add spacing between the brown container and the white container
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        } else {
          return SingleChildScrollView(
            child: Container(
                height: 100.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromRGBO(255, 255, 255, 0.925),
                ),
                padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
                child: Column(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(5.w, 1.5.h, 5.w, 1.5.h),
                    color: Color.fromRGBO(255, 255, 255, 157),
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Scrollbar(
                            controller: _Scroll,
                            thumbVisibility:
                                true, // Set to true to always show the scrollbar
                            child: SingleChildScrollView(
                              controller: _Scroll,
                              scrollDirection: Axis.horizontal,
                              child: ElevationContainer(
                                width: 1100,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      color: Color.fromRGBO(
                                          75, 61, 82, 1), // Brown color
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            1.5.w, 1.5.h, 1.5.w, 1.5.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Trigger Booking',
                                                style: TabelText.headerText),
                                            Text(
                                              "Actions",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: "Helvetica",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              1.w, 2.h, 1.w, 1.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    splashRadius: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side: BorderSide()),
                                                    value: checkbox1,
                                                    onChanged:
                                                        (bool? newValue) {
                                                      setState(() {
                                                        value = newValue!;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Trip 1',
                                                          style:
                                                              TabelText.text1),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        "Booking ID Xxxxxx",
                                                        style: TabelText.text2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        // setState(
                                                        //     () {
                                                        //   if (selectedRadioValue ==
                                                        //       val) {
                                                        //     // Disable button
                                                        //   } else {
                                                        //     selectedRadioValue =
                                                        //         val as int?;
                                                        //     isButtonEnabled1 =
                                                        //         true; // Enable button
                                                        //   }
                                                        // });
                                                        setState(() {
                                                          selectedRadioValue =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue,
                                                      value: 1,
                                                      colors: Color.fromRGBO(
                                                          200, 251, 253, 1),
                                                      text1: 'Vendor 3',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectedRadioValue =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue,
                                                      value: 2,
                                                      colors: Color.fromRGBO(
                                                          224, 253, 200, 1),
                                                      text1: 'Vendor 2',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectedRadioValue =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue,
                                                      value: 3,
                                                      colors: Color.fromRGBO(
                                                          245, 253, 200, 1),
                                                      text1: 'Vendor 3',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: Image.network(
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: Image.network(
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    child: ElevatedButton(
                                                      onPressed: isButtonEnabled
                                                          ? () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return BookingDialog();
                                                                },
                                                              );
                                                            }
                                                          : null,
                                                      style: isButtonEnabled
                                                          ? ElevatedButton
                                                              .styleFrom(
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          212,
                                                                          213,
                                                                          248,
                                                                          1),
                                                              side: BorderSide(
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            196,
                                                                            196,
                                                                            196)
                                                                    .withOpacity(
                                                                        0.1),
                                                              ),
                                                            )
                                                          : ElevatedButton
                                                              .styleFrom(
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          212,
                                                                          213,
                                                                          248,
                                                                          1),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                            ),
                                                      child: Text(
                                                        'Pay Now',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Helvetica",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color:
                                              Color.fromRGBO(206, 203, 203, 1),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              1.w, 1.h, 1.w, 1.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    splashRadius: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side: BorderSide()),
                                                    value: checkbox2,
                                                    onChanged:
                                                        (bool? newValue) {
                                                      setState(() {
                                                        value = newValue!;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Equipment Hire',
                                                          style:
                                                              TabelText.text1),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        "Booking ID Xxxxxx",
                                                        style: TabelText.text2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        // setState(
                                                        //     () {
                                                        //   if (selectedRadioValue ==
                                                        //       val) {
                                                        //     // Disable button
                                                        //   } else {
                                                        //     selectedRadioValue =
                                                        //         val as int?;
                                                        //     isButtonEnabled1 =
                                                        //         true; // Enable button
                                                        //   }
                                                        // });
                                                        setState(() {
                                                          selectedRadioValue1 =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled1 =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue1,
                                                      value: 1,
                                                      colors: Color.fromRGBO(
                                                          200, 251, 253, 1),
                                                      text1: 'Vendor 3',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectedRadioValue1 =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled1 =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue1,
                                                      value: 2,
                                                      colors: Color.fromRGBO(
                                                          224, 253, 200, 1),
                                                      text1: 'Vendor 2',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectedRadioValue1 =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled1 =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue1,
                                                      value: 3,
                                                      colors: Color.fromRGBO(
                                                          245, 253, 200, 1),
                                                      text1: 'Vendor 3',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: Image.network(
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: Image.network(
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          isButtonEnabled1
                                                              ? () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return BookingDialog();
                                                                    },
                                                                  );
                                                                  print(
                                                                      'Elevated Button Pressed!');
                                                                }
                                                              : null,
                                                      style: isButtonEnabled1
                                                          ? ElevatedButton
                                                              .styleFrom(
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          212,
                                                                          213,
                                                                          248,
                                                                          1),
                                                              side: BorderSide(
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            196,
                                                                            196,
                                                                            196)
                                                                    .withOpacity(
                                                                        0.1),
                                                              ),
                                                            )
                                                          : ElevatedButton
                                                              .styleFrom(
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          212,
                                                                          213,
                                                                          248,
                                                                          1),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                            ),
                                                      child: Text(
                                                        'Pay Now',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Helvetica",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color:
                                              Color.fromRGBO(206, 203, 203, 1),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              1.w, 1.h, 1.w, 2.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    splashRadius: 1,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            side: BorderSide()),
                                                    value: checkbox3,
                                                    onChanged:
                                                        (bool? newValue) {
                                                      setState(() {
                                                        value = newValue!;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text('Bus Trip',
                                                          style:
                                                              TabelText.text1),
                                                      SizedBox(
                                                        height: 3,
                                                      ),
                                                      Text(
                                                        "Booking ID Xxxxxx",
                                                        style: TabelText.text2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        // setState(
                                                        //     () {
                                                        //   if (selectedRadioValue ==
                                                        //       val) {
                                                        //     // Disable button
                                                        //   } else {
                                                        //     selectedRadioValue =
                                                        //         val as int?;
                                                        //     isButtonEnabled1 =
                                                        //         true; // Enable button
                                                        //   }
                                                        // });
                                                        setState(() {
                                                          selectedRadioValue2 =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled2 =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue2,
                                                      value: 1,
                                                      colors: Color.fromRGBO(
                                                          200, 251, 253, 1),
                                                      text1: 'Vendor 3',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectedRadioValue2 =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled2 =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue2,
                                                      value: 2,
                                                      colors: Color.fromRGBO(
                                                          224, 253, 200, 1),
                                                      text1: 'Vendor 2',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 3.w,
                                                  ),
                                                  CustomRadio(
                                                      onChanged: (val) {
                                                        setState(() {
                                                          selectedRadioValue2 =
                                                              val; // Unselect if already selected
                                                          isButtonEnabled2 =
                                                              true;
                                                        });
                                                      },
                                                      groupValue:
                                                          selectedRadioValue2,
                                                      value: 3,
                                                      colors: Color.fromRGBO(
                                                          245, 253, 200, 1),
                                                      text1: 'Vendor 3',
                                                      textcolor1:
                                                          Colors.black54,
                                                      text2: "Xxxxx SAR",
                                                      textcolor2:
                                                          Colors.black38),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: Image.network(
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
                                                  SizedBox(
                                                    width: 1.w,
                                                  ),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {},
                                                      icon: Image.network(
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
                                                  SizedBox(
                                                    width: 2.w,
                                                  ),
                                                  SizedBox(
                                                    height: 30,
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          isButtonEnabled2
                                                              ? () {
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return BookingDialog();
                                                                    },
                                                                  );
                                                                }
                                                              : null,
                                                      style: isButtonEnabled2
                                                          ? ElevatedButton
                                                              .styleFrom(
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          212,
                                                                          213,
                                                                          248,
                                                                          1),
                                                              side: BorderSide(
                                                                color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            196,
                                                                            196,
                                                                            196)
                                                                    .withOpacity(
                                                                        0.1),
                                                              ),
                                                            )
                                                          : ElevatedButton
                                                              .styleFrom(
                                                              elevation: 2,
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          212,
                                                                          213,
                                                                          248,
                                                                          1),
                                                              side: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2),
                                                              ),
                                                            ),
                                                      child: Text(
                                                        'Pay Now',
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 12,
                                                          fontFamily:
                                                              "Helvetica",
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    // Add spacing between the brown container and the white container
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ])),
          );
        }
      });
    });
  }
}
