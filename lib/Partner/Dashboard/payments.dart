import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Users/SingleUser/singleuser.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';

class Payments extends StatefulWidget {
  final String? user;
  final String? unitType;
  Payments({this.user, this.unitType});
  @override
  State<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  AllUsersFormController controller = AllUsersFormController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  Stream<List<Map<String, dynamic>>>? _currentStream;
  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  Stream<List<Map<String, dynamic>>> allBookings() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Query for user document to get firstName
    Stream<DocumentSnapshot<Map<String, dynamic>>> userStream =
        firestore.collection('user').doc(widget.user).snapshots();

    // Query for vehicleBooking collection
    Stream<QuerySnapshot<Map<String, dynamic>>> vehicleStream = firestore
        .collection('user')
        .doc(widget.user)
        .collection('vehicleBooking')
        .snapshots();

    // Merge both streams using Rx.combineLatest2
    Stream<List<Map<String, dynamic>>> mergedStream =
        Rx.combineLatest2(userStream, vehicleStream,
            (DocumentSnapshot<Map<String, dynamic>> userDoc,
                QuerySnapshot<Map<String, dynamic>> vehicleSnapshot) {
      List<Map<String, dynamic>> combinedData = [];
      // Extract firstName from user document
      String firstName = userDoc.data()?['firstName'] ?? '';
      // Iterate through vehicleBooking documents and extract relevant fields
      vehicleSnapshot.docs.forEach((vehicleDoc) {
        Map<String, dynamic> bookingData = {
          'firstName': firstName,
          'truck': vehicleDoc['truck'],
          'size': vehicleDoc['size'],
          'bookingid': vehicleDoc['bookingid'],
        };
        combinedData.add(bookingData);
      });
      return combinedData;
    }).asBroadcastStream();

