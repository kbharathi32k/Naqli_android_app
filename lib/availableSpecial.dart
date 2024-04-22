import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/bookingIDDialog.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/customTextField.dart';
import 'package:naqli_android_app/classes/language.dart';
import 'package:naqli_android_app/classes/language_constants.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'Widgets/formText.dart';
import 'main.dart';

class AvailableSpecial extends StatefulWidget {
  final String? user;
  AvailableSpecial({this.user});

  @override
  State<AvailableSpecial> createState() => _AvailableSpecialState();
}

class _AvailableSpecialState extends State<AvailableSpecial> {
  String categoryValue = '1';
  bool value = false;
  int? groupValue = 1;
  bool checkbox1 = false;
  final ScrollController _Scroll1 = ScrollController();
  AllUsersFormController controller = AllUsersFormController();
  int? selectedRadioValue;
  DateTime? _pickedDate;
  void initState() {
    super.initState();
  }

  Future<String> createNewBooking(
    String truck,
    String load,
    String size,
    String time,
    String date,
    String labour,
    String adminUid,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference userDocRef = firestore.collection('user').doc(adminUid);

      CollectionReference userBookingCollectionRef =
          userDocRef.collection('specialothersBookings');

      DocumentReference newBookingDocRef = await userBookingCollectionRef.add({
        'truck': truck,
        'load': load,
        'size': size,
        'time': time,
        'date': date,
        'labour': labour,
      });

      // Store the auto-generated ID
      String newBookingId = newBookingDocRef.id;

      // Update the document with the stored ID
      await newBookingDocRef.update({'id': newBookingId});

      print('New booking added successfully with ID: $newBookingId');

      // Return the generated ID
      return newBookingId;
    } catch (error) {
      print('Error creating new booking: $error');
      return ''; // Return empty string if there's an error
    }
  }

  String _generateBookingID(String newBookingId) {
    Random random = Random();

    String bookingID = '';
    for (int i = 0; i < 10; i++) {
      bookingID += random.nextInt(10).toString();
    }

    FirebaseFirestore.instance
        .collection('user')
        .doc(widget.user)
        .collection(
            'specialothersBookings') // Replace 'subcollectionName' with your subcollection name
        .doc(
            newBookingId) // Replace 'subdocId' with the ID of the document in the subcollection
        .update({
      "bookingid": bookingID,
    });
    return bookingID;
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
        controller.date.text = DateFormat('dd/MM/yyyy').format(_pickedDate!);
      });
    }
  }

  Future<Map<String, dynamic>?> fetchData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> userData = documentSnapshot.data()!;

        String address = userData['address'] ?? '';
        String firstName = userData['firstName'] ?? '';
        String lastName = userData['lastName'] ?? '';
        String bookingid = userData['bookingid'] ?? '';
        return {
          'firstName': firstName,
          'lastName': lastName,
          'address': address,
          'bookingid': bookingid
        };
      } else {
        print('Document does not exist for userId: $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching data for userId $userId: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1350) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(90),
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(13.w, 0, 15.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 6),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                // Handle the first button press
                              },
                              child: Text(
                                'User',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "HelveticaNeueRegular",
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle the third button press
                              },
                              child: Text(
                                'Partner',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "HelveticaNeueRegular",
                                  color: Color.fromRGBO(206, 203, 203, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        widget.user != null
                            ? Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                    ),
                                    child: FutureBuilder<Map<String, dynamic>?>(
                                      future: fetchData(widget
                                          .user!), // Pass the userId to fetchData method
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                          // Extract first name and last name from snapshot data
                                          String firstName =
                                              snapshot.data?['firstName'] ?? '';

                                          return Row(
                                            children: [
                                              Icon(
                                                Icons.notifications,
                                                color: Color.fromRGBO(
                                                    106, 102, 209, 1),
                                              ),
                                              SizedBox(
                                                width: 0.5.w,
                                              ),
                                              Text("Contact Us ",
                                                  style: HomepageText
                                                      .helvetica16black),
                                              SizedBox(
                                                height: 30,
                                                child: VerticalDivider(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              widget.user != null
                                                  ? Text("Hello $firstName!",
                                                      style: HomepageText
                                                          .helvetica16black)
                                                  : Text("Hello Customer!",
                                                      style: HomepageText
                                                          .helvetica16black),
                                            ],
                                          );
                                        } else {
                                          return Text(
                                              'No data available'); // Handle case when snapshot has no data
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.notifications,
                                            color: Color.fromRGBO(
                                                106, 102, 209, 1),
                                          ),
                                          SizedBox(
                                            width: 0.5.w,
                                          ),
                                          Text("Contact Us ",
                                              style: HomepageText
                                                  .helvetica16black),
                                          SizedBox(
                                            height: 30,
                                            child: VerticalDivider(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text("Hello Customer!",
                                              style: HomepageText
                                                  .helvetica16black),
                                        ],
                                      )),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1.0,
                              autoPlayAnimationDuration: Durations.extralong4,
                              height: 500,
                            ),
                            items: [
                              Image(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/truckslide.jpg?alt=media&token=69e327e8-91b3-4a55-b640-04f1673d83d9'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 450, right: 200, top: 200),
                          ),
                          SizedBox(
                            height: 150,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 19.w,
                        right: 19.w,
                        top: 2.h,
                        child: Column(
                          children: [
                            Text(
                              'Available Special/Other Units',
                              style: AvailableText.helvetica30white,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Scrollbar(
                              controller: _Scroll1,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: _Scroll1,
                                scrollDirection: Axis.vertical,
                                child: Card(
                                  elevation: 3,
                                  shadowColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(31))),
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(2.w, 6.h, 2.w, 3.h),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    height: 740,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 1.5.w, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Special / Others",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Helvetica',
                                                        fontSize: 28,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          controller
                                                                  .truck1.text =
                                                              'Fuel Track';
                                                        });
                                                      },
                                                      child:
                                                          ElevationUnitsContainer(
                                                        text1: 'Fuel Track',
                                                        imgpath:
                                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2366.png?alt=media&token=57072109-5025-47ca-b90e-ef582da899f6',
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          controller
                                                                  .truck2.text =
                                                              'Concrete Mixer';
                                                        });
                                                      },
                                                      child:
                                                          ElevationUnitsContainer(
                                                        text1: 'Concrete Mixer',
                                                        imgpath:
                                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2491.png?alt=media&token=7be13f1c-6ac4-4205-8ece-a82e6084f571',
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          controller
                                                                  .truck3.text =
                                                              'Concerte Pump Track';
                                                        });
                                                      },
                                                      child:
                                                          ElevationUnitsContainer(
                                                        text1:
                                                            'Concerte Pump Track',
                                                        imgpath:
                                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group11635.png?alt=media&token=38685789-db55-4d28-8eef-a005ef287d39',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          controller
                                                                  .truck4.text =
                                                              'Lorry Crane';
                                                        });
                                                      },
                                                      child:
                                                          ElevationUnitsContainer(
                                                        text1: 'Lorry Crane',
                                                        imgpath:
                                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2676.png?alt=media&token=158080c5-f5db-4e85-a596-4c0731927e8e',
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          controller
                                                                  .truck5.text =
                                                              'Power Generators';
                                                        });
                                                      },
                                                      child:
                                                          ElevationUnitsContainer(
                                                        text1:
                                                            'Power Generators',
                                                        imgpath:
                                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group15533.png?alt=media&token=361f469f-0466-4da7-96dc-64e8d2359a2c',
                                                      ),
                                                    ),
                                                    Container(
                                                        height: 170,
                                                        width: 170,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child:
                                                                    CustomTextfieldGrey(
                                                                  text: 'Time',
                                                                  controller:
                                                                      controller
                                                                          .time,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child:
                                                                    CustomTextfieldGrey(
                                                                  text:
                                                                      'Value of the Product',
                                                                  controller:
                                                                      controller
                                                                          .size,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0.5.w,
                                                                          0,
                                                                          1.w,
                                                                          0),
                                                              height: 50,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            183,
                                                                            183,
                                                                            183,
                                                                            1)),
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          8),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          8),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          8),
                                                                ),
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  IconButton(
                                                                    icon: Icon(
                                                                        Icons
                                                                            .calendar_today,
                                                                        size:
                                                                            25,
                                                                        color: Color.fromRGBO(
                                                                            183,
                                                                            183,
                                                                            183,
                                                                            1)),
                                                                    onPressed:
                                                                        () {
                                                                      _showDatePicker(
                                                                          context);
                                                                    },
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  VerticalDivider(
                                                                    width: 0.2,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            183,
                                                                            183,
                                                                            183,
                                                                            1),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          controller
                                                                              .date,
                                                                      style: AvailableText
                                                                          .helvetica,
                                                                      readOnly:
                                                                          true,
                                                                      onTap:
                                                                          () {
                                                                        _showDatePicker(
                                                                            context);
                                                                      },
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.only(left: 12),
                                                                        border:
                                                                            InputBorder.none,
                                                                        hintStyle:
                                                                            AvailableText.helvetica,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          ),
                                                          DropdownButtonHideUnderline(
                                                            child:
                                                                DropdownButton2<
                                                                    String>(
                                                              value: controller
                                                                      .load
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? controller
                                                                      .load.text
                                                                  : 'Load Type', // Use value from the list
                                                              items: <String>[
                                                                'Trigger Bookings',
                                                                'Booking Manager',
                                                                'Contract',
                                                                'Load Type',
                                                                'None'
                                                              ].map<
                                                                  DropdownMenuItem<
                                                                      String>>((String
                                                                  value) {
                                                                return DropdownMenuItem<
                                                                    String>(
                                                                  value: value,
                                                                  child: Text(
                                                                      value,
                                                                      style: BookingManagerText
                                                                          .sfpro18black),
                                                                );
                                                              }).toList(),
                                                              onChanged: (String?
                                                                  newValue) {
                                                                setState(() {
                                                                  controller
                                                                          .load
                                                                          .text =
                                                                      newValue!; // Update value in the list
                                                                });
                                                              },
                                                              buttonStyleData:
                                                                  ButtonStyleData(
                                                                height: 50,
                                                                width: 15.w,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 9,
                                                                        right:
                                                                            5),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color.fromRGBO(
                                                                          183,
                                                                          183,
                                                                          183,
                                                                          1)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            8),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            8),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            8),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            8),
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              iconStyleData:
                                                                  const IconStyleData(
                                                                icon: Icon(
                                                                  Icons
                                                                      .arrow_drop_down_sharp,
                                                                ),
                                                                iconSize: 25,
                                                                iconEnabledColor:
                                                                    Colors
                                                                        .black,
                                                                iconDisabledColor:
                                                                    null,
                                                              ),
                                                              dropdownStyleData:
                                                                  DropdownStyleData(
                                                                elevation: 0,
                                                                maxHeight: 200,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(3),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Color.fromRGBO(
                                                                          112,
                                                                          112,
                                                                          112,
                                                                          1)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5),
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                scrollPadding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                scrollbarTheme:
                                                                    ScrollbarThemeData(
                                                                  thickness:
                                                                      MaterialStateProperty
                                                                          .all<double>(
                                                                              6),
                                                                  thumbVisibility:
                                                                      MaterialStateProperty.all<
                                                                              bool>(
                                                                          true),
                                                                ),
                                                              ),
                                                              menuItemStyleData:
                                                                  MenuItemStyleData(
                                                                height: 30,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 9,
                                                                        right:
                                                                            5),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: checkbox1,
                                                      onChanged:
                                                          (bool? newValue) {
                                                        setState(() {
                                                          checkbox1 = newValue!;
                                                          if (!checkbox1) {
                                                            groupValue =
                                                                null; // Disable all radio buttons
                                                          }
                                                        });
                                                      },
                                                    ),
                                                    Text(
                                                      'Need Additional Labour',
                                                      style: AvailableText
                                                          .helveticablack,
                                                    ),
                                                    for (int i = 1; i <= 3; i++)
                                                      Row(
                                                        children: [
                                                          Transform.scale(
                                                            scale: 0.7,
                                                            child: Radio<int?>(
                                                              splashRadius: 5,
                                                              fillColor: MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {
                                                                if (states.contains(
                                                                    MaterialState
                                                                        .selected)) {
                                                                  return Color
                                                                      .fromRGBO(
                                                                          183,
                                                                          183,
                                                                          183,
                                                                          1);
                                                                }
                                                                return Color
                                                                    .fromRGBO(
                                                                        208,
                                                                        205,
                                                                        205,
                                                                        1);
                                                              }),
                                                              hoverColor: Color
                                                                      .fromRGBO(
                                                                          183,
                                                                          183,
                                                                          183,
                                                                          1)
                                                                  .withOpacity(
                                                                      .8),
                                                              value: i,
                                                              groupValue: checkbox1
                                                                  ? selectedRadioValue
                                                                  : null, // Enable/disable based on checkbox state
                                                              onChanged: checkbox1
                                                                  ? (int? value) {
                                                                      setState(
                                                                          () {
                                                                        selectedRadioValue =
                                                                            value;
                                                                      });
                                                                    }
                                                                  : null, // Set onChanged to null if checkbox is unchecked
                                                            ),
                                                          ),
                                                          Text(
                                                            '$i',
                                                            style: AvailableText
                                                                .helveticablack,
                                                          ),
                                                        ],
                                                      ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        VerticalDivider(
                                          color:
                                              Color.fromRGBO(183, 183, 183, 1),
                                          width: 1,
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                1.5.w, 0, 0, 0),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color.fromRGBO(
                                                              183,
                                                              183,
                                                              183,
                                                              1) // Specify the border width
                                                          ),
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(8),
                                                      )),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.circle,
                                                            color: Colors.green,
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'Pick Up',
                                                            style: AvailableText
                                                                .helvetica17grey,
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                          color: Color.fromRGBO(
                                                              183,
                                                              183,
                                                              183,
                                                              1)),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Icon(
                                                                Icons.circle,
                                                                color:
                                                                    Colors.red,
                                                                size: 20,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                'Drop Point A',
                                                                style: AvailableText
                                                                    .helvetica17grey,
                                                              ),
                                                            ],
                                                          ),
                                                          ImageIcon(
                                                            NetworkImage(
                                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/add(1).png?alt=media&token=aa9024ab-b917-4166-aaf0-abe740e28de0'),
                                                            color: Colors.black,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Color.fromRGBO(
                                                                183,
                                                                183,
                                                                183,
                                                                1) // Specify the border width
                                                            ),
                                                        color: Color.fromARGB(
                                                            69, 112, 106, 106),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        )),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                widget.user != null
                                                    ? SizedBox(
                                                        width: double.infinity,
                                                        height: 47,
                                                        child: CustomButton(
                                                          onPressed: () async {
                                                            String truck = '';
                                                            if (controller
                                                                .truck1
                                                                .text
                                                                .isNotEmpty) {
                                                              truck = controller
                                                                  .truck1.text;
                                                            } else if (controller
                                                                .truck2
                                                                .text
                                                                .isNotEmpty) {
                                                              truck = controller
                                                                  .truck2.text;
                                                            } else if (controller
                                                                .truck3
                                                                .text
                                                                .isNotEmpty) {
                                                              truck = controller
                                                                  .truck3.text;
                                                            } else if (controller
                                                                .truck4
                                                                .text
                                                                .isNotEmpty) {
                                                              truck = controller
                                                                  .truck4.text;
                                                            } else if (controller
                                                                .truck5
                                                                .text
                                                                .isNotEmpty) {
                                                              truck = controller
                                                                  .truck5.text;
                                                            }
                                                            String truck1 =
                                                                truck;
                                                            String size =
                                                                controller
                                                                    .size.text;
                                                            String time =
                                                                controller
                                                                    .time.text;
                                                            String load =
                                                                controller
                                                                    .load.text;
                                                            String date =
                                                                controller
                                                                    .date.text;
                                                            String labour =
                                                                groupValue
                                                                    .toString();
                                                            String
                                                                newBookingId =
                                                                await createNewBooking(
                                                                    truck1,
                                                                    load,
                                                                    size,
                                                                    time,
                                                                    date,
                                                                    labour,
                                                                    widget
                                                                        .user!);
                                                            String unitType =
                                                                'Special/Others';
                                                            String bookingId =
                                                                _generateBookingID(
                                                                    newBookingId);
                                                            showDialog(
                                                              barrierDismissible:
                                                                  true,
                                                              barrierColor: Color
                                                                      .fromRGBO(
                                                                          59,
                                                                          57,
                                                                          57,
                                                                          1)
                                                                  .withOpacity(
                                                                      0.5),
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return BookingIDDialog(
                                                                  user: widget
                                                                      .user,
                                                                  bookingId:
                                                                      bookingId,
                                                                  unitType:
                                                                      unitType,
                                                                );
                                                              },
                                                            );
                                                          },
                                                          text:
                                                              'Create Booking',
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: double.infinity,
                                                        height: 47,
                                                        child: CustomButton(
                                                          onPressed: () {},
                                                          text:
                                                              'Get an Estimate',
                                                        ),
                                                      ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        } else {
          return Scaffold(
              // drawer: Drawer(
              //   child: ListView(
              //       padding: EdgeInsets.only(
              //         top: 3.h,
              //       ),
              //       children: <Widget>[
              //         Container(
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(12.0),
              //           ),
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(
              //                 30.0), // Adjust the radius as needed
              //             child: Image.network(
              //               'Circleavatar.png',
              //               width: 550, // Adjust the height as needed
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //         SizedBox(
              //           height: 2.h,
              //         ),
              //         ListTile(
              //             hoverColor: Colors.indigo.shade100,
              //             title: Text(
              //               'Booking',
              //               style: TextStyle(color: Colors.black),
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 _currentContent = Bookings();
              //               });
              //               Navigator.pop(context);
              //             }),
              //         SizedBox(
              //           height: 2.h,
              //         ),
              //         ListTile(
              //             hoverColor: Colors.indigo.shade100,
              //             title: Text(
              //               'Booking History',
              //               style: TextStyle(color: Colors.black),
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 _currentContent = BookingHistroy();
              //               });
              //               Navigator.pop(context);
              //             }),
              //         SizedBox(
              //           height: 2.h,
              //         ),
              //         ListTile(
              //             hoverColor: Colors.indigo.shade100,
              //             title: Text(
              //               'Payments',
              //               style: TextStyle(color: Colors.black),
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 _currentContent = SingleUserPayment();
              //               });
              //               Navigator.pop(context);
              //             }),
              //         SizedBox(
              //           height: 2.h,
              //         ),
              //         ListTile(
              //             hoverColor: Colors.indigo.shade100,
              //             title: Text(
              //               'Report',
              //               style: TextStyle(color: Colors.black),
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 _currentContent = SingleUserPayment();
              //               });
              //               Navigator.pop(context);
              //             }),
              //         SizedBox(
              //           height: 2.h,
              //         ),
              //         ListTile(
              //             hoverColor: Colors.indigo.shade100,
              //             title: Text(
              //               'Help',
              //               style: TextStyle(color: Colors.black),
              //             ),
              //             onTap: () {
              //               setState(() {
              //                 _currentContent = Dashboard();
              //               });
              //               Navigator.pop(context);
              //             }),
              //       ]),
              // ),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: Container(
                  height: 60,
                  child: Material(
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(2.5.w, 0, 2.5.w, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                              builder: (context) => IconButton(
                                    onPressed: () {
                                      Scaffold.of(context).openDrawer();
                                    },
                                    icon: Icon(
                                      Icons.menu_rounded,
                                      color: Colors.indigo.shade900,
                                    ),
                                  )),
                          TextButton(
                            onPressed: () {
                              // Handle the first button press
                            },
                            child: Text(
                              'User',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "HelveticaNeueRegular",
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Color.fromRGBO(206, 203, 203, 1),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle the third button press
                            },
                            child: Text(
                              'Partner',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "HelveticaNeueRegular",
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1.0,
                              autoPlayAnimationDuration: Durations.extralong4,
                              height: 500,
                            ),
                            items: [
                              Image(
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/truckslide.jpg?alt=media&token=3abaaa7a-3c22-44e3-81d2-d16af7336273'),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 450, right: 200, top: 200),
                          ),
                          SizedBox(
                            height: 150,
                          ),
                        ],
                      ),
                      Positioned(
                        left: 19.w,
                        right: 19.w,
                        top: 2.h,
                        child: Column(
                          children: [
                            Text(
                              'Available Special/Other Units',
                              style: AvailableText.helvetica30white,
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Card(
                              elevation: 3,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(31))),
                              child: Expanded(
                                child: Container(
                                  height: 740,
                                  child: SingleChildScrollView(
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(
                                          4.w, 6.h, 4.w, 3.h),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(31))),
                                      height: 1150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                " Special / Others",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Helvetica',
                                                  fontSize: 28,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Card(
                                                elevation: 4,
                                                shadowColor: Color.fromRGBO(
                                                        112, 112, 112, 1)
                                                    .withOpacity(0.6),
                                                child: Container(
                                                  width: 170,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            112, 112, 112, 1),
                                                        spreadRadius: 0.1,
                                                        blurRadius: 0.1,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Image(
                                                          width: 150,
                                                          height: 100,
                                                          image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2775.png?alt=media&token=863e2800-a09a-401d-8eb1-474d30025c89'),
                                                        ),
                                                        Divider(
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Text(
                                                          '< 15 Pax',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'SFProText',
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                elevation: 4,
                                                shadowColor: Color.fromRGBO(
                                                        112, 112, 112, 1)
                                                    .withOpacity(0.6),
                                                child: Container(
                                                  width: 170,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            112, 112, 112, 1),
                                                        spreadRadius: 0.1,
                                                        blurRadius: 0.1,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Image(
                                                          width: 150,
                                                          height: 100,
                                                          image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202709.png?alt=media&token=97297395-0f33-46b5-bc0f-0a68245fca78'),
                                                        ),
                                                        Divider(
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Text(
                                                          '15 - 30 pax',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'SFProText',
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Card(
                                                elevation: 4,
                                                shadowColor: Color.fromRGBO(
                                                        112, 112, 112, 1)
                                                    .withOpacity(0.6),
                                                child: Container(
                                                  width: 170,
                                                  height: 170,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color.fromRGBO(
                                                            112, 112, 112, 1),
                                                        spreadRadius: 0.1,
                                                        blurRadius: 0.1,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Image(
                                                          width: 150,
                                                          height: 100,
                                                          image: NetworkImage(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2860.png?alt=media&token=e8d3012c-6bd4-4583-81b8-0f0ac41131a0'),
                                                        ),
                                                        Divider(
                                                          color: Color.fromRGBO(
                                                              112, 112, 112, 1),
                                                        ),
                                                        SizedBox(height: 2),
                                                        Text(
                                                          '+30 pax',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'SFProText',
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                      0, 0, 1)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  height: 170,
                                                  width: 170,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                  )),
                                            ],
                                          ),
                                          CustomTextfieldGrey(
                                            text: 'Time',
                                            controller: controller.time,
                                          ),
                                          CustomTextfieldGrey(
                                            text: 'Value of the Product',
                                            controller: controller.size,
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: checkbox1,
                                                onChanged: (bool? newValue) {
                                                  setState(() {
                                                    checkbox1 = newValue!;
                                                    if (!checkbox1) {
                                                      groupValue =
                                                          null; // Disable all radio buttons
                                                    }
                                                  });
                                                },
                                              ),
                                              Text(
                                                'Need Additional Labour',
                                                style: AvailableText
                                                    .helveticablack,
                                              ),
                                              for (int i = 1; i <= 3; i++)
                                                Row(
                                                  children: [
                                                    Transform.scale(
                                                      scale: 0.7,
                                                      child: Radio<int?>(
                                                        splashRadius: 5,
                                                        fillColor:
                                                            MaterialStateProperty
                                                                .resolveWith(
                                                                    (states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .selected)) {
                                                            return Color
                                                                .fromRGBO(
                                                                    183,
                                                                    183,
                                                                    183,
                                                                    1);
                                                          }
                                                          return Color.fromRGBO(
                                                              208, 205, 205, 1);
                                                        }),
                                                        hoverColor:
                                                            Color.fromRGBO(183,
                                                                    183, 183, 1)
                                                                .withOpacity(
                                                                    .8),
                                                        value: i,
                                                        groupValue: checkbox1
                                                            ? groupValue
                                                            : null, // Enable/disable based on checkbox state
                                                        onChanged: checkbox1
                                                            ? (int? value) {
                                                                setState(() {
                                                                  groupValue =
                                                                      value;
                                                                });
                                                              }
                                                            : null, // Set onChanged to null if checkbox is unchecked
                                                      ),
                                                    ),
                                                    Text(
                                                      '$i',
                                                      style: AvailableText
                                                          .helveticablack,
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        183,
                                                        183,
                                                        183,
                                                        1) // Specify the border width
                                                    ),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                )),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      color: Colors.green,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Pick Up',
                                                      style: AvailableText
                                                          .helvetica17grey,
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                    color: Color.fromRGBO(
                                                        183, 183, 183, 1)),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      color: Colors.red,
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Drop Point A',
                                                      style: AvailableText
                                                          .helvetica17grey,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        183,
                                                        183,
                                                        183,
                                                        1) // Specify the border width
                                                    ),
                                                color: Color.fromARGB(
                                                    69, 112, 106, 106),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                )),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 47,
                                            child: CustomButton(
                                              onPressed: () {
                                                showDialog(
                                                  barrierColor: Color.fromRGBO(
                                                          59, 57, 57, 1)
                                                      .withOpacity(0.5),
                                                  context: context,
                                                  builder: (context) {
                                                    return BookingIDDialog(
                                                      user: widget.user,
                                                    );
                                                  },
                                                );
                                              },
                                              text: 'Create Booking',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        }
      });
    });
  }
}
