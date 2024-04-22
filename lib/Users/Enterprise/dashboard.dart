import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/Users/Enterprise/homePageEnterprise.dart';
import 'package:naqli_android_app/pieChart/app_colors.dart';
import 'package:naqli_android_app/pieChart/indicator.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/echarts_data.dart';
import 'package:graphic/graphic.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

class enterDashboard extends StatefulWidget {
  final String user;
  enterDashboard({required this.user});
  @override
  State<enterDashboard> createState() => _DashboardState();
}

class _DashboardState extends State<enterDashboard> {
  final ScrollController _bookScroll = ScrollController();
  final ScrollController _pendingbookScroll = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AllUsersFormController controller = AllUsersFormController();
  String month = '';
  int touchedIndex = -1;
  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: AppColors.contentColorYellow,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorPurple,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: AppColors.contentColorGreen,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  void tapOnPieChart(FlTouchEvent event, PieTouchResponse? response) {
    if (response != null) {
      final sectionIndex = response.touchedSection!.touchedSectionIndex;
      final value = response.touchedSection!.touchedSection!.value;
      if (sectionIndex == 0) {
        month = 'January - $value';
      } else if (sectionIndex == 1) {
        month = 'February - $value';
      } else if (sectionIndex == 2) {
        month = 'March - $value';
      } else if (sectionIndex == 3) {
        month = 'April - $value';
      } else if (sectionIndex == 4) {
        month = 'May - $value';
      }
      setState(() {});
      print('Tapped on section: $sectionIndex');
      // You can add your custom logic here to respond to the tap on the Pie Chart
    }
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
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Total Bookings : "),
                    Text(
                      "103",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: Expanded(
                        child: Column(
                          children: [
                            ElevationContainer(
                              height: 250,
                              child: Stack(
                                children: [
                                  PieChart(
                                    PieChartData(
                                      startDegreeOffset: 110,
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 60,
                                      sections: [
                                        PieChartSectionData(
                                          value: 49,
                                          color:
                                              Color.fromRGBO(127, 106, 255, 1),
                                          radius: 50,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 20,
                                          color:
                                              Color.fromRGBO(112, 207, 151, 1),
                                          radius: 45,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 24,
                                          color:
                                              Color.fromRGBO(133, 232, 245, 1),
                                          radius: 40,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 20,
                                          color:
                                              Color.fromRGBO(237, 90, 107, 1),
                                          radius: 35,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 15,
                                          color:
                                              Color.fromRGBO(201, 104, 255, 1),
                                          radius: 30,
                                          showTitle: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "29 %",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Text(
                                                "Completed",
                                                style:
                                                    DashboardText.helvetica10,
                                              ),
                                              Text(
                                                "Sucessfully",
                                                style:
                                                    DashboardText.helvetica10,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            ElevationContainer(
                              child: Column(
                                children: [
                                  Container(
                                    width: 370,
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
                                          Text('Booking',
                                              style: TabelText.headerText),
                                          Text("View All",
                                              style: DialogText.helvetica20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Scrollbar(
                                    controller: _bookScroll,
                                    thumbVisibility:
                                        false, // Set to true to always show the scrollbar
                                    child: SingleChildScrollView(
                                      controller: _bookScroll,
                                      scrollDirection: Axis.horizontal,
                                      child: SizedBox(
                                          width: 357, child: _booking1Table()),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ElevationContainer(
                                  height: 250,
                                  child: Chart(
                                    data: lineMarkerData,
                                    variables: {
                                      'day': Variable(
                                        accessor: (Map datum) =>
                                            datum['day'] as String,
                                        scale: OrdinalScale(inflate: true),
                                      ),
                                      'value': Variable(
                                        accessor: (Map datum) =>
                                            datum['value'] as num,
                                        scale: LinearScale(
                                          max: 15,
                                          min: -3,
                                          tickCount: 7,
                                          formatter: (v) => '${v.toInt()} ℃',
                                        ),
                                      ),
                                      'group': Variable(
                                        accessor: (Map datum) =>
                                            datum['group'] as String,
                                      ),
                                    },
                                    marks: [
                                      LineMark(
                                        position: Varset('day') *
                                            Varset('value') /
                                            Varset('group'),
                                        color: ColorEncode(
                                          variable: 'group',
                                          values: [
                                            const Color(0xff5470c6),
                                            const Color(0xff91cc75),
                                          ],
                                        ),
                                      ),
                                    ],
                                    axes: [
                                      Defaults.horizontalAxis,
                                      Defaults.verticalAxis,
                                    ],
                                    selections: {
                                      'tooltipMouse': PointSelection(on: {
                                        GestureType.hover,
                                      }, devices: {
                                        PointerDeviceKind.mouse
                                      }, variable: 'day', dim: Dim.x),
                                      'tooltipTouch': PointSelection(on: {
                                        GestureType.scaleUpdate,
                                        GestureType.tapDown,
                                        GestureType.longPressMoveUpdate
                                      }, devices: {
                                        PointerDeviceKind.touch
                                      }, variable: 'day', dim: Dim.x),
                                    },
                                    tooltip: TooltipGuide(
                                      followPointer: [true, true],
                                      align: Alignment.topLeft,
                                      variables: ['group', 'value'],
                                    ),
                                    crosshair: CrosshairGuide(
                                      followPointer: [false, true],
                                    ),
                                    annotations: [
                                      LineAnnotation(
                                        dim: Dim.y,
                                        value: 6.14,
                                        style: PaintStyle(
                                          strokeColor: const Color(0xff5470c6)
                                              .withAlpha(100),
                                          dash: [2],
                                        ),
                                      ),
                                      LineAnnotation(
                                        dim: Dim.y,
                                        value: 3.57,
                                        style: PaintStyle(
                                          strokeColor: const Color(0xff91cc75)
                                              .withAlpha(100),
                                          dash: [2],
                                        ),
                                      ),
                                      CustomAnnotation(
                                          renderer: (offset, _) => [
                                                CircleElement(
                                                    center: offset,
                                                    radius: 5,
                                                    style: PaintStyle(
                                                        fillColor: const Color(
                                                            0xff5470c6)))
                                              ],
                                          values: ['Mar', -3]),
                                      CustomAnnotation(
                                          renderer: (offset, _) => [
                                                CircleElement(
                                                    center: offset,
                                                    radius: 5,
                                                    style: PaintStyle(
                                                        fillColor: const Color(
                                                            0xff5470c6)))
                                              ],
                                          values: ['Jul', -7]),
                                      CustomAnnotation(
                                          renderer: (offset, _) => [
                                                CircleElement(
                                                    center: offset,
                                                    radius: 5,
                                                    style: PaintStyle(
                                                        fillColor: const Color(
                                                            0xff91cc75)))
                                              ],
                                          values: ['Feb', 2]),
                                      CustomAnnotation(
                                          renderer: (offset, _) => [
                                                CircleElement(
                                                    center: offset,
                                                    radius: 5,
                                                    style: PaintStyle(
                                                        fillColor: const Color(
                                                            0xff91cc75)))
                                              ],
                                          values: ['Apr', -5]),
                                      TagAnnotation(
                                        label: Label(
                                            '13',
                                            LabelStyle(
                                              textStyle: Defaults.textStyle,
                                              offset: const Offset(0, -10),
                                            )),
                                        values: ['Mar', -13],
                                      ),
                                      TagAnnotation(
                                        label: Label(
                                            '9',
                                            LabelStyle(
                                              textStyle: Defaults.textStyle,
                                              offset: const Offset(0, -10),
                                            )),
                                        values: ['July', -9],
                                      ),
                                      TagAnnotation(
                                        label: Label(
                                            '-2',
                                            LabelStyle(
                                              textStyle: Defaults.textStyle,
                                              offset: const Offset(0, -10),
                                            )),
                                        values: ['Feb', -2],
                                      ),
                                      TagAnnotation(
                                        label: Label(
                                            '5',
                                            LabelStyle(
                                              textStyle: Defaults.textStyle,
                                              offset: const Offset(0, -10),
                                            )),
                                        values: ['Apr', -5],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              ElevationContainer(
                                bottomleft: 20,
                                bottomright: 20,
                                height: 250,
                                width: 180,
                                child: Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePageEnter(
                                                user: widget.user,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: Image.network(
                                            'assets/https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/add.png?alt=media&token=a10203f3-6af3-4a15-aeea-eb7d9a5fff98', // Make sure to provide the correct path to your image asset
                                            color: Color.fromRGBO(
                                                143, 142, 151, 1),
                                            width: 120,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          ElevationContainer(
                            child: Column(
                              children: [
                                Container(
                                  width: 715,
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
                                        Text('Booking Approval',
                                            style: TabelText.headerText),
                                        Text("View All",
                                            style: DialogText.helvetica20),
                                      ],
                                    ),
                                  ),
                                ),
                                Scrollbar(
                                  controller: _pendingbookScroll,
                                  thumbVisibility:
                                      false, // Set to true to always show the scrollbar
                                  child: SingleChildScrollView(
                                    controller: _pendingbookScroll,
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                        width: 715, child: _pendingbookTable()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Row(
                              children: [
                                Text("Total Bookings : "),
                                Text(
                                  "103",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            SizedBox(
                              height: 250,
                              child: Stack(
                                children: [
                                  PieChart(
                                    PieChartData(
                                      startDegreeOffset: 110,
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 60,
                                      sections: [
                                        PieChartSectionData(
                                          value: 49,
                                          color:
                                              Color.fromRGBO(127, 106, 255, 1),
                                          radius: 50,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 20,
                                          color:
                                              Color.fromRGBO(112, 207, 151, 1),
                                          radius: 45,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 24,
                                          color:
                                              Color.fromRGBO(133, 232, 245, 1),
                                          radius: 40,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 20,
                                          color:
                                              Color.fromRGBO(237, 90, 107, 1),
                                          radius: 35,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 15,
                                          color:
                                              Color.fromRGBO(201, 104, 255, 1),
                                          radius: 30,
                                          showTitle: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "29 %",
                                                style: TextStyle(
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Text(
                                                "Completed",
                                                style:
                                                    DashboardText.helvetica10,
                                              ),
                                              Text(
                                                "Sucessfully",
                                                style:
                                                    DashboardText.helvetica10,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            ElevationContainer(
                              height: 250,
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Image.network(
                                        color: Color.fromRGBO(143, 142, 151, 1),
                                        'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/add.png?alt=media&token=a10203f3-6af3-4a15-aeea-eb7d9a5fff98',
                                        width: 120,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
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
                                          Text('Bookings',
                                              style: TabelText.headerText),
                                          Text("View All",
                                              style: TabelText.text3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Scrollbar(
                                    controller: _bookScroll,
                                    thumbVisibility:
                                        true, // Set to true to always show the scrollbar
                                    child: SingleChildScrollView(
                                      controller: _bookScroll,
                                      scrollDirection: Axis.horizontal,
                                      child: Expanded(
                                        child: Container(
                                          width: 90.w,
                                          height: 200,
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
                            SizedBox(
                              height: 5.h,
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
                                          Text('Booking Approval',
                                              style: TabelText.headerText),
                                          Text("View All",
                                              style: TabelText.text3),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Scrollbar(
                                    controller: _pendingbookScroll,
                                    thumbVisibility:
                                        false, // Set to true to always show the scrollbar
                                    child: SingleChildScrollView(
                                      controller: _pendingbookScroll,
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
                                            children: [_pendingbookTable()],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
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

  DataTable _booking1Table() {
    return DataTable(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          border: Border.all(
            color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.3),
          ),
        ),
        columnSpacing: 15,
        dataRowHeight: 65,
        headingRowHeight: 0,
        columns: _booking1Columns(),
        rows: _booking1Rows());
  }

  List<DataColumn> _booking1Columns() {
    return [
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(230, 228, 238, 1),
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Trip 1', style: TabelText.text1),
                        SizedBox(height: 3),
                        Text("18.02.2022", style: TabelText.text2),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 60,
                        child: Text('Truck',
                            textAlign: TextAlign.center,
                            style: TabelText.text2)),
                    SizedBox(
                      width: 1.w,
                    ),
                    ViewButton(
                      text: 'View',
                      onPressed: () {},
                      colors: Color.fromRGBO(245, 243, 255, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(230, 228, 238, 1),
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Equipment Hire', style: TabelText.text1),
                        SizedBox(height: 3),
                        Text("10.02.2022", style: TabelText.text2),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 60,
                        child: Text('Heavy Equipment',
                            textAlign: TextAlign.center,
                            style: TabelText.text2)),
                    SizedBox(
                      width: 1.w,
                    ),
                    ViewButton(
                      text: 'View',
                      onPressed: () {},
                      colors: Color.fromRGBO(245, 243, 255, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                      height: 35,
                      child: CircleAvatar(
                        backgroundColor: Color.fromRGBO(230, 228, 238, 1),
                      ),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Fletch Skinner', style: TabelText.text1),
                        SizedBox(height: 3),
                        Text("07.02.2022", style: TabelText.text2),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 60,
                        child: Text('Trailer',
                            textAlign: TextAlign.center,
                            style: TabelText.text2)),
                    SizedBox(
                      width: 1.w,
                    ),
                    ViewButton(
                      text: 'View',
                      onPressed: () {},
                      colors: Color.fromRGBO(245, 243, 255, 1),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    ];
  }

  DataTable _pendingbookTable() {
    return DataTable(
        border: TableBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            verticalInside: BorderSide(
                width: 1,
                color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.2)),
            right: BorderSide(
                width: 0.5,
                color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.2))),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(colors: [
            Colors.white,
            Color.fromRGBO(245, 243, 255, 1),
            Colors.white,
            Color.fromRGBO(245, 243, 255, 1),
          ], stops: [
            0.033.w,
            0.033.w,
            0.033.w,
            0.033.w,
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
        ),
        columnSpacing: 0,
        dataRowHeight: 65,
        headingRowHeight: 0,
        columns: _pendingbookColumns(),
        dividerThickness: 1,
        rows: _pendingbookRows());
  }

  List<DataColumn> _pendingbookColumns() {
    return [
      DataColumn(label: SizedBox(), numeric: false),
      DataColumn(
          label: SizedBox(
            width: 110,
          ),
          numeric: true),
      DataColumn(
          label: SizedBox(
            width: 110,
          ),
          numeric: true),
      DataColumn(
          label: SizedBox(
            width: 110,
          ),
          numeric: true),
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
  List<DataRow> _pendingbookRows() {
    return [
      DataRow(cells: [
        DataCell(
          Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(230, 228, 238, 1),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Truck', style: TabelText.text1),
                  SizedBox(height: 3),
                  Text("Booking ID XXXXXX", style: TabelText.text2),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color.fromRGBO(245, 243, 255, 1),
            child: ColorContainer(
              text1: 'Vendor 3',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(200, 251, 253, 1),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color.fromRGBO(245, 243, 255, 1),
            child: ColorContainer(
              text1: 'Vendor 2',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(224, 253, 200, 1),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10),
            child: ColorContainer(
              text1: 'Vendor 3',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(245, 253, 200, 1),
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(230, 228, 238, 1),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Equipment Hire', style: TabelText.text1),
                  SizedBox(height: 3),
                  Text("Booking ID XXXXXX", style: TabelText.text2),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color.fromRGBO(245, 243, 255, 1),
            child: ColorContainer(
              text1: 'Vendor 3',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(200, 251, 253, 1),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color.fromRGBO(245, 243, 255, 1),
            child: ColorContainer(
              text1: 'Vendor 2',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(224, 253, 200, 1),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10),
            child: ColorContainer(
              text1: 'Vendor 3',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(245, 253, 200, 1),
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Row(
            children: [
              SizedBox(
                width: 35,
                height: 35,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(230, 228, 238, 1),
                ),
              ),
              SizedBox(
                width: 1.w,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bus Trip', style: TabelText.text1),
                  SizedBox(height: 3),
                  Text("Booking ID XXXXXX", style: TabelText.text2),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color.fromRGBO(245, 243, 255, 1),
            child: ColorContainer(
              text1: 'Vendor 3',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(200, 251, 253, 1),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            color: Color.fromRGBO(245, 243, 255, 1),
            child: ColorContainer(
              text1: 'Vendor 2',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(224, 253, 200, 1),
            ),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.only(left: 10),
            child: ColorContainer(
              text1: 'Vendor 3',
              text2: 'Xxxxx SAR',
              colors: Color.fromRGBO(245, 253, 200, 1),
            ),
          ),
        ),
      ]),
    ];
  }
}
