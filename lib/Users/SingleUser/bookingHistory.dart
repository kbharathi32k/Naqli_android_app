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

class BookingHistroy extends StatefulWidget {
  final String? user;

  BookingHistroy({
    this.user,
  });
  @override
  State<BookingHistroy> createState() => _BookingHistroyState();
}

class _BookingHistroyState extends State<BookingHistroy> {
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
                          child: Scrollbar(
                            controller: _scrollController,
                            thumbVisibility: true,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              controller: _scrollController,
                              child: SizedBox(
                                width: 1070,
                                height: 340,
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
                                  headingRowColor:
                                      MaterialStateColor.resolveWith((states) =>
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
    ];
  }

  static List<DataCell> getCells(SingleUserBooking user) {
    return [
      DataCell(Text(user.truck?.toString() ?? 'nill')),
      DataCell(Text(user.bookingid?.toString() ?? 'nill')),
      DataCell(Text(user.date?.toString() ?? 'nill')),
      DataCell(Text(user.load.toString())),
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
