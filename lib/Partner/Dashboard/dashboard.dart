import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/formText.dart';

import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/echarts_data.dart';
import 'package:naqli_android_app/pieChart/app_colors.dart';
import 'package:naqli_android_app/pieChart/indicator.dart';

import 'package:graphic/graphic.dart';
import 'package:sizer/sizer.dart';

class Dashboard extends StatefulWidget {
  Dashboard();
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ScrollController _bookScroll = ScrollController();
  final ScrollController _pendingbookScroll = ScrollController();
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
                  width: 4.w,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30.w,
                      child: Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 250,
                              child: Stack(
                                children: [
                                  PieChart(
                                    PieChartData(
                                      startDegreeOffset: 250,
                                      sectionsSpace: 0,
                                      centerSpaceRadius: 100,
                                      sections: [
                                        PieChartSectionData(
                                          value: 45,
                                          color: Colors.greenAccent,
                                          radius: 45,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 35,
                                          color: Colors.blue.shade900,
                                          radius: 25,
                                          showTitle: false,
                                        ),
                                        PieChartSectionData(
                                          value: 20,
                                          color: Colors.grey.shade400,
                                          radius: 20,
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
                                          height: 160,
                                          width: 160,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade200,
                                                blurRadius: 10.0,
                                                spreadRadius: 10.0,
                                                offset: const Offset(3.0, 3.0),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "2305",
                                              style: TextStyle(fontSize: 20),
                                            ),
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
                            Scrollbar(
                              controller: _bookScroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _bookScroll,
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                  ),
                                  width: 380,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 450,
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
                                              Text('Bookings',
                                                  style: TabelText.headerText),
                                              Text("View All",
                                                  style: TabelText.text3),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Add spacing between the brown container and the white container

                                      SizedBox(
                                        width: 380,
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
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
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
                              Container(
                                height: 250,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 55,

                                        color: Color.fromRGBO(
                                            75, 61, 82, 1), // Brown color
                                        child: Center(
                                          child: Text(
                                            'New Booking',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Image.network(
                                          color:
                                              Color.fromRGBO(143, 142, 151, 1),
                                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/add.png?alt=media&token=a10203f3-6af3-4a15-aeea-eb7d9a5fff98',
                                          width: 120,
                                          height: 170,
                                        ),
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
                          Scrollbar(
                            controller: _pendingbookScroll,
                            thumbVisibility:
                                true, // Set to true to always show the scrollbar
                            child: SingleChildScrollView(
                              controller: _pendingbookScroll,
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                ),
                                width: 750,
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
                                            Text('Booking Approval',
                                                style: TabelText.headerText),
                                            Text("View All",
                                                style: TabelText.text3),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Add spacing between the brown container and the white container

                                    SizedBox(
                                      height: 200,
                                      child: ListView(
                                        children: [_pendingbookTable()],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ));
        } else {
          return SingleChildScrollView(
              child: Container(
                  color: Color.fromRGBO(255, 255, 255, 200),
                  padding: EdgeInsets.fromLTRB(3.w, 7.h, 3.w, 2.5.h),
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(5.w, 1.5.h, 5.w, 1.5.h),
                      color: Color.fromRGBO(255, 255, 255, 157),
                      child: Expanded(
                        child: Column(
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
                            Container(
                              height: 250,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: AspectRatio(
                                aspectRatio: 1.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: PieChart(
                                        PieChartData(
                                          pieTouchData: PieTouchData(
                                            touchCallback: (FlTouchEvent event,
                                                pieTouchResponse) {
                                              setState(() {
                                                if (!event
                                                        .isInterestedForInteractions ||
                                                    pieTouchResponse == null ||
                                                    pieTouchResponse
                                                            .touchedSection ==
                                                        null) {
                                                  touchedIndex = -1;
                                                  return;
                                                }
                                                touchedIndex = pieTouchResponse
                                                    .touchedSection!
                                                    .touchedSectionIndex;
                                              });
                                            },
                                          ),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 40,
                                          sections: showingSections(),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Indicator(
                                          color: AppColors.contentColorBlue,
                                          text: 'First',
                                          isSquare: true,
                                          textStyle: TextStyle(
                                            fontSize:
                                                5, // Adjust the font size as needed
                                            // Add more styling options if necessary
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: AppColors.contentColorYellow,
                                          text: 'Second',
                                          isSquare: true,
                                          textStyle: TextStyle(
                                            fontSize:
                                                5, // Adjust the font size as needed
                                            // Add more styling options if necessary
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: AppColors.contentColorGreen,
                                          text: 'Third',
                                          isSquare: true,
                                          textStyle: TextStyle(
                                            fontSize:
                                                5, // Adjust the font size as needed
                                            // Add more styling options if necessary
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: AppColors.contentColorPurple,
                                          text: 'Fourth',
                                          isSquare: true,
                                          textStyle: TextStyle(
                                            fontSize:
                                                5, // Adjust the font size as needed
                                            // Add more styling options if necessary
                                          ),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
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
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      height: 55,

                                      color: Color.fromRGBO(
                                          75, 61, 82, 1), // Brown color
                                      child: Center(
                                        child: Text(
                                          'New Booking',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
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
                                        height: 170,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Scrollbar(
                              controller: _bookScroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _bookScroll,
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                  ),
                                  width: 380,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 450,
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
                                              Text('Bookings',
                                                  style: TabelText.headerText),
                                              Text("View All",
                                                  style: TabelText.text3),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Add spacing between the brown container and the white container

                                      SizedBox(
                                        width: 380,
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
                              height: 5.h,
                            ),
                            Scrollbar(
                              controller: _pendingbookScroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _pendingbookScroll,
                                scrollDirection: Axis.horizontal,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0),
                                        topRight: Radius.circular(0),
                                        bottomLeft: Radius.circular(12),
                                        bottomRight: Radius.circular(12)),
                                  ),
                                  width: 690,
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
                                              Text('Booking Approval',
                                                  style: TabelText.headerText),
                                              Text("View All",
                                                  style: TabelText.text3),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Add spacing between the brown container and the white container

                                      SizedBox(
                                        height: 200,
                                        child: ListView(
                                          children: [_pendingbookTable()],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])));
        }
      });
    });
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
                      child: CircleAvatar(),
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
                    Text("Truck", style: TabelText.text2),
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
                      child: CircleAvatar(),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Heavy', style: TabelText.text2),
                        SizedBox(height: 3),
                        Text("Equipment", style: TabelText.text2),
                      ],
                    ),
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
                      child: CircleAvatar(),
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
                    Text("Trailer", style: TabelText.text2),
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
        columnSpacing: 0,
        dataRowHeight: 65,
        headingRowHeight: 0,
        columns: _pendingbookColumns(),
        dividerThickness: 1,
        rows: _pendingbookRows());
  }

  List<DataColumn> _pendingbookColumns() {
    return [
      DataColumn(
          label: SizedBox(
            width: 50,
          ),
          numeric: false),
      DataColumn(
        label: SizedBox(),
        numeric: true,
      ),
      DataColumn(label: SizedBox(), numeric: true),
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
  List<DataRow> _pendingbookRows() {
    return [
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(),
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
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 3',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(200, 251, 253, 1),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 2',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(224, 253, 200, 1),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 3',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(245, 253, 200, 1),
              ),
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(),
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
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 3',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(200, 251, 253, 1),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 2',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(224, 253, 200, 1),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 3',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(245, 253, 200, 1),
              ),
            ),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Row(
              children: [
                SizedBox(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(),
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
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 3',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(200, 251, 253, 1),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 2',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(224, 253, 200, 1),
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(0.5.w, 2.5.h, 0.5.w, 2.5.h),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 1.0,
                ),
              ),
              color: Color.fromRGBO(245, 243, 255, 1),
            ),
            child: Container(
              child: ColorContainer(
                text1: 'Vendor 3',
                text2: 'Xxxxx SAR',
                colors: Color.fromRGBO(245, 253, 200, 1),
              ),
            ),
          ),
        ),
      ]),
    ];
  }
}