    // Return the merged stream
    return mergedStream;
  }

  Stream<Map<String, dynamic>> fetchData(String userId) {
    // Create a StreamController to manage the stream
    StreamController<Map<String, dynamic>> controller = StreamController();

    try {
      // Perform the asynchronous operation
      String userCollection;
      if (widget.unitType == 'Vehicle') {
        userCollection = 'vehicleBooking';
      } else if (widget.unitType == 'Equipment') {
        userCollection = 'equipmentBookings';
      } else {
        throw Exception('Invalid selected type');
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection('user').doc(userId);
      CollectionReference userBookingCollectionRef =
          userDocRef.collection(userCollection);
      Map<String, dynamic>? lastUserData;
      // Listen to the collection's stream, order by timestamp, and limit to 1 document
      userBookingCollectionRef.limit(1).snapshots().listen((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc.exists) {
            // Explicitly cast doc.data() to Map<String, dynamic>
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            if (data != null) {
              String bookingid = data['bookingid'] ?? '';

              // Create a map containing truck, load, and size
              Map<String, dynamic> userData = {'bookingid': bookingid};

              // Update lastUserData with the new userData
              lastUserData = userData;
              // Emit the data to the stream
              controller.add(data);
            }
          } else {
            print('Document does not exist');
            controller.addError('Document does not exist');
          }
        });
      }, onError: (error) {
        print('Error fetching data: $error');
        controller.addError(error);
      });
    } catch (e) {
      print('Error fetching data: $e');
      controller.addError(e);
    }

    // Return the stream from the StreamController
    return controller.stream;
  }

  @override
  void initState() {
    _currentStream = allBookings();
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 850) {
          return SingleChildScrollView(
              child: Container(
            height: 100.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(75, 61, 82, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 80, top: 20),
                          child: Text('Payments',
                              style: BookingHistoryText.helvetica40),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
                  child: Column(
                    children: [
                      ElevationContainer(
                        child: Scrollbar(
                          controller: _scrollController1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController1,
                            child: Container(
                              width: 1070,
                              height:
                                  100, // Increased height to accommodate button
                              child: StreamBuilder<Map<String, dynamic>>(
                                stream: fetchData(widget.user!),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                                  } else if (snapshot.hasError) {
                                    return Text(
                                        'Error: ${snapshot.error}'); // Show an error message if there's an error
                                  } else {
                                    // If data is available, build the UI using the retrieved userData
                                    Map<String, dynamic> userData =
                                        snapshot.data ?? {};

                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Booking ID ${userData['bookingid']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'SFProText',
                                              color: Color.fromRGBO(
                                                  92, 86, 86, 1)),
                                        ),
                                        Text(
                                          'Booking Value : SAR xxxxxx',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'SFProText',
                                              color: Color.fromRGBO(
                                                  149, 143, 143, 1)),
                                        ),
                                        Text(
                                          'Paid : SAR xxxxx',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontFamily: 'SFProText',
                                              color: Color.fromRGBO(
                                                  149, 143, 143, 1)),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Balance',
                                              style: TextStyle(
                                                  fontSize: 17.0,
                                                  fontFamily: 'SFProText'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Add your button functionality here
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Color.fromRGBO(
                                                    98, 105, 254, 1),
                                                foregroundColor: Colors.white,
                                                minimumSize: Size(200, 35),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text('XXXXX SAR',
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      fontFamily: 'SFProText')),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),

                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: Color.fromRGBO(112, 112, 112, 1)
                                      .withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.only(right: 1.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 35,
                              width: 140,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  value: controller.fromDate.text.isNotEmpty
                                      ? controller.fromDate.text
                                      : 'From Date',
                                  items: [
                                    '14/6/2023',
                                    '15/6/2023',
                                    '16/6/2023',
                                    '17/6/2023',
                                    '18/6/2023',
                                    'From Date'
                                  ].map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value!,
                                      child: Text(
                                        value!,
                                        style: HomepageText.helvetica16black,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      controller.fromDate.text = newValue!;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 45,
                                    padding: EdgeInsets.only(right: 9),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(Icons.arrow_drop_down_sharp),
                                    iconSize: 25,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: null,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    elevation: 0,
                                    maxHeight: 200,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                      color: Colors.white,
                                    ),
                                    scrollPadding: EdgeInsets.all(5),
                                    scrollbarTheme: ScrollbarThemeData(
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    height: 30,
                                    padding: EdgeInsets.only(left: 9, right: 9),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 140,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  value: controller.toDate.text.isNotEmpty
                                      ? controller.toDate.text
                                      : 'To date',
                                  items: [
                                    '24/8/2023',
                                    '25/8/2023',
                                    '26/8/2023',
                                    '27/8/2023',
                                    '28/8/2023',
                                    'To date'
                                  ].map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value!,
                                      child: Text(
                                        value!,
                                        style: HomepageText.helvetica16black,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      controller.toDate.text = newValue!;
                                    });
                                  },
                                  buttonStyleData: ButtonStyleData(
                                    height: 45,
                                    padding: EdgeInsets.only(right: 9),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0)),
                                      color: Colors.white,
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(Icons.arrow_drop_down_sharp),
                                    iconSize: 25,
                                    iconEnabledColor: Colors.black,
                                    iconDisabledColor: null,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    elevation: 0,
                                    maxHeight: 200,
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(5),
                                        bottomRight: Radius.circular(5),
                                      ),
                                      color: Colors.white,
                                    ),
                                    scrollPadding: EdgeInsets.all(5),
                                    scrollbarTheme: ScrollbarThemeData(
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: MenuItemStyleData(
                                    height: 30,
                                    padding: EdgeInsets.only(left: 9, right: 9),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      StreamBuilder<List<Map<String, dynamic>>>(
                        stream: _currentStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                                child: Text("You haven't done any bookings"));
                          } else {
                            List<SingleUserBooking> blueSingleUsers = [];
                            snapshot.data!.forEach((bookingData) {
                              String truck = bookingData['truck'];
                              String size = bookingData['size'];
                              String bookingid = bookingData['bookingid'];

                              SingleUserBooking singleUserBooking =
                                  SingleUserBooking(
                                truck: truck,
                                size: size,
                                bookingid: bookingid,
                                // Add any additional fields needed for your SingleUserBooking constructor
                              );

                              blueSingleUsers.add(singleUserBooking);
                            });

                            return ElevationContainer(
                              child: Scrollbar(
                                controller: _scrollController2,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: _scrollController2,
                                  child: Container(
                                    height: 340,
                                    width: 1070,
                                    child: DataTable(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)
                                                  .withOpacity(0.3),
                                        ),
                                      ),
                                      headingRowColor: MaterialStateColor
                                          .resolveWith((states) =>
                                              Color.fromRGBO(75, 61, 82, 1)),
                                      dividerThickness: 1.0,
                                      dataRowHeight: 65,
                                      headingRowHeight: 70,
                                      columns: DataSource.getColumns(context),
                                      rows: blueSingleUsers.map((user) {
                                        return DataRow(
                                          cells: DataSource.getCells(user),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        } else {
          return SingleChildScrollView(
              child: Container(
            height: 100.h,
            width: 300.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(75, 61, 82, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 80, top: 20),
                          child: Text('Payments',
                              style: BookingHistoryText.helvetica40),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 12.h, 4.w, 2.h),
                  child: Column(
                    children: [
                      ElevationContainer(
                        child: Scrollbar(
                          controller: _scrollController1,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController1,
                            child: Container(
                              width: 1070,
                              height:
                                  100, // Increased height to accommodate button
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Booking ID  XXXXX',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'SFProText',
                                        color: Color.fromRGBO(92, 86, 86, 1)),
                                  ),
                                  Text(
                                    'Booking Value : SAR xxxxxx',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'SFProText',
                                        color:
                                            Color.fromRGBO(149, 143, 143, 1)),
                                  ),
                                  Text(
                                    'Paid : SAR xxxxx',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'SFProText',
                                        color:
                                            Color.fromRGBO(149, 143, 143, 1)),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Balance',
                                        style: TextStyle(
                                            fontSize: 17.0,
                                            fontFamily: 'SFProText'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Add your button functionality here
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Color.fromRGBO(98, 105, 254, 1),
                                          foregroundColor: Colors.white,
                                          minimumSize: Size(200, 35),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        child: Text('XXXXX SAR',
                                            style: TextStyle(
                                                fontSize: 17.0,
                                                fontFamily: 'SFProText')),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                  color: Color.fromRGBO(112, 112, 112, 1)
                                      .withOpacity(0.3),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevationContainer(
                        //width:300; // Set width to match screen width

                        child: Scrollbar(
                          controller: _scrollController2,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController2,
                            child: SizedBox(
                              width: 1070,
                              child: DataTable(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8)),
                                  border: Border.all(
                                    color: Color.fromRGBO(112, 112, 112, 1)
                                        .withOpacity(0.3),
                                  ),
                                ),
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Color.fromRGBO(75, 61, 82, 1)),
                                dividerThickness: 1.0,
                                dataRowHeight: 65,
                                headingRowHeight: 70,
                                columns: <DataColumn>[
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Mode',
                                    style: BookingHistoryText.sfpro20white,
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Booking ID',
                                    style: BookingHistoryText.sfpro20white,
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Date',
                                    style: BookingHistoryText.sfpro20white,
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Unit Type',
                                    style: BookingHistoryText.sfpro20white,
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Payment',
                                    style: BookingHistoryText.sfpro20white,
                                    textAlign: TextAlign.center,
                                  ))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text(
                                    'Payment Status',
                                    style: BookingHistoryText.sfpro20white,
                                    textAlign: TextAlign.center,
                                  ))),
                                ],
                                rows: <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      for (var item in [
                                        'Trip',
                                        '#456789231',
                                        '18.2.2022',
                                        'Box truck',
                                        'XXXX SAR',
                                        'Completed'
                                      ])
                                        DataCell(
                                          Container(
                                            height:
                                                65, // Adjust height as needed
                                            alignment: Alignment.center,
                                            child: Text(item,
                                                style: BookingHistoryText
                                                    .sfpro20black),
                                          ),
                                        ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      for (var item in [
                                        'Bus Trip',
                                        '#456789231',
                                        '13.6.2022',
                                        'Sleeper',
                                        'XXXX SAR',
                                        'Completed'
                                      ])
                                        DataCell(
                                          Container(
                                            height:
                                                65, // Adjust height as needed
                                            alignment: Alignment.center,
                                            child: Text(item,
                                                style: BookingHistoryText
                                                    .sfpro20black),
                                          ),
                                        ),
                                    ],
                                  ),
                                  DataRow(
                                    cells: <DataCell>[
                                      for (var item in [
                                        'Equipment hire',
                                        '#456789231',
                                        '12.5.2022',
                                        'Crane',
                                        'XXXX SAR',
                                        'Completed'
                                      ])
                                        DataCell(
                                          Container(
                                            height:
                                                65, // Adjust height as needed
                                            alignment: Alignment.center,
                                            child: Text(item,
                                                style: BookingHistoryText
                                                    .sfpro20black),
                                          ),
                                        ),
                                    ],
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
          ));
        }
      });
    });
  }
}

