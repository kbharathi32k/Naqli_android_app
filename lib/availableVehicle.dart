import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/bookingIDDialog.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/customTextField.dart';
import 'package:naqli_android_app/Widgets/unitsContainer.dart';
import 'package:naqli_android_app/classes/language.dart';
import 'package:naqli_android_app/classes/language_constants.dart';
import 'package:sizer/sizer.dart';
import 'Widgets/formText.dart';
import 'main.dart';

class AvailableVehicle extends StatefulWidget {
  final String? user;

  AvailableVehicle({this.user});

  @override
  State<AvailableVehicle> createState() => _AvailableVehicleState();
}

class _AvailableVehicleState extends State<AvailableVehicle> {
  String _selectedValue = '1';
  String categoryValue = '1';
  bool value = false;
  int? groupValue = 1;
  bool checkbox1 = false;
  final ScrollController _Scroll1 = ScrollController();
  final ScrollController _Scroll2 = ScrollController();
  late GlobalKey<CustomContainerState> _vechiKey1;
  late GlobalKey<CustomContainerState> _vechiKey2;
  late GlobalKey<CustomContainerState> _vechiKey3;
  late GlobalKey<CustomContainerState> _vechiKey4;
  late GlobalKey<CustomContainerState> _vechiKey5;
  late GlobalKey<CustomContainerState> _vechiKey6;
  late GlobalKey<CustomContainerState> _vechiKey7;
  int screenState = 0;
  int? selectedRadioValue;
  String loadtype = '';
  final List<String> loadList = [
    'Food Items',
    'Building materials',
    'Auto parts',
    'Tools and Equipments',
    'Others',
    'Load Type',
  ];
  final List<String> loadList1 = [
    'Food ',
    'Perfumes and Cosmetics',
    'Medicinal products',
    'Others',
    'Load Type',
  ];
  final List<String> loadList2 = [
    'Food Items',
    'Building materials',
    'Auto parts',
    'Tools and Equipments',
    'Fodder',
    'Others',
    'Container 20',
    'Container 40',
    'Load Type',
  ];
  final List<String> loadList3 = [
    'Scrap',
    'Steel',
    'Others',
    'Load Type',
  ];
  int? selectedContainerIndex;
  DateTime? _pickedDate;
  AllUsersFormController controller = AllUsersFormController();
  void initState() {
    super.initState();
    _vechiKey1 = GlobalKey<CustomContainerState>();
    _vechiKey2 = GlobalKey<CustomContainerState>();
    _vechiKey3 = GlobalKey<CustomContainerState>();
    _vechiKey4 = GlobalKey<CustomContainerState>();
    _vechiKey5 = GlobalKey<CustomContainerState>();
    _vechiKey6 = GlobalKey<CustomContainerState>();
    _vechiKey7 = GlobalKey<CustomContainerState>();
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
            'vehicleBooking') // Replace 'subcollectionName' with your subcollection name
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

