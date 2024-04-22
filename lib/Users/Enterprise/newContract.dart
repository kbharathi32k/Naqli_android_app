import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

class NewContracts extends StatefulWidget {
  NewContracts();
  @override
  State<NewContracts> createState() => _PaymentsState();
}

class _PaymentsState extends State<NewContracts> {
  String selectedValue1 = 'Option A';
  String selectedValue2 = 'Option B';
  String selectedValue3 = 'Option C';
  String? selectedCity;
  String? selectedType;
  String? selectedOption;
  List<String> cities = ['City 1', 'City 2', 'City 3', 'City 4'];

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 850) {
          return Container(
            height: 67.h,
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
                    color: Color.fromRGBO(106, 102, 209, 1),
                    border: Border.all(
                      width: 1.0,
                      color: Color.fromRGBO(106, 102, 209, 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 60, top: 25),
                    child: Text(
                      "New Contracts",
                      style: TextStyle(
                          fontFamily: "Helvetica",
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                ),
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
                      Container(
                        height: 340,
                        width: 1000,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
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
                              padding: const EdgeInsets.only(left: 48),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Mode",
                                    style: TextStyle(
                                        fontFamily: "SFProText-Regular",
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "From",
                                    style: TextStyle(
                                        fontFamily: "SFProText-Regular",
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        fontFamily: "SFProText-Regular",
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 160,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    value: selectedCity,

                                    // Set initial value to the first element
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                    },
                                    items: cities.map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
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
                                      hintStyle: TextStyle(fontSize: 16),
                                      hintText: 'DD/MM/YYYY',
                                      contentPadding:
                                          EdgeInsets.only(left: 30, top: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 160,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 16),
                                      hintText: 'DD/MM/YYYY',
                                      contentPadding:
                                          EdgeInsets.only(left: 30, top: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
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
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(5.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                          ),
                                          value: selectedCity,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedCity = newValue;
                                            });
                                          },
                                          items: cities
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
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
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 50),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color.fromRGBO(9, 78, 37, 1),

                                              // You can change the background color here
                                              radius: 10,
                                              child: Text(
                                                'A',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors
                                                      .white, // You can change the text color here
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Dash(
                                                  direction: Axis.vertical,
                                                  length: 70,
                                                  dashLength: 10,
                                                  dashColor: Color.fromRGBO(
                                                      112, 112, 112, 1)),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Color.fromRGBO(
                                                  147, 10, 26, 1),

                                              // You can change the background color here
                                              radius: 10,
                                              child: Text(
                                                'B',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
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
                                        padding: const EdgeInsets.only(top: 28),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 45,
                                              width: 250,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintStyle:
                                                      TextStyle(fontSize: 16),
                                                  hintText:
                                                      'Enter your location',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 50, top: 20),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
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
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintStyle:
                                                      TextStyle(fontSize: 16),
                                                  hintText:
                                                      'Enter your location',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 50, top: 20),
                                                  border: OutlineInputBorder(
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
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 140,
                                              child: VerticalDivider(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        value: selectedCity,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        value: selectedCity ?? cities.first,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        value: selectedCity ?? cities.first,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
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
          );
        } else {
          return Container(
            height: 67.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.1.w, 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 1250,
                  height: 92,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(106, 102, 209, 1),
                    border: Border.all(
                      width: 1.0,
                      color: Color.fromRGBO(106, 102, 209, 1),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 60, top: 25),
                    child: Text(
                      "New Contracts",
                      style: TextStyle(
                          fontFamily: "Helvetica",
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                ),
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
                      Container(
                        height: 340,
                        width: 1000,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
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
                              padding: const EdgeInsets.only(left: 48),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Mode",
                                    style: TextStyle(
                                        fontFamily: "SFProText-Regular",
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "From",
                                    style: TextStyle(
                                        fontFamily: "SFProText-Regular",
                                        fontSize: 17),
                                  ),
                                  Text(
                                    "To",
                                    style: TextStyle(
                                        fontFamily: "SFProText-Regular",
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 45,
                                  width: 160,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(5.0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                    value: selectedCity,

                                    // Set initial value to the first element
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                    },
                                    items: cities.map<DropdownMenuItem<String>>(
                                      (String value) {
                                        return DropdownMenuItem<String>(
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
                                      hintStyle: TextStyle(fontSize: 16),
                                      hintText: 'DD/MM/YYYY',
                                      contentPadding:
                                          EdgeInsets.only(left: 30, top: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 160,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 16),
                                      hintText: 'DD/MM/YYYY',
                                      contentPadding:
                                          EdgeInsets.only(left: 30, top: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
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
                                        child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(5.0),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                            ),
                                          ),
                                          value: selectedCity,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedCity = newValue;
                                            });
                                          },
                                          items: cities
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
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
                                        padding: const EdgeInsets.only(
                                            top: 30, left: 50),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color.fromRGBO(9, 78, 37, 1),

                                              // You can change the background color here
                                              radius: 10,
                                              child: Text(
                                                'A',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors
                                                      .white, // You can change the text color here
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Dash(
                                                  direction: Axis.vertical,
                                                  length: 70,
                                                  dashLength: 10,
                                                  dashColor: Color.fromRGBO(
                                                      112, 112, 112, 1)),
                                            ),
                                            CircleAvatar(
                                              backgroundColor: Color.fromRGBO(
                                                  147, 10, 26, 1),

                                              // You can change the background color here
                                              radius: 10,
                                              child: Text(
                                                'B',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
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
                                        padding: const EdgeInsets.only(top: 28),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 45,
                                              width: 250,
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintStyle:
                                                      TextStyle(fontSize: 16),
                                                  hintText:
                                                      'Enter your location',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 50, top: 20),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
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
                                              child: TextFormField(
                                                decoration: InputDecoration(
                                                  hintStyle:
                                                      TextStyle(fontSize: 16),
                                                  hintText:
                                                      'Enter your location',
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 50, top: 20),
                                                  border: OutlineInputBorder(
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
                                      ),
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 140,
                                              child: VerticalDivider(
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        value: selectedCity,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        value: selectedCity ?? cities.first,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
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
                                      child: DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(5.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                        ),
                                        value: selectedCity ?? cities.first,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedCity = newValue;
                                          });
                                        },
                                        items: cities
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
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
          );
        }
      });
    });
  }
}