class DataSource extends DataTableSource {
  final List<SingleUserBooking> candidates;
  final BuildContext context;
  final Function(SingleUserBooking) onSelect;

  DataSource(this.candidates, {required this.context, required this.onSelect});

  @override
  DataRow? getRow(int index) {
    final e = candidates[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(e.truck?.toString() ?? 'nill')),
        DataCell(Text('#623832623')),
        DataCell(Text('14.02.2024')),
        DataCell(Text(e.load.toString())),
        DataCell(Text(e.size?.toString() ?? 'nill')),
        DataCell(Text(e.size?.toString() ?? 'nill')),
      ],
    );
  }

  static List<DataColumn> getColumns(BuildContext context) {
    return [
      DataColumn(
          label: Text(
        'Booked by',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Booking ID',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Mode',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Date',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Payment made',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Payment Status',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
    ];
  }

  static List<DataCell> getCells(SingleUserBooking user) {
    return [
      DataCell(Text(user.truck?.toString() ?? 'nill')),
      DataCell(Text(user.bookingid?.toString() ?? 'nill')),
      DataCell(Text(user.date?.toString() ?? 'nill')),
      DataCell(Text(user.load.toString())),
      DataCell(Text(user.size?.toString() ?? 'nill')),
      DataCell(Text(user.size?.toString() ?? 'nill')),
    ];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => candidates.length;

  @override
  int get selectedRowCount => 0;
}