  Future<String> createNewBooking(
    String truck,
    String load,
    String size,
    String date,
    String time,
    String labour,
    String adminUid,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's document
      DocumentReference userDocRef = firestore.collection('user').doc(adminUid);

      // Reference to the subcollection 'userBooking' under the user's document
      CollectionReference userBookingCollectionRef =
          userDocRef.collection('vehicleBooking');

      // Add document to subcollection and get the document reference
      DocumentReference newBookingDocRef = await userBookingCollectionRef.add({
        'truck': truck,
        'load': load,
        'size': size,
        'date': date,
        'time': time,
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
                        top: 2.h,
                        child: Column(
                          children: [
                            Text(
                              'Available Vehicle Units',
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
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img24.png?alt=media&token=d33751f1-20d4-4381-83d8-25231631e2d7',
                                                      'name': 'Short Sides',
                                                      'size': '(12m to 13.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img25.png?alt=media&token=04c48763-8b01-4c7d-9f40-647ae4c36911',
                                                      'name': 'Curtain',
                                                      'size': '(12m to 13.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img26.png?alt=media&token=45d68d3e-90d6-44bd-893c-269bdce30097',
                                                      'name': 'Refrigerator',
                                                      'size': '(12m to 13.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img28.png?alt=media&token=c13a796f-483d-4ecc-a2bf-0ea618b2f2c0',
                                                      'name': 'Flatbed',
                                                      'size': '(12m to 13.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img29.png?alt=media&token=579954e4-eba9-4046-ba85-238f3017e14c',
                                                      'name': 'High Sides',
                                                      'size': '(12m to 13.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img30.png?alt=media&token=929ce26b-d55b-44db-b521-22056af39f22',
                                                      'name': 'Freezer',
                                                      'size': '(12m to 13.5m)'
                                                    },
                                                  ],
                                                  buttonText: 'Tralia',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              1
                                                          ? controller
                                                              .selectedTypeName1
                                                              .text
                                                          : 'Select Type',
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          1;
                                                    });
                                                  },
                                                  buttonKey: _vechiKey1,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName1
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
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img5.png?alt=media&token=a1a353e3-677b-4ca7-9932-3e7db7d5bd7a',
                                                      'name': 'Sides',
                                                      'size': '(6.5m to 7m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img6.png?alt=media&token=3424bce8-e2fe-4cb6-843a-dc6fac8d72de',
                                                      'name': 'Refrigerator',
                                                      'size': '(6.5m to 7m)'
                                                    },
                                                  ],
                                                  buttonText: 'Six',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              2
                                                          ? controller
                                                              .selectedTypeName2
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _vechiKey2,
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
                                                          .selectedTypeName2
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
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img7.png?alt=media&token=90368ea4-098c-49c3-9f69-9530b2ae9ba6',
                                                      'name': 'Sides',
                                                      'size': '(7m to 7.5m)'
                                                    },
                                                  ],
                                                  buttonText: 'Lorry 7 Metres',
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          3;
                                                    });
                                                  },
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              3
                                                          ? controller
                                                              .selectedTypeName3
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _vechiKey3,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName3
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
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img10.png?alt=media&token=750a4d60-2050-4d66-b30b-1c58ff01c0e0',
                                                      'name': 'Sides',
                                                      'size': '(6m to 6.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img11.png?alt=media&token=323ef06a-2a01-456f-b36d-acb3fb1f5043',
                                                      'name': 'Closed',
                                                      'size': '(6m to 6.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img12.png?alt=media&token=8a8b6263-58be-48a1-a7ef-14902688b6ae',
                                                      'name': 'Refrigerator',
                                                      'size': '(6m to 6.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img13.png?alt=media&token=1d2275b8-88fd-4117-9576-3ef64071ca84',
                                                      'name': 'Crane 5 TON',
                                                      'size': '(6m to 6.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img14.png?alt=media&token=9f8664b8-5db9-441f-a13c-47d0c00eba2a',
                                                      'name': 'Crane 7 TON',
                                                      'size': '(6m to 6.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img15.png?alt=media&token=2cb4b9da-042c-4acd-bc72-7b5802523c56',
                                                      'name': 'Freezer',
                                                      'size': '(6m to 6.5m)'
                                                    },
                                                  ],
                                                  buttonText: 'Lorry',
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          4;
                                                    });
                                                  },
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              4
                                                          ? controller
                                                              .selectedTypeName4
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _vechiKey4,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName4
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          4;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img16.png?alt=media&token=17254826-c309-476f-ae4b-b4f4f08f483e',
                                                      'name': 'Closed',
                                                      'size': '(4m to 4.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://console.firebase.google.com/project/naqli-5825c/storage/naqli-5825c.appspot.com/files',
                                                      'name': 'Crane',
                                                      'size': '(4m to 4.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img18.png?alt=media&token=82b08eda-4637-4850-b25b-d4cf8210703e',
                                                      'name': 'Refrigerator',
                                                      'size': '(4m to 4.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img19.png?alt=media&token=8c985cfe-4588-4d67-87b4-181101c0b93c',
                                                      'name': 'Sides',
                                                      'size': '(4m to 4.5m)'
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img20.png?alt=media&token=20d9ce46-7c5e-4671-8f32-135b624c1f06',
                                                      'name': 'Freezer',
                                                      'size': '(4m to 4.5m)'
                                                    },
                                                  ],
                                                  buttonText: 'Diana',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              5
                                                          ? controller
                                                              .selectedTypeName5
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _vechiKey5,
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          5;
                                                    });
                                                  },
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName5
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          5;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img21.png?alt=media&token=823a5ea0-fee8-447f-b82a-f86731608c9c',
                                                      'name': 'Pickup',
                                                      'size': '(1m to 1.5m)'
                                                    },
                                                  ],
                                                  buttonText: 'Pick Up',
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              6
                                                          ? controller
                                                              .selectedTypeName6
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _vechiKey6,
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          6;
                                                    });
                                                  },
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName6
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          6;
                                                    });
                                                  },
                                                ),
                                                UnitsContainer(
                                                  unitNames: [
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img22.png?alt=media&token=a96d6ed8-37f1-46bd-bbba-7cdddc87aae1',
                                                      'name': 'Regular',
                                                      'size': ''
                                                    },
                                                    {
                                                      'image':
                                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img23.png?alt=media&token=1a748d02-a87a-4e8e-8243-899cc81accc7',
                                                      'name': 'Hydraulic',
                                                      'size': ''
                                                    },
                                                  ],
                                                  buttonText: 'Tow Truck',
                                                  onSelectionChanged1: (value) {
                                                    setState(() {
                                                      controller.size.text =
                                                          value;
                                                      selectedContainerIndex =
                                                          7;
                                                    });
                                                  },
                                                  selectedTypeName:
                                                      selectedContainerIndex ==
                                                              7
                                                          ? controller
                                                              .selectedTypeName7
                                                              .text
                                                          : 'Select Type',
                                                  buttonKey: _vechiKey7,
                                                  onSelectionChanged: (value) {
                                                    setState(() {
                                                      loadtype = value;
                                                      controller
                                                          .selectedTypeName7
                                                          .text = value;
                                                      selectedContainerIndex =
                                                          7;
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
                                                                  // controller:
                                                                  //     controller
                                                                  //         .size,
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
                                                                IconButton(
                                                                  icon: Icon(
                                                                      Icons
                                                                          .calendar_today,
                                                                      size: 25,
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
                                                                    // onTap: () {
                                                                    //   _showDatePicker(
                                                                    //       context);
                                                                    // },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      contentPadding:
                                                                          EdgeInsets.only(
                                                                              left: 12),
                                                                      border: InputBorder
                                                                          .none,
                                                                      hintStyle:
                                                                          AvailableText
                                                                              .helvetica,
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                      .text
                                                                      .isNotEmpty
                                                                  ? controller
                                                                      .load.text
                                                                  : 'Load Type', // Use value from the list
                                                              items:
                                                                  _getLoadItems(),
                                                              onChanged: loadtype == 'Short Sides' ||
                                                                      loadtype ==
                                                                          'Curtain' ||
                                                                      loadtype ==
                                                                          'High Sides' ||
                                                                      loadtype ==
                                                                          'Sides' ||
                                                                      loadtype ==
                                                                          'Crane' ||
                                                                      loadtype ==
                                                                          'Closed' ||
                                                                      loadtype ==
                                                                          'Refrigerator' ||
                                                                      loadtype ==
                                                                          'Freezer' ||
                                                                      loadtype ==
                                                                          'Flatbed' ||
                                                                      loadtype ==
                                                                          'Crane 5 TON' ||
                                                                      loadtype ==
                                                                          'Crane 7 TON' ||
                                                                      loadtype ==
                                                                          'Hydraulic' ||
                                                                      loadtype ==
                                                                          'Regular'
                                                                  ? (String?
                                                                      newValue) {
                                                                      setState(
                                                                          () {
                                                                        controller
                                                                            .load
                                                                            .text = newValue!; // Update value in the list
                                                                      });
                                                                    }
                                                                  : null, // Set onChanged to null to disable the dropdown
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
                                                              String time =
                                                                  controller
                                                                      .time
                                                                      .text;
                                                              String date =
                                                                  controller
                                                                      .date
                                                                      .text;
                                                              print(
                                                                  'load: $load');
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
                                                                      time,
                                                                      labour,
                                                                      widget
                                                                          .user!);
                                                              String unitType =
                                                                  'Vehicle';
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
                              'Available Vehicle Units',
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
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img24.png?alt=media&token=d33751f1-20d4-4381-83d8-25231631e2d7',
                                                'name': 'Short Sides'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img25.png?alt=media&token=04c48763-8b01-4c7d-9f40-647ae4c36911',
                                                'name': 'Curtain'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img26.png?alt=media&token=45d68d3e-90d6-44bd-893c-269bdce30097',
                                                'name': 'Refrigerator'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img28.png?alt=media&token=c13a796f-483d-4ecc-a2bf-0ea618b2f2c0',
                                                'name': 'Flatbed'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img29.png?alt=media&token=579954e4-eba9-4046-ba85-238f3017e14c',
                                                'name': 'High Sides'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img30.png?alt=media&token=929ce26b-d55b-44db-b521-22056af39f22',
                                                'name': 'Freezer'
                                              },
                                            ],
                                            buttonText: 'Tralia',
                                            selectedTypeName: controller
                                                .selectedTypeName1.text,
                                            buttonKey: _vechiKey1!,
                                          ),
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img5.png?alt=media&token=a1a353e3-677b-4ca7-9932-3e7db7d5bd7a',
                                                'name': 'Sides'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img6.png?alt=media&token=3424bce8-e2fe-4cb6-843a-dc6fac8d72de',
                                                'name': 'Refrigerator'
                                              },
                                            ],
                                            buttonText: 'Six',
                                            selectedTypeName: controller
                                                .selectedTypeName2.text,
                                            buttonKey: _vechiKey2!,
                                          ),
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img7.png?alt=media&token=90368ea4-098c-49c3-9f69-9530b2ae9ba6',
                                                'name': 'Sides'
                                              },
                                            ],
                                            buttonText: 'Lorry 7 Metres',
                                            selectedTypeName: controller
                                                .selectedTypeName3.text,
                                            buttonKey: _vechiKey3!,
                                          ),
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img10.png?alt=media&token=750a4d60-2050-4d66-b30b-1c58ff01c0e0',
                                                'name': 'Sides'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img11.png?alt=media&token=323ef06a-2a01-456f-b36d-acb3fb1f5043',
                                                'name': 'Closed'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img12.png?alt=media&token=8a8b6263-58be-48a1-a7ef-14902688b6ae',
                                                'name': 'Refrigerator'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img13.png?alt=media&token=1d2275b8-88fd-4117-9576-3ef64071ca84',
                                                'name': 'Crane 5 TON'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img14.png?alt=media&token=9f8664b8-5db9-441f-a13c-47d0c00eba2a',
                                                'name': 'Crane 7 TON'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img15.png?alt=media&token=2cb4b9da-042c-4acd-bc72-7b5802523c56',
                                                'name': 'Freezer'
                                              },
                                            ],
                                            buttonText: 'Lorry',
                                            selectedTypeName: controller
                                                .selectedTypeName4.text,
                                            buttonKey: _vechiKey4!,
                                          ),
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img16.png?alt=media&token=17254826-c309-476f-ae4b-b4f4f08f483e',
                                                'name': 'Closed'
                                              },
                                              {
                                                'image':
                                                    'https://console.firebase.google.com/project/naqli-5825c/storage/naqli-5825c.appspot.com/files',
                                                'name': 'Crane'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img18.png?alt=media&token=82b08eda-4637-4850-b25b-d4cf8210703e',
                                                'name': 'Refrigerator'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img19.png?alt=media&token=8c985cfe-4588-4d67-87b4-181101c0b93c',
                                                'name': 'Sides'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img20.png?alt=media&token=20d9ce46-7c5e-4671-8f32-135b624c1f06',
                                                'name': 'Freezer'
                                              },
                                            ],
                                            buttonText: 'Diana',
                                            selectedTypeName: controller
                                                .selectedTypeName5.text,
                                            buttonKey: _vechiKey5!,
                                          ),
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img21.png?alt=media&token=823a5ea0-fee8-447f-b82a-f86731608c9c',
                                                'name': 'Pickup'
                                              },
                                            ],
                                            buttonText: 'Pick Up',
                                            selectedTypeName: controller
                                                .selectedTypeName6.text,
                                            buttonKey: _vechiKey6!,
                                          ),
                                          UnitsContainer(
                                            unitNames: [
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img22.png?alt=media&token=a96d6ed8-37f1-46bd-bbba-7cdddc87aae1',
                                                'name': 'Regular'
                                              },
                                              {
                                                'image':
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/img23.png?alt=media&token=1a748d02-a87a-4e8e-8243-899cc81accc7',
                                                'name': 'Hydraulic'
                                              },
                                            ],
                                            buttonText: 'Tow Truck',
                                            selectedTypeName: controller
                                                .selectedTypeName7.text,
                                            buttonKey: _vechiKey7!,
                                          ),
                                          CustomTextfieldGrey(
                                            text: 'Time',
                                          ),
                                          CustomTextfieldGrey(
                                            text: 'Value of the Product',
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

  List<DropdownMenuItem<String>> _getLoadItems() {
    if (loadtype == 'Short Sides' ||
        loadtype == 'Curtain' ||
        loadtype == 'High Sides' ||
        loadtype == 'Sides' ||
        loadtype == 'Crane' ||
        loadtype == 'Closed') {
      return loadList.map((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: BookingManagerText.sfpro18black));
      }).toList();
    } else if (loadtype == 'Refrigerator' || loadtype == 'Freezer') {
      return loadList1.map((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: BookingManagerText.sfpro18black));
      }).toList();
    } else if (loadtype == 'Flatbed') {
      return loadList2.map((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: BookingManagerText.sfpro18black));
      }).toList();
    } else if (loadtype == 'Crane 5 TON' || loadtype == 'Crane 7 TON') {
      return loadList3.map((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: BookingManagerText.sfpro18black));
      }).toList();
    } else {
      return loadList3.map((String value) {
        return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: BookingManagerText.sfpro18black));
      }).toList();
    }
  }
}
