import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/homePage.dart';
import 'package:naqli_android_app/Users/Enterprise/homePageEnterprise.dart';
import 'package:graphic/graphic.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/colorContainer.dart';

class Bookings extends StatefulWidget {
  final String user;
  Bookings({required this.user});
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  final ScrollController _book1Scroll = ScrollController();
  final ScrollController _book2Scroll = ScrollController();
  final ScrollController _book3Scroll = ScrollController();
  final ScrollController _scrollController = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AllUsersFormController controller = AllUsersFormController();
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevationContainer(
                          child: Expanded(
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
                                        Text('Booking 1',
                                            style: TabelText.headerText),
                                        Text("Booking iD XXXXXX",
                                            style: TabelText.text3),
                                      ],
                                    ),
                                  ),
                                ),
                                // Add spacing between the brown container and the white container

                                SizedBox(
                                  height: 200,
                                  child: ListView(
                                    children: [_booking1Table()],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.5.w,
                      ),
                      Expanded(
                        child: ElevationContainer(
                          child: Expanded(
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
                                        Text('Booking 2',
                                            style: TabelText.headerText),
                                        Text("Booking iD XXXXXX",
                                            style: TabelText.text3),
                                      ],
                                    ),
                                  ),
                                ),
                                // Add spacing between the brown container and the white container

                                SizedBox(
                                  height: 200,
                                  child: ListView(
                                    children: [_booking1Table()],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4.5.w,
                      ),
                      ElevationContainer(
                        width: 200,
                        child: Column(
                          children: [
                            Container(
                              height: 55,

                              color:
                                  Color.fromRGBO(75, 61, 82, 1), // Brown color
                              child: Center(
                                child: Text('New Booking',
                                    style: TabelText.headerText),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePageEnter(
                                      user: widget.user,
                                    ),
                                  ),
                                );
                              },
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: 195,
                                  child: Image.network(
                                    color: Color.fromRGBO(225, 225, 225, 1),
                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/add.png?alt=media&token=a10203f3-6af3-4a15-aeea-eb7d9a5fff98',
                                    width: 60,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  ElevationContainer(
                    child: Scrollbar(
                      controller: _book3Scroll,
                      thumbVisibility:
                          true, // Set to true to always show the scrollbar
                      child: SingleChildScrollView(
                        controller: _book3Scroll,
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 280,
                          width: 1110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(
                              color: Color.fromRGBO(112, 112, 112, 1)
                                  .withOpacity(0.3),
                            ),
                          ),
                          child: ListView(
                            children: [_createDataTable()],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(2.w, 1.5.h, 2.w, 1.5.h),
                      color: Color.fromRGBO(255, 255, 255, 157),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevationContainer(
                              child: Column(
                                children: [
                                  Container(
                                    height: 55, width: 90.w,
                                    color: Color.fromRGBO(
                                        75, 61, 82, 1), // Brown color
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          1.5.w, 1.5.h, 1.5.w, 1.5.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Booking 1',
                                              style: TabelText.headerText),
                                          Text("Booking iD XXXXXX",
                                              style: TabelText.text3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Scrollbar(
                                    controller: _book1Scroll,
                                    thumbVisibility:
                                        true, // Set to true to always show the scrollbar
                                    child: SingleChildScrollView(
                                      controller: _book1Scroll,
                                      scrollDirection: Axis.horizontal,
                                      child: Expanded(
                                        child: Container(
                                          height: 200,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                      112, 112, 112, 1)
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          child: ListView(
                                            children: [_booking1Table()],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add spacing between the brown container and the white container

                            SizedBox(
                              height: 4.h,
                            ),
                            ElevationContainer(
                              child: Column(
                                children: [
                                  Container(
                                    height: 55, width: 90.w,
                                    color: Color.fromRGBO(
                                        75, 61, 82, 1), // Brown color
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          1.5.w, 1.5.h, 1.5.w, 1.5.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Booking 2',
                                              style: TabelText.headerText),
                                          Text("Booking iD XXXXXX",
                                              style: TabelText.text3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Scrollbar(
                                    controller: _book2Scroll,
                                    thumbVisibility:
                                        true, // Set to true to always show the scrollbar
                                    child: SingleChildScrollView(
                                      controller: _book2Scroll,
                                      scrollDirection: Axis.horizontal,
                                      child: Expanded(
                                        child: Container(
                                          height: 200,
                                          width: 90.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            border: Border.all(
                                              color: Color.fromRGBO(
                                                      112, 112, 112, 1)
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          child: ListView(
                                            children: [_booking1Table()],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add spacing between the brown container and the white container
                            SizedBox(
                              height: 4.h,
                            ),
                            ElevationContainer(
                              child: Column(
                                children: [
                                  Container(
                                    height: 55,

                                    color: Color.fromRGBO(
                                        75, 61, 82, 1), // Brown color
                                    child: Center(
                                      child: Text('New Booking',
                                          style: TabelText.headerText),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyHomePage(),
                                        ),
                                      );
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 195,
                                        child: Image.network(
                                          color:
                                              Color.fromRGBO(225, 225, 225, 1),
                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/add.png?alt=media&token=a10203f3-6af3-4a15-aeea-eb7d9a5fff98',
                                          width: 60,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            ElevationContainer(
                              child: Scrollbar(
                                controller: _book3Scroll,
                                thumbVisibility:
                                    true, // Set to true to always show the scrollbar
                                child: SingleChildScrollView(
                                  controller: _book3Scroll,
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                    height: 280,
                                    width: 1110,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: ListView(
                                      children: [_createDataTable()],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))),
          );
        }
      });
    });
  }

  DataTable _createDataTable() {
    return DataTable(
        headingRowHeight: 60,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => Color.fromRGBO(75, 61, 82, 1),
        ),
        dataRowHeight: 70,
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
          label: Text('Booking ID', style: BookingManagerText.sfpro20white)),
      DataColumn(label: Text('Mode', style: BookingManagerText.sfpro20white)),
      DataColumn(
          label: Text('Booking Type', style: BookingManagerText.sfpro20white)),
      DataColumn(label: Text('Vendor', style: BookingManagerText.sfpro20white)),
      DataColumn(
          label:
              Text('Payment Status', style: BookingManagerText.sfpro20white)),
      DataColumn(label: Text('Status', style: BookingManagerText.sfpro20white)),
      DataColumn(
          label: Text('Actions', style: BookingManagerText.sfpro20white)),
    ];
  }

  // List<DataRow> _createRows() {
  //   return _books
  //       .map((book) => DataRow(cells: [
  //             DataCell(Text('#' + book['id'].toString())),
  //             DataCell(Text(book['title'])),
  //             DataCell(Text(book['author']))
  //           ]))
  //       .toList();
  // }
  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('NAQBOOK***', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Truck', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Single', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Vendor 1', style: BookingManagerText.sfpro20black))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(
                    left: 2.w, right: 2.w, top: 2.5.h, bottom: 2.5.h),
                elevation: 2,
                backgroundColor: Color.fromRGBO(247, 230, 176, 1),
                side: BorderSide(
                  color: Color.fromARGB(255, 196, 196, 196).withOpacity(0.1),
                ),
              ),
              child: Text('Bal XXXX',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Color.fromRGBO(88, 67, 67, 1),
                    fontSize: 14,
                  )),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group268.png?alt=media&token=edc506eb-e110-49dc-9798-ab4c877c27ef',
              width: 50,
              height: 30,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('NAQBOOK***', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Bus', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Contracts', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Vendor 2', style: BookingManagerText.sfpro20black))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(
                    left: 2.w, right: 2.w, top: 2.5.h, bottom: 2.5.h),
                elevation: 2,
                backgroundColor: Color.fromRGBO(247, 230, 176, 1),
                side: BorderSide(
                  color: Color.fromARGB(255, 196, 196, 196).withOpacity(0.1),
                ),
              ),
              child: Text('Bal XXXX',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Color.fromRGBO(88, 67, 67, 1),
                    fontSize: 14,
                  )),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Image.network(
              'Group300.png',
              width: 50,
              height: 30,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('NAQBOOK***', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Equipment', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Single', style: BookingManagerText.sfpro20black))),
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('Vendor 3', style: BookingManagerText.sfpro20black))),
        DataCell(
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.only(
                    left: 2.w, right: 2.w, top: 2.5.h, bottom: 2.5.h),
                elevation: 2,
                backgroundColor: Color.fromRGBO(87, 192, 18, 1),
                side: BorderSide(
                  color: Color.fromARGB(255, 196, 196, 196).withOpacity(0.1),
                ),
              ),
              child: Text('Completed',
                  style: TextStyle(
                    fontFamily: 'Helvetica',
                    color: Colors.white,
                    fontSize: 14,
                  )),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group353.png?alt=media&token=49b6c2b7-073e-4300-ad9a-137aec5909c8',
              width: 50,
              height: 30,
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ]),
    ];
  }

  DataTable _booking1Table() {
    return DataTable(
        columnSpacing: 15,
        dataRowHeight: 65,
        headingRowHeight: 0,
        columns: _booking1Columns(),
        rows: _booking1Rows());
  }

  List<DataColumn> _booking1Columns() {
    return [
      DataColumn(
        label: SizedBox(),
        numeric: true,
      ),
      DataColumn(label: SizedBox(), numeric: false),
      DataColumn(label: SizedBox(), numeric: true),
    ];
  }

  // List<DataRow> _createRows() {
  //   return _books
  //       .map((book) => DataRow(cells: [
  //             DataCell(Text('#' + book['id'].toString())),
  //             DataCell(Text(book['title'])),
  //             DataCell(Text(book['author']))
  //           ]))
  //       .toList();
  // }
  List<DataRow> _booking1Rows() {
    return [
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: SizedBox(
              width: 35,
              height: 35,
              child: SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(),
              ),
            ),
          ),
        ),
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Truck', style: TabelText.text1),
                SizedBox(height: 3),
                Text("Truck no ******", style: TabelText.text2),
              ],
            ),
          ),
        ),
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: EditButton(
              text: 'View',
              onPressed: () {},
              colors: Color.fromRGBO(98, 106, 254, 1),
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: SizedBox(
              width: 35,
              height: 35,
              child: SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(),
              ),
            ),
          ),
        ),
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pick Up Location', style: TabelText.text1),
                SizedBox(height: 3),
                Text("Destination Location", style: TabelText.text2),
              ],
            ),
          ),
        ),
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: EditButton(
              text: 'Edit',
              onPressed: () {},
              colors: Color.fromRGBO(98, 106, 254, 1),
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: SizedBox(
              width: 35,
              height: 35,
              child: SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(),
              ),
            ),
          ),
        ),
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Balance Amount', style: TabelText.text1),
                SizedBox(height: 3),
                Text("07.02.2022", style: TabelText.text2),
              ],
            ),
          ),
        ),
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: EditButton(
              text: 'Pay',
              onPressed: () {},
              colors: Color.fromRGBO(98, 106, 254, 1),
            ),
          ),
        ),
      ]),
    ];
  }
}
