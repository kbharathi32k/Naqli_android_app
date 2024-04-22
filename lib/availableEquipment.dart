// ignore_for_file: dead_code

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/bookingIDDialog.dart';
import 'package:naqli_android_app/Users/SingleTimeUser/bookingDetails.dart';
import 'package:naqli_android_app/Users/SingleUser/dashboard_page.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/customTextField.dart';
import 'package:naqli_android_app/Widgets/unitsContainer.dart';
import 'package:naqli_android_app/classes/language.dart';
import 'package:naqli_android_app/classes/language_constants.dart';
import 'package:naqli_android_app/main.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Widgets/formText.dart';
import 'package:intl/intl.dart';

class AvailableEquipment extends StatefulWidget {
  final String? user;
  AvailableEquipment({
    this.user,
  });

  @override
  State<AvailableEquipment> createState() => _AvailableEquipmentState();
}

class _AvailableEquipmentState extends State<AvailableEquipment> {
  final CalendarWeekController _controller = CalendarWeekController();
  String _selectedValue = '1';
  String categoryValue = '1';
  late String bookingID;
  bool value = false;
  bool checkbox = false;
  String loadtype = '';
  int? lab;
  int? groupValue1;
  int? groupValue = 1;
  bool checkbox1 = false;
  DateTime? _pickedDate;
  final ScrollController _Scroll1 = ScrollController();
  final ScrollController _Scroll2 = ScrollController();
  AllUsersFormController controller = AllUsersFormController();
  String dropdownValues = 'Load Type';
  late GlobalKey<CustomContainerState> _equipKey1;
  late GlobalKey<CustomContainerState> _equipKey2;
  late GlobalKey<CustomContainerState> _equipKey3;
  late GlobalKey<CustomContainerState> _equipKey4;
  String selectedTypeName1 = 'Select Type';
  String selectedTypeName2 = 'Select Type';
  String selectedTypeName3 = 'Select Type';
  String selectedTypeName4 = 'Select Type';
  int? selectedContainerIndex;
  int? selectedRadioValue;
  void initState() {
    super.initState();
    lab = selectedRadioValue;
    _equipKey1 = GlobalKey<CustomContainerState>();
    _equipKey2 = GlobalKey<CustomContainerState>();
    _equipKey3 = GlobalKey<CustomContainerState>();
    _equipKey4 = GlobalKey<CustomContainerState>();
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
            'equipmentBookings') // Replace 'subcollectionName' with your subcollection name
        .doc(
            newBookingId) // Replace 'subdocId' with the ID of the document in the subcollection
        .update({
      "bookingid": bookingID,
    });
    return bookingID;
  }

  Future<String> createNewBooking(
    String truck,
    String load,
    String size,
    String date,
    String labour,
    String adminUid,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's document
      DocumentReference userDocRef = firestore.collection('user').doc(adminUid);

      // Reference to the subcollection 'userBooking' under the user's document
      CollectionReference userBookingCollectionRef =
          userDocRef.collection('equipmentBookings');

      // Add document to subcollection and get the document reference
      DocumentReference newBookingDocRef = await userBookingCollectionRef.add({
        'truck': truck,
        'load': load,
        'size': size,
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
                        top: 3.h,
                        child: Column(
                          children: [
                            Text(
                              'Available Equipment Units',
                              style: AvailableText.helvetica30white,
                            ),
                            SizedBox(
                              height: 3.h,
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
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group4128.png?alt=media&token=059bdbcf-5284-45db-970f-dac34d34d828',
                                                      'name': 'Excavator',
                                                      'size': '-',
                                                    },
                                                  ],
                                                  buttonText: 'Excavator',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              1
                                                          ? controller
                                                              .selectedTypeName
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _equipKey1,
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          1;
                                                    });
                                                  },
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          1;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group3071.png?alt=media&token=ea1181da-3870-4070-a76d-4d7350ae36cf',
                                                      'name': 'Back hoe',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202052.png?alt=media&token=f007cbeb-0403-4f10-8656-676338385563',
                                                      'name': 'Front hoe',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group4137.png?alt=media&token=147859f3-29e9-4d74-9124-9eb050678b74',
                                                      'name': 'Skid steer',
                                                      'size': '-',
                                                    },
                                                  ],
                                                  buttonText: 'Loaders',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              2
                                                          ? controller
                                                              .selectedTypeName1
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _equipKey2,
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          2;
                                                    });
                                                  },
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName1
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          2;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202271.png?alt=media&token=a908e28e-1818-4786-a1e6-bb36943c9592',
                                                      'name': 'Crawler crane',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group4240.png?alt=media&token=c2f68053-1088-47a7-9822-290084dc7f0b',
                                                      'name': 'Mobile crane',
                                                      'size': '-',
                                                    },
                                                  ],
                                                  buttonText: 'Cranes',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              3
                                                          ? controller
                                                              .selectedTypeName2
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _equipKey3,
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          3;
                                                    });
                                                  },
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName2
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          3;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202270.png?alt=media&token=628e8fe5-1435-4441-832d-c131a00e62ac',
                                                      'name': 'Compactors',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2236.png?alt=media&token=b524badf-e101-422a-b3a2-615e95592f4e',
                                                      'name': 'Bulldozers',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group4225.png?alt=media&token=92ffcee1-5703-4602-812f-e8b8a0993b4a',
                                                      'name': 'Graders',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2148.png?alt=media&token=8e651f25-a871-4f32-881e-edb02e0c1b3b',
                                                      'name': 'Dump truck',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2181.png?alt=media&token=456cf532-6b18-4173-9665-51298359399f',
                                                      'name': 'Forklift',
                                                      'size': '-',
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group4239.png?alt=media&token=4acb7436-884b-41af-bb87-f82341a5ff1b',
                                                      'name': 'Scissorlift',
                                                      'size': '-',
                                                    },
                                                  ],
                                                  buttonText: 'Others',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              4
                                                          ? controller
                                                              .selectedTypeName3
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _equipKey4,
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          4;
                                                    });
                                                  },
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName3
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          4;
                                                    });
                                                  },
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
                                                                  controller:
                                                                      controller
                                                                          .time,
                                                                  text: 'Time',
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
                                                                  controller:
                                                                      controller
                                                                          .size,
                                                                  text:
                                                                      'Value of the Product',
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
                                                    // Variable to store the selected radio button value

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
                                                                  : null, // Set groupValue to the selectedRadioValue variable
                                                              onChanged:
                                                                  checkbox1
                                                                      ? (int?
                                                                          value) {
                                                                          setState(
                                                                              () {
                                                                            selectedRadioValue =
                                                                                value; // Update the selectedRadioValue when radio button is changed
                                                                          });
                                                                        }
                                                                      : null,
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
                                                          ImageIcon(
                                                            NetworkImage(
                                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Icon.png?alt=media&token=ed97c54c-b649-4e28-a502-fb2845284983'),
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            ' Enter city name',
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
                                                        children: [
                                                          ImageIcon(
                                                            NetworkImage(
                                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group15765.png?alt=media&token=c8fdcdd5-bbd4-4043-beba-236feaf6d695'),
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'Enter your address',
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
                                                              ImageIcon(
                                                                NetworkImage(
                                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group15788.png?alt=media&token=7c513994-0221-4bed-aaf0-d24e39b20d1f'),
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                ' Zip code for construction site',
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
                                                            try {
                                                              String truck = '';
                                                              if (controller
                                                                  .selectedTypeName1
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName1
                                                                    .text;
                                                              } else if (controller
                                                                  .selectedTypeName2
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName2
                                                                    .text;
                                                              } else if (controller
                                                                  .selectedTypeName3
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName3
                                                                    .text;
                                                              } else if (controller
                                                                  .selectedTypeName4
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName4
                                                                    .text;
                                                              } else if (controller
                                                                  .selectedTypeName5
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName5
                                                                    .text;
                                                              } else if (controller
                                                                  .selectedTypeName6
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName6
                                                                    .text;
                                                              } else if (controller
                                                                  .selectedTypeName7
                                                                  .text
                                                                  .isNotEmpty) {
                                                                truck = controller
                                                                    .selectedTypeName7
                                                                    .text;
                                                              }
                                                              String truck1 =
                                                                  truck;
                                                              String size =
                                                                  controller
                                                                      .size
                                                                      .text;
                                                              String load =
                                                                  controller
                                                                      .load
                                                                      .text;
                                                              String date =
                                                                  controller
                                                                      .date
                                                                      .text;
                                                              String labour =
                                                                  selectedRadioValue
                                                                      .toString();
                                                              String
                                                                  newBookingId =
                                                                  await createNewBooking(
                                                                      truck,
                                                                      load,
                                                                      size,
                                                                      date,
                                                                      labour,
                                                                      widget
                                                                          .user!);
                                                              String unitType =
                                                                  'Equipment';
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
                                                                context:
                                                                    context,
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
                                                            } catch (e) {
                                                              print(
                                                                  "Error creating user: $e");
                                                            }
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
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(90),
                child: Material(
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
                              height: 20,
                              child: VerticalDivider(
                                thickness: 2,
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
                        Row(
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Color.fromRGBO(106, 102, 209, 1),
                            ),
                            SizedBox(
                              width: 0.1.w,
                            ),
                            Text("Contact Us ",
                                style: HomepageText.helvetica16black),
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: Colors.black,
                              ),
                            ),
                            Text("Hello Customer!",
                                style: HomepageText.helvetica16black),
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
                        top: 3.h,
                        child: Column(
                          children: [
                            Text(
                              'Available Units',
                              style: AvailableText.helvetica30white,
                            ),
                            SizedBox(
                              height: 3.h,
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
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202181.png?alt=media&token=d1037eba-4e97-4688-be85-b76c1774baef',
                                                      'name': 'Dump truck'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202270.png?alt=media&token=628e8fe5-1435-4441-832d-c131a00e62ac',
                                                      'name': 'Forklift'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202271.png?alt=media&token=a908e28e-1818-4786-a1e6-bb36943c9592',
                                                      'name': 'Scissorlift'
                                                    },
                                                  ],
                                                  buttonText: 'Excavator',
                                                  selectedTypeName: controller
                                                          .selectedTypeName1
                                                          .text
                                                          .isNotEmpty
                                                      ? controller
                                                          .selectedTypeName1
                                                          .text
                                                      : 'Select Type',
                                                  buttonKey: _equipKey1,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      controller
                                                          .selectedTypeName1
                                                          .text = value;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2181.png?alt=media&token=456cf532-6b18-4173-9665-51298359399f',
                                                      'name': 'Dump truck'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2270.png?alt=media&token=98262fea-5430-4e39-852d-7c05d3cdbe1c',
                                                      'name': 'Forklift'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2271.png?alt=media&token=d76e90fe-7136-4a44-8cba-ae930c1ec451',
                                                      'name': 'Scissorlift'
                                                    },
                                                  ],
                                                  buttonText: 'Loaders',
                                                  selectedTypeName: controller
                                                          .selectedTypeName2
                                                          .text
                                                          .isNotEmpty
                                                      ? controller
                                                          .selectedTypeName2
                                                          .text
                                                      : 'Select Type',
                                                  buttonKey: _equipKey2,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      controller
                                                          .selectedTypeName2
                                                          .text = value;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2181.png?alt=media&token=456cf532-6b18-4173-9665-51298359399f',
                                                      'name': 'Dump truck'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2270.png?alt=media&token=98262fea-5430-4e39-852d-7c05d3cdbe1c',
                                                      'name': 'Forklift'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group%202271.png?alt=media&token=a908e28e-1818-4786-a1e6-bb36943c9592',
                                                      'name': 'Scissorlift'
                                                    },
                                                  ],
                                                  buttonText: 'Cranes',
                                                  selectedTypeName: controller
                                                          .selectedTypeName3
                                                          .text
                                                          .isNotEmpty
                                                      ? controller
                                                          .selectedTypeName2
                                                          .text
                                                      : 'Select Type',
                                                  buttonKey: _equipKey3,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      controller
                                                          .selectedTypeName3
                                                          .text = value;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2181.png?alt=media&token=456cf532-6b18-4173-9665-51298359399f',
                                                      'name': 'Dump truck'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2270.png?alt=media&token=98262fea-5430-4e39-852d-7c05d3cdbe1c',
                                                      'name': 'Forklift'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group2271.png?alt=media&token=d76e90fe-7136-4a44-8cba-ae930c1ec451',
                                                      'name': 'Scissorlift'
                                                    },
                                                  ],
                                                  buttonText: 'Others',
                                                  selectedTypeName: controller
                                                          .selectedTypeName4
                                                          .text
                                                          .isNotEmpty
                                                      ? controller
                                                          .selectedTypeName4
                                                          .text
                                                      : 'Select Type',
                                                  buttonKey: _equipKey4,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      controller
                                                          .selectedTypeName4
                                                          .text = value;
                                                    });
                                                  },
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
                                                                  controller:
                                                                      controller
                                                                          .size,
                                                                  text:
                                                                      'Value of the Product',
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
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0.5.w,
                                                                    0, 1.w, 0),
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
                                                              color:
                                                                  Colors.white,
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
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .calendar_today,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            183,
                                                                            183,
                                                                            183,
                                                                            1)),
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
                                                                )
                                                              ],
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
                                                                  .text, // Use value from the list
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
                                                                  dropdownValues =
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
                                                                  ? groupValue
                                                                  : null, // Enable/disable based on checkbox state
                                                              onChanged: checkbox1
                                                                  ? (int? value) {
                                                                      setState(
                                                                          () {
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
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 47,
                                                  child: CustomButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        barrierColor:
                                                            Color.fromRGBO(59,
                                                                    57, 57, 1)
                                                                .withOpacity(
                                                                    0.5),
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
        }
      });
    });
  }
}
