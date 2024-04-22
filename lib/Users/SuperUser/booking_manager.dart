import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/DialogBox/bookingConfirmation.dart';
import 'package:naqli_android_app/Users/Enterprise/contracts.dart';
import 'package:naqli_android_app/Users/Enterprise/newContract.dart';
import 'package:naqli_android_app/Users/SuperUser/edit_contract.dart';

import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/homePage.dart';
import 'package:naqli_android_app/Users/SuperUser/homePageSuperUser.dart';
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePagesuper(
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
                    height: 4.h,
                  ),
                  Scrollbar(
                    controller: _book3Scroll,
                    thumbVisibility:
                        true, // Set to true to always show the scrollbar
                    child: SingleChildScrollView(
                      controller: _book3Scroll,
                      scrollDirection: Axis.horizontal,
                      child: ElevationContainer(
                        width: 1150,
                        height: 210,
                        child: ListView(
                          children: [_createDataTable()],
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
                      padding: EdgeInsets.fromLTRB(5.w, 1.5.h, 5.w, 1.5.h),
                      color: Color.fromRGBO(255, 255, 255, 157),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Scrollbar(
                              controller: _book1Scroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _book1Scroll,
                                scrollDirection: Axis.horizontal,
                                child: ElevationContainer(
                                  width: 800,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Booking 1',
                                                    style:
                                                        TabelText.headerText),
                                                Text("Booking iD XXXXXX",
                                                    style: TabelText.text3),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Add spacing between the brown container and the white container

                                        SizedBox(
                                          height: 220,
                                          child: ListView(
                                            children: [_booking1Table()],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Scrollbar(
                              controller: _book2Scroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _book2Scroll,
                                scrollDirection: Axis.horizontal,
                                child: ElevationContainer(
                                  width: 800,
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
                                        height: 220,
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
                            Scrollbar(
                              controller: _book3Scroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _book3Scroll,
                                scrollDirection: Axis.horizontal,
                                child: ElevationContainer(
                                  width: 950,
                                  height: 230,
                                  child: ListView(
                                    children: [_createDataTable()],
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
        headingRowHeight: 55,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => Color.fromRGBO(75, 61, 82, 1),
        ),
        columns: _createColumns(),
        rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Booking ID', style: TabelText.headerText)),
      DataColumn(label: Text('Mode', style: TabelText.headerText)),
      DataColumn(label: Text('Booking Type', style: TabelText.headerText)),
      DataColumn(label: Text('Vendor', style: TabelText.headerText)),
      DataColumn(label: Text('Payment Status', style: TabelText.headerText)),
      DataColumn(label: Text('Status', style: TabelText.headerText)),
      DataColumn(label: Text('Actions', style: TabelText.headerText)),
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
        DataCell(Text('NAQBOOK***', style: TabelText.tableText)),
        DataCell(Text('Truck', style: TabelText.tableText)),
        DataCell(Text('Single', style: TabelText.tableText)),
        DataCell(Text('Vendor', style: TabelText.tableText)),
        DataCell(Text('Bal XXXX', style: TabelText.tableText)),
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
                  onPressed: () {
                    showDialog(
                      barrierColor:
                          Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 380, top: 40),
                          child: EditContract(),
                        );
                      },
                    );
                  },
                  icon: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
              SizedBox(
                width: 1.w,
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    showDialog(
                      barrierColor:
                          Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 350),
                          child: BookingConfirmationDialog(),
                        );
                      },
                    );
                  },
                  icon: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
            ],
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('NAQBOOK***', style: TabelText.tableText)),
        DataCell(Text('Truck', style: TabelText.tableText)),
        DataCell(Text('Single', style: TabelText.tableText)),
        DataCell(Text('Vendor', style: TabelText.tableText)),
        DataCell(Text('Bal XXXX', style: TabelText.tableText)),
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
                  onPressed: () {
                    showDialog(
                      barrierColor:
                          Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 350),
                          child: BookingConfirmationDialog(),
                        );
                      },
                    );
                  },
                  icon: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
            ],
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(Text('NAQBOOK***', style: TabelText.tableText)),
        DataCell(Text('Truck', style: TabelText.tableText)),
        DataCell(Text('Single', style: TabelText.tableText)),
        DataCell(Text('Vendor', style: TabelText.tableText)),
        DataCell(Text('Bal XXXX', style: TabelText.tableText)),
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
                  onPressed: () {
                    showDialog(
                      barrierColor:
                          Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 350),
                          child: BookingConfirmationDialog(),
                        );
                      },
                    );
                  },
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
