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

class Bookings1 extends StatefulWidget {
  final String? user;
  final String? unitType;

  Bookings1({this.user, this.unitType});
  @override
  State<Bookings1> createState() => _Bookings1State();
}

class _Bookings1State extends State<Bookings1> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  ScrollController _scrollController = ScrollController();
  Stream<List<QuerySnapshot<Map<String, dynamic>>>>? _currentStream;
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

  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    _currentStream = allBookings();
    super.initState();
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
                          child: Text('Booking History',
                              style: BookingHistoryText.helvetica40),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(1.w, 12.h, 1.w, 2.h),
                  child:
                      StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
                    stream: _currentStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                            controller: _scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              child: SizedBox(
                                width: 1150,
                                height: 350,
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
                                  headingRowColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Color.fromRGBO(75, 61, 82, 1)),
                                  dividerThickness: 1.0,
                                  dataRowHeight: 65,
                                  headingRowHeight: 70,
                                  columnSpacing: 10.0,
                                  columns: DataSource.getColumns(context),
                                  rows: DataSource.getRows(context),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
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
                          child: Text('Booking History',
                              style: BookingHistoryText.helvetica40),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 12.h, 4.w, 2.h),
                  child:
                      StreamBuilder<List<QuerySnapshot<Map<String, dynamic>>>>(
                    stream: _currentStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                          //width:300; // Set width to match screen width

                          child: Scrollbar(
                            controller: _scrollController,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              child: SizedBox(
                                width: 1040,
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
                                  headingRowColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          Color.fromRGBO(75, 61, 82, 1)),
                                  dividerThickness: 1.0,
                                  dataRowHeight: 65,
                                  headingRowHeight: 70,
                                  columnSpacing: 30.0,
                                  columns: DataSource.getColumns(context),
                                  rows: DataSource.getRows(context),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
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
      ],
    );
  }

  static List<DataColumn> getColumns(BuildContext context) {
    return [
      DataColumn(
          label: Flexible(
              child: Text(
        'Booked',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Booking No',
        softWrap: true,
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Quote price',
        softWrap: true,
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Date',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Time',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
      DataColumn(
          label: Flexible(
              child: Text(
        'Mode',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
      DataColumn(
        label: Expanded(
            child: Text(
          'Location',
          style: BookingHistoryText.sfpro20white,
          textAlign: TextAlign.center,
        )),
        numeric: true,
      ),
      DataColumn(
          label: Expanded(
              child: Text(
        'Action',
        style: BookingHistoryText.sfpro20white,
        textAlign: TextAlign.center,
      ))),
    ];
  }

  static List<DataRow> getRows(BuildContext context) {
    return [
      DataRow(cells: [
        DataCell(Text("User",
            style: TextStyle(fontSize: 17, fontFamily: 'SFProText'))),
        DataCell(
          Column(
            children: [
              SizedBox(height: 14),
              Text(
                '1345789345',
                style: TextStyle(
                  color: Color.fromRGBO(173, 28, 134, 1),
                ),
              ),
              SizedBox(
                width: 80,
                child: Divider(
                  color: Color.fromRGBO(92, 8, 92, 1),
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            width: 120, // Set the desired width
            height: 35, // Set the desired height
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black, // Set the border color here
                width: 1.0, // Set the border width here
              ),
              borderRadius: BorderRadius.circular(
                  10.0), // Set the border radius to create a circular border
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: '', // Add any hint text if needed
                border: InputBorder
                    .none, // Remove the border from the TextField itself
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            width: 60, // Adjust the width as needed
            child: Text(
              'Jun 10 2022',
              style: TextStyle(
                fontFamily: 'SFProText',
                fontSize: 17,
              ),
              maxLines: 2,
            ),
          ),
        ),
        DataCell(Text("10:30 AM",
            style: TextStyle(fontFamily: 'SFProText', fontSize: 17))),
        DataCell(Text("Box truck",
            style: TextStyle(fontFamily: 'SFProText', fontSize: 17))),
        DataCell(Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 5,
            ),
            SizedBox(width: 5),
            Text('Xxxxxxxx',
                style: TextStyle(fontFamily: 'SFProText', fontSize: 17)),
            SizedBox(width: 30),
            Image.network(
              'assets/path 1514.png',
              width: 24,
              height: 20,
            ),
            SizedBox(width: 5),
            Text('Xxxxxxxx',
                style: TextStyle(fontFamily: 'SFProText', fontSize: 17)),
          ],
        )),
        DataCell(
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add your onPressed functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromRGBO(99, 194, 109, 1), // Background color
                  minimumSize: Size(100, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the radius as needed
                  ),
                ),
                child: Text("Send",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'SFProText',
                        fontSize: 13)),
              ),
              SizedBox(width: 10),
              Image.network(
                'assets/Group 1982.png',
                width: 35,
                height: 35,
              ),
            ],
          ),
        ),
      ]),
    ];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => candidates.length;

  @override
  int get selectedRowCount => 0;
}
