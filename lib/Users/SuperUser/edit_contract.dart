import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:sizer/sizer.dart';

class EditContract extends StatefulWidget {
  EditContract();
  @override
  State<EditContract> createState() => _EditContractState();
}

class _EditContractState extends State<EditContract> {
  String selectedValue1 = 'Option A';
  String selectedValue2 = 'Option B';
  String selectedValue3 = 'Option C';
  bool value = false;
  bool checkbox1 = false;
  int? groupValue = 1;
  String? selectedCity;
  String? selectedType;
  String? selectedOption;
  List<String> cities = ['City 1', 'City 2', 'City 3', 'City 4'];
  final ScrollController _Scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 850) {
          return Padding(
            padding: EdgeInsets.fromLTRB(9.w, 6.h, 9.w, 6.h),
            child: Dialog(
              child: Container(
                height: 606,
                width: 1163,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromRGBO(255, 255, 255, 0.925),
                ),
                // padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 1163,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(98, 105, 254, 1),
                        border: Border.all(
                          width: 1.0,
                          color: Color.fromRGBO(98, 105, 254, 1),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 10), // Adjust padding as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontFamily: "Helvetica",
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5',
                              width: 20,
                              height: 25,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Scrollbar(
                              controller: _Scroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _Scroll,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group68.png?alt=media&token=5fe75cdd-40f3-48ff-9838-dfadcaf41ae4',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Text('Vehicle',
                                                  style: HomepageText
                                                      .helvetica16black1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bus.png?alt=media&token=62ffdc20-210e-447e-a0e5-51e14b06b449',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Bus',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1496.png?alt=media&token=68985bbe-ba8a-4cd3-b4c9-b5f07ab7f3a5',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Equipment-2',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1660.png?alt=media&token=e1bdac76-bbdc-4d25-9003-665b2b936a99',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Special',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1716.png?alt=media&token=416db349-0c72-4bbe-b160-74792ba49f6e',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Others',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 100,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  30), // Adjust spacing as needed
                                          child: Row(
                                            children: [
                                              Text(
                                                "Mode",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "SFProText-Regular",
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 160,
                                                child: DropdownButtonFormField(
                                                  elevation: 1,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                    ),
                                                  ),
                                                  value: selectedCity,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedCity = newValue;
                                                    });
                                                  },
                                                  items: cities.map<
                                                      DropdownMenuItem<String>>(
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  40), // Adjust spacing as needed
                                          child: Row(
                                            children: [
                                              Text(
                                                "From",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "SFProText-Regular",
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 160,
                                                child: Material(
                                                  elevation: 1,
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      hintStyle: TextStyle(
                                                          fontSize: 17,
                                                          fontFamily:
                                                              "Helvetica",
                                                          color: Color.fromRGBO(
                                                              3, 2, 2, 0.3)),
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
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 80),
                                          child: SizedBox(
                                            height: 30,
                                            child: Dash(
                                                direction: Axis.vertical,
                                                length: 30,
                                                dashLength: 5,
                                                dashColor: Color.fromRGBO(
                                                    112, 112, 112, 0.5)),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "To",
                                              style: TextStyle(
                                                fontFamily: "SFProText-Regular",
                                                fontSize: 17,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 70,
                                            ),
                                            SizedBox(
                                              height: 45,
                                              width: 160,
                                              child: Material(
                                                elevation: 1,
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: "Helvetica",
                                                        color: Color.fromRGBO(
                                                            3, 2, 2, 0.3)),
                                                    hintText: 'DD/MM/YYYY',
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 30, top: 20),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 45,
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
                                                elevation: 1,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(5.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                ),
                                                value: selectedCity,
                                                onChanged: (String? newValue) {
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
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
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
                                                        Color.fromRGBO(
                                                            9, 78, 37, 1),

                                                    // You can change the background color here
                                                    radius: 10,
                                                    child: Text(
                                                      'A',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .white, // You can change the text color here
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Dash(
                                                        direction:
                                                            Axis.vertical,
                                                        length: 70,
                                                        dashLength: 10,
                                                        dashColor:
                                                            Color.fromRGBO(112,
                                                                112, 112, 0.5)),
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            147, 10, 26, 1),

                                                    // You can change the background color here
                                                    radius: 10,
                                                    child: Text(
                                                      'B',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              padding: const EdgeInsets.only(
                                                  top: 28),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 45,
                                                    width: 250,
                                                    child: Material(
                                                      elevation: 1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintStyle: TextStyle(
                                                              fontSize: 17,
                                                              fontFamily:
                                                                  "Helvetica",
                                                              color: Color
                                                                  .fromRGBO(
                                                                      3,
                                                                      2,
                                                                      2,
                                                                      0.3)),
                                                          hintText:
                                                              'Enter your location',
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 50,
                                                                  top: 20),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                  SizedBox(
                                                    height: 45,
                                                    width: 250,
                                                    child: Material(
                                                      elevation: 1,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: TextFormField(
                                                        decoration:
                                                            InputDecoration(
                                                          hintStyle: TextStyle(
                                                              fontSize: 17,
                                                              fontFamily:
                                                                  "Helvetica",
                                                              color: Color
                                                                  .fromRGBO(
                                                                      3,
                                                                      2,
                                                                      2,
                                                                      0.3)),
                                                          hintText:
                                                              'Enter your location',
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 50,
                                                                  top: 20),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15)),
                                                          ),
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
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 220,
                                          child: VerticalDivider(
                                            color: Color.fromRGBO(
                                                112, 112, 112, 0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, bottom: 30),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value: checkbox1,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      checkbox1 = newValue!;
                                                      if (!checkbox1) {
                                                        groupValue =
                                                            null; // Disable all radio buttons
                                                      }
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Need Additional Labour',
                                                  style: AvailableText
                                                      .helveticablack,
                                                ),
                                                for (int i = 1; i <= 3; i++)
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Radio<int?>(
                                                          splashRadius: 5,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .selected)) {
                                                              return Color
                                                                  .fromRGBO(
                                                                      183,
                                                                      183,
                                                                      183,
                                                                      1);
                                                            }
                                                            return Color
                                                                .fromRGBO(
                                                                    208,
                                                                    205,
                                                                    205,
                                                                    1);
                                                          }),
                                                          hoverColor:
                                                              Color.fromRGBO(
                                                                      183,
                                                                      183,
                                                                      183,
                                                                      1)
                                                                  .withOpacity(
                                                                      .8),
                                                          value: i,
                                                          groupValue: checkbox1
                                                              ? groupValue
                                                              : null, // Enable/disable based on checkbox state
                                                          onChanged: checkbox1
                                                              ? (int? value) {
                                                                  setState(() {
                                                                    groupValue =
                                                                        value;
                                                                  });
                                                                }
                                                              : null, // Set onChanged to null if checkbox is unchecked
                                                        ),
                                                      ),
                                                      Text(
                                                        '$i',
                                                        style: AvailableText
                                                            .helveticablack,
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 40),
                          child: CustomButton1(
                            onPressed: () {},
                            text: 'Save',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.fromLTRB(9.w, 6.h, 9.w, 6.h),
            child: Dialog(
              child: Container(
                height: 606,
                width: 1163,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color.fromRGBO(255, 255, 255, 0.925),
                ),
                // padding: EdgeInsets.fromLTRB(3.w, 3.h, 3.w, 3.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 1163,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(98, 105, 254, 1),
                        border: Border.all(
                          width: 1.0,
                          color: Color.fromRGBO(98, 105, 254, 1),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10), // Adjust padding as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit",
                              style: TextStyle(
                                fontFamily: "Helvetica",
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                            Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5',
                              width: 20,
                              height: 25,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Scrollbar(
                              controller: _Scroll,
                              thumbVisibility:
                                  true, // Set to true to always show the scrollbar
                              child: SingleChildScrollView(
                                controller: _Scroll,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group68.png?alt=media&token=5fe75cdd-40f3-48ff-9838-dfadcaf41ae4',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              Text('Vehicle',
                                                  style: HomepageText
                                                      .helvetica16black1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bus.png?alt=media&token=62ffdc20-210e-447e-a0e5-51e14b06b449',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Bus',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1496.png?alt=media&token=68985bbe-ba8a-4cd3-b4c9-b5f07ab7f3a5',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Equipment-2',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1660.png?alt=media&token=e1bdac76-bbdc-4d25-9003-665b2b936a99',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Special',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Card(
                                      elevation: 5.5,
                                      shadowColor:
                                          Color.fromRGBO(216, 216, 216, 1)
                                              .withOpacity(0.6),
                                      child: Container(
                                        width: 92,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromRGBO(247, 246, 255, 1),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1716.png?alt=media&token=416db349-0c72-4bbe-b160-74792ba49f6e',
                                                width: 59,
                                                height: 41,
                                              ),
                                              Divider(
                                                color: Colors.black,
                                              ),
                                              SizedBox(height: 2),
                                              Text(
                                                'Others',
                                                style: HomepageText
                                                    .helvetica16black1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 100,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  30), // Adjust spacing as needed
                                          child: Row(
                                            children: [
                                              Text(
                                                "Mode",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "SFProText-Regular",
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 160,
                                                child: DropdownButtonFormField(
                                                  elevation: 1,
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.all(5.0),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15)),
                                                    ),
                                                  ),
                                                  value: selectedCity,
                                                  onChanged:
                                                      (String? newValue) {
                                                    setState(() {
                                                      selectedCity = newValue;
                                                    });
                                                  },
                                                  items: cities.map<
                                                      DropdownMenuItem<String>>(
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
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  50), // Adjust spacing as needed
                                          child: Row(
                                            children: [
                                              Text(
                                                "From",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "SFProText-Regular",
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 160,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: "Helvetica",
                                                        color: Color.fromRGBO(
                                                            3, 2, 2, 0.3)),
                                                    hintText: 'DD/MM/YYYY',
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 30, top: 20),
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
                                        Dash(
                                            direction: Axis.vertical,
                                            length: 30,
                                            dashLength: 10,
                                            dashColor: Color.fromRGBO(
                                                112, 112, 112, 0.5)),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  40), // Adjust spacing as needed
                                          child: Row(
                                            children: [
                                              Text(
                                                "To",
                                                style: TextStyle(
                                                  fontFamily:
                                                      "SFProText-Regular",
                                                  fontSize: 17,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 70,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                width: 160,
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                        fontSize: 17,
                                                        fontFamily: "Helvetica",
                                                        color: Color.fromRGBO(
                                                            3, 2, 2, 0.3)),
                                                    hintText: 'DD/MM/YYYY',
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 30, top: 20),
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
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 30),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 45,
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
                                                elevation: 1,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(5.0),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                ),
                                                value: selectedCity,
                                                onChanged: (String? newValue) {
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
                                                }).toList(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
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
                                                        Color.fromRGBO(
                                                            9, 78, 37, 1),

                                                    // You can change the background color here
                                                    radius: 10,
                                                    child: Text(
                                                      'A',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors
                                                            .white, // You can change the text color here
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Dash(
                                                        direction:
                                                            Axis.vertical,
                                                        length: 70,
                                                        dashLength: 10,
                                                        dashColor:
                                                            Color.fromRGBO(112,
                                                                112, 112, 0.5)),
                                                  ),
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        Color.fromRGBO(
                                                            147, 10, 26, 1),

                                                    // You can change the background color here
                                                    radius: 10,
                                                    child: Text(
                                                      'B',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                              padding: const EdgeInsets.only(
                                                  top: 28),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 45,
                                                    width: 250,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize: 17,
                                                            fontFamily:
                                                                "Helvetica",
                                                            color:
                                                                Color.fromRGBO(
                                                                    3,
                                                                    2,
                                                                    2,
                                                                    0.3)),
                                                        hintText:
                                                            'Enter your location',
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 50,
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
                                                    height: 40,
                                                  ),
                                                  SizedBox(
                                                    height: 45,
                                                    width: 250,
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        hintStyle: TextStyle(
                                                            fontSize: 17,
                                                            fontFamily:
                                                                "Helvetica",
                                                            color:
                                                                Color.fromRGBO(
                                                                    3,
                                                                    2,
                                                                    2,
                                                                    0.3)),
                                                        hintText:
                                                            'Enter your location',
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                left: 50,
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
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 220,
                                          child: VerticalDivider(
                                            color: Color.fromRGBO(
                                                112, 112, 112, 0.5),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, bottom: 30),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Checkbox(
                                                  value: checkbox1,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {
                                                      checkbox1 = newValue!;
                                                      if (!checkbox1) {
                                                        groupValue =
                                                            null; // Disable all radio buttons
                                                      }
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  'Need Additional Labour',
                                                  style: AvailableText
                                                      .helveticablack,
                                                ),
                                                for (int i = 1; i <= 3; i++)
                                                  Row(
                                                    children: [
                                                      Transform.scale(
                                                        scale: 0.7,
                                                        child: Radio<int?>(
                                                          splashRadius: 5,
                                                          fillColor:
                                                              MaterialStateProperty
                                                                  .resolveWith(
                                                                      (states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .selected)) {
                                                              return Color
                                                                  .fromRGBO(
                                                                      183,
                                                                      183,
                                                                      183,
                                                                      1);
                                                            }
                                                            return Color
                                                                .fromRGBO(
                                                                    208,
                                                                    205,
                                                                    205,
                                                                    1);
                                                          }),
                                                          hoverColor:
                                                              Color.fromRGBO(
                                                                      183,
                                                                      183,
                                                                      183,
                                                                      1)
                                                                  .withOpacity(
                                                                      .8),
                                                          value: i,
                                                          groupValue: checkbox1
                                                              ? groupValue
                                                              : null, // Enable/disable based on checkbox state
                                                          onChanged: checkbox1
                                                              ? (int? value) {
                                                                  setState(() {
                                                                    groupValue =
                                                                        value;
                                                                  });
                                                                }
                                                              : null, // Set onChanged to null if checkbox is unchecked
                                                        ),
                                                      ),
                                                      Text(
                                                        '$i',
                                                        style: AvailableText
                                                            .helveticablack,
                                                      ),
                                                    ],
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20, top: 40),
                          child: CustomButton1(
                            onPressed: () {},
                            text: 'Save',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      });
    });
  }
}
