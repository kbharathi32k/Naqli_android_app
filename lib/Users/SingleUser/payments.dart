import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Users/SingleUser/singleuser.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/pieChart/app_colors.dart';
import 'package:naqli_android_app/pieChart/indicator.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/echarts_data.dart';
import 'package:graphic/graphic.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

class SingleUserPayment extends StatefulWidget {
  final String? user;
  final String? unitType;
  SingleUserPayment({this.unitType, this.user});
  @override
  State<SingleUserPayment> createState() => _SingleUserPaymentState();
}

class _SingleUserPaymentState extends State<SingleUserPayment> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  final ScrollController _scrollController1 = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

  bool value = false;
  String month = '';
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  bool isButtonEnabled = false;
  bool isButtonEnabled1 = false;
  bool isButtonEnabled2 = false;
  int? selectedRadioValue;
  int? selectedRadioValue1;
  int? selectedRadioValue2;
  bool payNowButtonEnabled = false;
  String? selectedValue;

  Stream<List<QuerySnapshot<Map<String, dynamic>>>>? _currentStream;
  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  Stream<List<QuerySnapshot<Map<String, dynamic>>>> allBookings() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Query for vehicleBooking collection
    Stream<QuerySnapshot<Map<String, dynamic>>> vehicleStream = firestore
        .collection('user')
        .doc(widget.user)
        .collection('vehicleBooking')
        .snapshots();

    // Query for equipmentBookings collection
    Stream<QuerySnapshot<Map<String, dynamic>>> equipmentStream = firestore
        .collection('user')
        .doc(widget.user)
        .collection('equipmentBookings')
        .snapshots();

    // Merge both streams using Rx.combineLatest2
    Stream<List<QuerySnapshot<Map<String, dynamic>>>> mergedStream =
        Rx.combineLatest2(
            vehicleStream,
            equipmentStream,
            (QuerySnapshot<Map<String, dynamic>> a,
                    QuerySnapshot<Map<String, dynamic>> b) =>
                [a, b]).asBroadcastStream();

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

  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    _currentStream = allBookings();
    super.initState();
  }

  void enablePayNowButton() {
    setState(() {
      payNowButtonEnabled = true;
    });
  }

  void disablePayNowButton() {
    setState(() {
      payNowButtonEnabled = false;
    });
  }

  bool isAnyCheckboxSelected() {
    return checkbox1 || checkbox2 || checkbox3;
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
                      StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
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
                            // Flatten the list of QuerySnapshot into a single List<DocumentSnapshot>
                            List<SingleUserBooking> blueSingleUsers = [];
                            snapshot.data!.forEach((querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                blueSingleUsers
                                    .add(SingleUserBooking.fromSnapshot(doc));
                              });
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
                      StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
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
                            // Flatten the list of QuerySnapshot into a single List<DocumentSnapshot>
                            List<SingleUserBooking> blueSingleUsers = [];
                            snapshot.data!.forEach((querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                blueSingleUsers
                                    .add(SingleUserBooking.fromSnapshot(doc));
                              });
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
        'Mode',
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
        'Date',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Unit Type',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      )),
      DataColumn(
          label: Text(
        'Payment',
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
