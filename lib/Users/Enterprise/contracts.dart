import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

class Contracts extends StatefulWidget {
  Contracts();
  @override
  State<Contracts> createState() => _PaymentsState();
}

class _PaymentsState extends State<Contracts> {
  final ScrollController _ContractScroll = ScrollController();
  String? selectedCity;
  List<String> cities = ['City 1', 'City 2', 'City 3', 'City 4'];

  bool addContracts = false;
  DataTable _createDataTable() {
    return DataTable(
        headingRowHeight: 65,
        dataRowHeight: 70,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => Color.fromRGBO(75, 61, 82, 1),
        ),
        columns: _createColumns(),
        rows: _payments());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Booking ID', style: TabelText.headerText),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Contract ID', style: TabelText.headerText),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Tenure period', style: TabelText.headerText),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Total value', style: TabelText.headerText),
        ),
      ),
      DataColumn(
        label: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Recurring charge', style: TabelText.headerText),
        ),
      ),
    ];
  }

  List<DataRow> _payments() {
    return [
      DataRow(cells: [
        DataCell(
          Text(
            '#2341456721',
            style: TabelText.tableText3,
          ),
        ),
        DataCell(
          Text('#1568943128', style: TabelText.tableText3),
        ),
        DataCell(
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('1 year', style: TabelText.tableText3),
          )),
        ),
        DataCell(Text('XXXX SAR', style: TabelText.tableText3)),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('XXXX SAR', style: TabelText.tableText3),
              Text("Per month", style: TabelText.tableText4)
            ],
          ),
        )),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            '#2341456721',
            style: TabelText.tableText3,
          ),
        ),
        DataCell(
          Text('#1568943128', style: TabelText.tableText3),
        ),
        DataCell(
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('6 months', style: TabelText.tableText3),
          )),
        ),
        DataCell(Text('XXXX SAR', style: TabelText.tableText3)),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('XXXX SAR', style: TabelText.tableText3),
              Text("Per Day", style: TabelText.tableText4)
            ],
          ),
        )),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            '#2341456721',
            style: TabelText.tableText3,
          ),
        ),
        DataCell(
          Text('#1568943128', style: TabelText.tableText3),
        ),
        DataCell(
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('9 months', style: TabelText.tableText3),
          )),
        ),
        DataCell(Text('XXXX SAR', style: TabelText.tableText3)),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('XXXX SAR', style: TabelText.tableText3),
              Text("Per month", style: TabelText.tableText4)
            ],
          ),
        )),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            '#2341456721',
            style: TabelText.tableText3,
          ),
        ),
        DataCell(
          Text('#1568943128', style: TabelText.tableText3),
        ),
        DataCell(
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('2 years', style: TabelText.tableText3),
          )),
        ),
        DataCell(Text('XXXX SAR', style: TabelText.tableText3)),
        DataCell(Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('XXXX SAR', style: TabelText.tableText3),
              Text("Per month", style: TabelText.tableText4)
            ],
          ),
        )),
      ]),
    ];
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
              // padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: addContracts
                                ? Color.fromRGBO(106, 102, 209, 1)
                                : Color.fromRGBO(75, 61, 82, 1),
                            border: Border.all(
                              width: 1.0,
                              color: addContracts
                                  ? Color.fromRGBO(106, 102, 209, 1)
                                  : Color.fromRGBO(75, 61, 82, 1),
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 80, top: 20),
                            child: Text(
                                addContracts ? 'New Contracts' : 'Contracts',
                                style: BookingHistoryText.helvetica40),
                          ),
                        ),
                      ),
                    ],
                  ),
                  addContracts
                      ? Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(0),
                                    topRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Scrollbar(
                                      controller: _ContractScroll,
                                      thumbVisibility: true,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: _ContractScroll,
                                        child: Container(
                                          height: 340,
                                          width: 1000,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40.0),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), // Adjust the shadow color and opacity
                                                blurRadius:
                                                    5.0, // Adjust the blur radius for a more visible shadow
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 48),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      "Mode",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "SFProText-Regular",
                                                          fontSize: 17),
                                                    ),
                                                    Text(
                                                      "From",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "SFProText-Regular",
                                                          fontSize: 17),
                                                    ),
                                                    Text(
                                                      "To",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "SFProText-Regular",
                                                          fontSize: 17),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 30),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  SizedBox(
                                                    height: 45,
                                                    width: 160,
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.all(5.0),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                      ),
                                                      value: selectedCity,

                                                      // Set initial value to the first element
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          selectedCity =
                                                              newValue;
                                                        });
                                                      },
                                                      items: cities.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 45,
                                                    width: 160,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize: 16),
                                                        hintText: 'DD/MM/YYYY',
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                top: 20),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 45,
                                                    width: 160,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize: 16),
                                                        hintText: 'DD/MM/YYYY',
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 30,
                                                                top: 20),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 50,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 90,
                                                          child: Text(
                                                            "Mode Classification",
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                        SizedBox(
                                                          height: 45,
                                                          width: 160,
                                                          child:
                                                              DropdownButtonFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                              ),
                                                            ),
                                                            value: selectedCity,
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                selectedCity =
                                                                    newValue;
                                                              });
                                                            },
                                                            items: cities.map<
                                                                DropdownMenuItem<
                                                                    String>>((String
                                                                value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            }).toList(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 30,
                                                                  left: 50),
                                                          child: Column(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            9,
                                                                            78,
                                                                            37,
                                                                            1),

                                                                // You can change the background color here
                                                                radius: 10,
                                                                child: Text(
                                                                  'A',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white, // You can change the text color here
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: Dash(
                                                                    direction: Axis
                                                                        .vertical,
                                                                    length: 70,
                                                                    dashLength:
                                                                        10,
                                                                    dashColor: Color
                                                                        .fromRGBO(
                                                                            112,
                                                                            112,
                                                                            112,
                                                                            1)),
                                                              ),
                                                              CircleAvatar(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            147,
                                                                            10,
                                                                            26,
                                                                            1),

                                                                // You can change the background color here
                                                                radius: 10,
                                                                child: Text(
                                                                  'B',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white, // You can change the text color here
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 28),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 45,
                                                                width: 250,
                                                                child:
                                                                    TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                    hintText:
                                                                        'Enter your location',
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                50,
                                                                            top:
                                                                                20),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 50,
                                                              ),
                                                              SizedBox(
                                                                height: 45,
                                                                width: 250,
                                                                child:
                                                                    TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintStyle: TextStyle(
                                                                        fontSize:
                                                                            16),
                                                                    hintText:
                                                                        'Enter your location',
                                                                    contentPadding:
                                                                        EdgeInsets.only(
                                                                            left:
                                                                                50,
                                                                            top:
                                                                                20),
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(15)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 25),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 140,
                                                                child:
                                                                    VerticalDivider(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          112,
                                                                          112,
                                                                          112,
                                                                          1),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Contract Type",
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      SizedBox(
                                                        height: 45,
                                                        width: 160,
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                          ),
                                                          value: selectedCity,
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              selectedCity =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: cities.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 45,
                                                        width: 250,
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                          ),
                                                          value: selectedCity ??
                                                              cities.first,
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              selectedCity =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: cities.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 45,
                                                        width: 250,
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                          ),
                                                          value: selectedCity ??
                                                              cities.first,
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              selectedCity =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: cities.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    CustomButton(
                                      onPressed: () {},
                                      text: 'Send Contract',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  width: 180,
                                  height: 45,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      setState(() {
                                        addContracts = !addContracts;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Color.fromRGBO(98, 84, 84, 1),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            15), // Adjust border radius as needed
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.add,
                                      size: 15,
                                    ),
                                    label: Text('New Contracts',
                                        style: TextStyle(
                                          color: Color.fromRGBO(98, 84, 84, 1),
                                          fontFamily: 'Helvetica',
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              ElevationContainer(
                                child: Scrollbar(
                                  controller: _ContractScroll,
                                  thumbVisibility:
                                      true, // Set to true to always show the scrollbar
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    controller: _ContractScroll,
                                    child: Container(
                                      height: 340,
                                      width: 1070,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)
                                                  .withOpacity(0.3),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 220,
                                        child: ListView(
                                          children: [_createDataTable()],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: 86.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            // padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1250,
                  height: 92,
                  decoration: BoxDecoration(
                    color: addContracts
                        ? Color.fromRGBO(106, 102, 209, 1)
                        : Color.fromRGBO(75, 61, 82, 1),
                    border: Border.all(
                      width: 1.0,
                      color: addContracts
                          ? Color.fromRGBO(106, 102, 209, 1)
                          : Color.fromRGBO(75, 61, 82, 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 95, top: 25),
                    child: Text(
                      addContracts ? 'New Contracts' : 'Contracts',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: "Helvetica",
                      ),
                    ),
                  ),
                ),
                addContracts
                    ? Container(
                        height: 74.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color.fromRGBO(255, 255, 255, 0.925),
                        ),
                        // padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  topRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Scrollbar(
                                    controller: _ContractScroll,
                                    thumbVisibility: true,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      controller: _ContractScroll,
                                      child: Container(
                                        height: 340,
                                        width: 1000,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), // Adjust the shadow color and opacity
                                              blurRadius:
                                                  5.0, // Adjust the blur radius for a more visible shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 48),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Mode",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "SFProText-Regular",
                                                        fontSize: 17),
                                                  ),
                                                  Text(
                                                    "From",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "SFProText-Regular",
                                                        fontSize: 17),
                                                  ),
                                                  Text(
                                                    "To",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "SFProText-Regular",
                                                        fontSize: 17),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 30),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  height: 45,
                                                  width: 160,
                                                  child:
                                                      DropdownButtonFormField(
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(5.0),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                    ),
                                                    value: selectedCity,

                                                    // Set initial value to the first element
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedCity = newValue;
                                                      });
                                                    },
                                                    items: cities.map<
                                                        DropdownMenuItem<
                                                            String>>(
                                                      (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child: Text(value),
                                                        );
                                                      },
                                                    ).toList(),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 45,
                                                  width: 160,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          fontSize: 16),
                                                      hintText: 'DD/MM/YYYY',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 30,
                                                              top: 20),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 45,
                                                  width: 160,
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          fontSize: 16),
                                                      hintText: 'DD/MM/YYYY',
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 30,
                                                              top: 20),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 50,
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 90,
                                                        child: Text(
                                                          "Mode Classification",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 40,
                                                      ),
                                                      SizedBox(
                                                        height: 45,
                                                        width: 160,
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                          ),
                                                          value: selectedCity,
                                                          onChanged: (String?
                                                              newValue) {
                                                            setState(() {
                                                              selectedCity =
                                                                  newValue;
                                                            });
                                                          },
                                                          items: cities.map<
                                                              DropdownMenuItem<
                                                                  String>>((String
                                                              value) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 25,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 30,
                                                                left: 50),
                                                        child: Column(
                                                          children: [
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          9,
                                                                          78,
                                                                          37,
                                                                          1),

                                                              // You can change the background color here
                                                              radius: 10,
                                                              child: Text(
                                                                'A',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white, // You can change the text color here
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Dash(
                                                                  direction: Axis
                                                                      .vertical,
                                                                  length: 70,
                                                                  dashLength:
                                                                      10,
                                                                  dashColor: Color
                                                                      .fromRGBO(
                                                                          112,
                                                                          112,
                                                                          112,
                                                                          1)),
                                                            ),
                                                            CircleAvatar(
                                                              backgroundColor:
                                                                  Color
                                                                      .fromRGBO(
                                                                          147,
                                                                          10,
                                                                          26,
                                                                          1),

                                                              // You can change the background color here
                                                              radius: 10,
                                                              child: Text(
                                                                'B',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white, // You can change the text color here
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 28),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 45,
                                                              width: 250,
                                                              child:
                                                                  TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                  hintText:
                                                                      'Enter your location',
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              50,
                                                                          top:
                                                                              20),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 50,
                                                            ),
                                                            SizedBox(
                                                              height: 45,
                                                              width: 250,
                                                              child:
                                                                  TextFormField(
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintStyle:
                                                                      TextStyle(
                                                                          fontSize:
                                                                              16),
                                                                  hintText:
                                                                      'Enter your location',
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              50,
                                                                          top:
                                                                              20),
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(15)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 40,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 25),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 140,
                                                              child:
                                                                  VerticalDivider(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        112,
                                                                        112,
                                                                        112,
                                                                        1),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Contract Type",
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 45,
                                                      width: 160,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                        value: selectedCity,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedCity =
                                                                newValue;
                                                          });
                                                        },
                                                        items: cities.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 45,
                                                      width: 250,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                        value: selectedCity ??
                                                            cities.first,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedCity =
                                                                newValue;
                                                          });
                                                        },
                                                        items: cities.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 45,
                                                      width: 250,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                        value: selectedCity ??
                                                            cities.first,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedCity =
                                                                newValue;
                                                          });
                                                        },
                                                        items: cities.map<
                                                            DropdownMenuItem<
                                                                String>>((String
                                                            value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  CustomButton(
                                    onPressed: () {},
                                    text: 'Send Contract',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: SizedBox(
                                    width: 137,
                                    height: 45,
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          addContracts = !addContracts;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color:
                                                Color.fromRGBO(98, 84, 84, 1),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              15), // Adjust border radius as needed
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.add,
                                        size: 15,
                                      ),
                                      label: Text('New Contracts',
                                          style: TextStyle(
                                            color:
                                                Color.fromRGBO(98, 84, 84, 1),
                                            fontFamily: 'Helvetica',
                                            fontSize: 11,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Scrollbar(
                                            controller: _ContractScroll,
                                            thumbVisibility:
                                                true, // Set to true to always show the scrollbar
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              controller: _ContractScroll,
                                              child: Container(
                                                height: 340,
                                                width: 1100,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.5), // Adjust the shadow color and opacity
                                                      blurRadius:
                                                          5.0, // Adjust the blur radius for a more visible shadow
                                                    ),
                                                  ],
                                                ),
                                                child: SizedBox(
                                                  height: 220,
                                                  child: ListView(
                                                    children: [
                                                      _createDataTable()
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
                              ],
                            ),
                          ),
                        ),
                      )
              ],
            ),
          );
        }
      });
    });
  }
}
