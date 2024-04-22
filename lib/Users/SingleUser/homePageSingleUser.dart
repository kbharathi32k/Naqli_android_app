// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Users/SingleUser/dashboard_page.dart';
import 'package:naqli_android_app/Users/SuperUser/dashboard_page.dart';
import 'package:naqli_android_app/availableBus.dart';
import 'package:naqli_android_app/availableEquipment.dart';
import 'package:naqli_android_app/availableSpecial.dart';
import 'package:naqli_android_app/availableVehicle.dart';
import 'package:naqli_android_app/classes/language.dart';
import 'package:naqli_android_app/classes/language_constants.dart';
import 'package:naqli_android_app/createAccount.dart';
import 'package:naqli_android_app/main.dart';

import 'package:sizer/sizer.dart';

import '../../Widgets/formText.dart';
import '../../loginPage.dart';

class MyHomePagesingle extends StatefulWidget {
  final String user;
  const MyHomePagesingle({required this.user});

  @override
  State<MyHomePagesingle> createState() => _MyHomePagesingleState();
}

class _MyHomePagesingleState extends State<MyHomePagesingle>
    with SingleTickerProviderStateMixin {
  String _selectedValue = '1';
  String categoryValue = '1';
  String dropdownValues = 'None';
  bool isUserLoggedIn = false;
  late TabController _tabController;
  final ScrollController _Scroll = ScrollController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AllUsersFormController controller = AllUsersFormController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> fetchData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> userData = documentSnapshot.data()!;
        String firstName = userData['firstName'];
        String lastName = userData['lastName'];
        return {'firstName': firstName, 'lastName': lastName};
      } else {
        print('Document does not exist for userId: $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching data for userId $userId: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 680) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(90),
                child: Material(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(13.w, 0, 15.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 12, bottom: 6),
                          child: Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TabBar(
                            overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.transparent;
                              }
                              return Colors.transparent;
                            }),
                            automaticIndicatorColorAdjustment: false,
                            unselectedLabelStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: "HelveticaNeueRegular",
                              color: Color.fromRGBO(206, 203, 203, 1),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: "HelveticaNeueRegular",
                              color: Color.fromRGBO(112, 112, 112, 1),
                            ),
                            dividerHeight: 0,
                            indicatorColor: Colors.transparent,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                text: 'User',
                              ),
                              Tab(
                                text: 'Partner',
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2<Language>(
                                hint: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        translation(context).english,
                                        style: TabelText.helvetica11,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.black,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                ),
                                onChanged: (Language? language) async {
                                  if (language != null) {
                                    Locale _locale =
                                        await setLocale(language.languageCode);
                                    MyApp.setLocale(context, _locale);
                                  } else {
                                    language;
                                  }
                                },
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                        value: e,
                                        child: Text(
                                          e.langname,
                                          style: TabelText.helvetica11,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //  Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: <Widget>[
                                        //     Text(
                                        //       e.flag,
                                        //       style: TabelText.helvetica11,
                                        //       overflow: TextOverflow.ellipsis,
                                        //     ),
                                        //     Text(
                                        //       e.langname,
                                        //       style: TabelText.helvetica11,
                                        //       overflow: TextOverflow.ellipsis,
                                        //     )
                                        //   ],
                                        // ),
                                      ),
                                    )
                                    .toList(),
                                buttonStyleData: ButtonStyleData(
                                  height: 25,
                                  width: 103,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Colors.white,
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                  ),
                                  iconSize: 25,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: null,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 210,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black26),
                                    color: Colors.white,
                                  ),
                                  scrollPadding: EdgeInsets.all(5),
                                  scrollbarTheme: ScrollbarThemeData(
                                    thickness:
                                        MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                        MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 25,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 5,
                              ),
                              child: FutureBuilder<Map<String, dynamic>?>(
                                future: fetchData(widget
                                    .user!), // Pass the userId to fetchData method
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator(); // Show a loading indicator while data is being fetched
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    // Extract first name and last name from snapshot data
                                    String firstName =
                                        snapshot.data?['firstName'] ?? '';
                                    String lastName =
                                        snapshot.data?['lastName'] ?? '';

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Hello $firstName $lastName!",
                                            style: TabelText.helvetica11),
                                        Text("Admin",
                                            style: TabelText.usertext),
                                        Text("Faizal industries",
                                            style: TabelText.usertext),
                                      ],
                                    );
                                  } else {
                                    return Text(
                                        'No data available'); // Handle case when snapshot has no data
                                  }
                                },
                              ),
                            ),
                            Icon(
                              Icons.notifications,
                              color: Color.fromRGBO(106, 102, 209, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      viewportFraction: 1.0,
                                      autoPlayAnimationDuration:
                                          Durations.extralong4,
                                      height: 500,
                                    ),
                                    items: [
                                      Image(
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/truckslide.jpg?alt=media&token=3abaaa7a-3c22-44e3-81d2-d16af7336273'),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 450, right: 200, top: 200),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 310,
                                left: 14.w,
                                right: 14.w,
                                child: Card(
                                  elevation: 4,
                                  shadowColor: Color.fromRGBO(216, 216, 216, 1)
                                      .withOpacity(0.5),
                                  child: Container(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    width: 1250,
                                    height: 350,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)
                                                  .withOpacity(0.1)),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      // Use ListView instead of Column
                                      children: [
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            // Location text
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .location_on_outlined),
                                                  SizedBox(width: 5),
                                                  Container(
                                                    height: 30,
                                                    width: 1,
                                                    color: Colors.black,
                                                  ),
                                                  SizedBox(width: 5),
                                                  // SizedBox(
                                                  //   height: 200,
                                                  //   width: 200,
                                                  //   child: OpenStreetMapSearchAndPick(
                                                  //       buttonColor: Colors.blue,
                                                  //       buttonText:
                                                  //           'Set Current Location',
                                                  //       onPicked: (pickedData) {}),
                                                  // )
                                                  // Replace the below DropdownButton with your actual dropdown widget
                                                  DropdownButtonHideUnderline(
                                                    child:
                                                        DropdownButton<String>(
                                                      value: 'Location',
                                                      onChanged:
                                                          (String? newValue) {
                                                        // Handle dropdown value change
                                                      },
                                                      items: <String>[
                                                        'Location',
                                                        'Location1',
                                                        'Location2'
                                                      ].map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(
                                                              value,
                                                              style: HomepageText
                                                                  .helvetica16black,
                                                            ),
                                                          );
                                                        },
                                                      ).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
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
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AvailableVehicle(
                                                                user:
                                                                    widget.user,
                                                              )),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 5.5,
                                                    shadowColor: Color.fromRGBO(
                                                            216, 216, 216, 1)
                                                        .withOpacity(0.6),
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            247, 246, 255, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.network(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group68.png?alt=media&token=5fe75cdd-40f3-48ff-9838-dfadcaf41ae4',
                                                              width: 150,
                                                              height: 139,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text('Vehicle',
                                                                style: HomepageText
                                                                    .helvetica16black),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AvailableBus(
                                                                user:
                                                                    widget.user,
                                                              )),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 5.5,
                                                    shadowColor: Color.fromRGBO(
                                                            216, 216, 216, 1)
                                                        .withOpacity(0.6),
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            247, 246, 255, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.network(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bus.png?alt=media&token=62ffdc20-210e-447e-a0e5-51e14b06b449',
                                                              width: 150,
                                                              height: 139,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'Bus',
                                                              style: HomepageText
                                                                  .helvetica16black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AvailableEquipment(
                                                                user:
                                                                    widget.user,
                                                              )),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 5.5,
                                                    shadowColor: Color.fromRGBO(
                                                            216, 216, 216, 1)
                                                        .withOpacity(0.6),
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            247, 246, 255, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.network(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1496.png?alt=media&token=68985bbe-ba8a-4cd3-b4c9-b5f07ab7f3a5',
                                                              width: 150,
                                                              height: 139,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'Equipment-2',
                                                              style: HomepageText
                                                                  .helvetica16black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AvailableSpecial(
                                                                user:
                                                                    widget.user,
                                                              )),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 5.5,
                                                    shadowColor: Color.fromRGBO(
                                                            216, 216, 216, 1)
                                                        .withOpacity(0.6),
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            247, 246, 255, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.network(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1660.png?alt=media&token=e1bdac76-bbdc-4d25-9003-665b2b936a99',
                                                              width: 150,
                                                              height: 139,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'Special',
                                                              style: HomepageText
                                                                  .helvetica16black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AvailableSpecial(
                                                                user:
                                                                    widget.user,
                                                              )),
                                                    );
                                                  },
                                                  child: Card(
                                                    elevation: 5.5,
                                                    shadowColor: Color.fromRGBO(
                                                            216, 216, 216, 1)
                                                        .withOpacity(0.6),
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        color: Color.fromRGBO(
                                                            247, 246, 255, 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.network(
                                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1716.png?alt=media&token=416db349-0c72-4bbe-b160-74792ba49f6e',
                                                              width: 150,
                                                              height: 139,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            SizedBox(height: 2),
                                                            Text(
                                                              'Others',
                                                              style: HomepageText
                                                                  .helvetica16black,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Card(
                                                  elevation: 5.5,
                                                  shadowColor: Color.fromRGBO(
                                                          216, 216, 216, 1)
                                                      .withOpacity(0.6),
                                                  child: Container(
                                                    width: 200,
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          Color.fromRGBO(
                                                              96, 105, 255, 1),
                                                          Color.fromRGBO(
                                                              123, 107, 247, 1),
                                                        ],
                                                      ), // RGB color fill
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              // Check if user is logged in
                                                              if (isUserLoggedIn) {
                                                                UserCredential
                                                                    userCredential =
                                                                    await _auth
                                                                        .signInWithEmailAndPassword(
                                                                  email: controller
                                                                      .email
                                                                      .text
                                                                      .trim(), // Trim to remove whitespace
                                                                  password:
                                                                      controller
                                                                          .password
                                                                          .text,
                                                                );
                                                                // Navigate to dashboard
                                                                // Navigator.push(
                                                                //   context,
                                                                //   MaterialPageRoute(
                                                                //       builder: (context) =>
                                                                //           SingleUserDashboardPage(
                                                                //               user:user)),
                                                                // );
                                                              } else {
                                                                // Navigate to login page
                                                                showDialog(
                                                                  barrierColor: Color
                                                                          .fromRGBO(
                                                                              59,
                                                                              57,
                                                                              57,
                                                                              1)
                                                                      .withOpacity(
                                                                          0.5),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              50),
                                                                      child:
                                                                          AvailableVehicle(
                                                                        user: widget
                                                                            .user,
                                                                      ),
                                                                    );
                                                                  },
                                                                );
                                                              }
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  "Get an Estimate",
                                                                  style: HomepageText
                                                                      .helvetica16bold,
                                                                ),
                                                                SizedBox(
                                                                    height: 20),
                                                                Image.network(
                                                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/right-arrow.png?alt=media&token=cba6795c-11eb-449b-8a9a-ac790bf408f5',
                                                                  width: 30,
                                                                  height: 30,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ],
                                                            ),
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
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(child: CreateAccount())
                ],
              ));
        } else {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(65),
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5.w, 0, 8.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PopupMenuButton<String>(
                          icon: Icon(Icons.menu),
                          onSelected: (String value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              value: '1',
                              child: Text('User', style: TabelText.tableText),
                            ),
                            PopupMenuItem(
                              value: '2',
                              child:
                                  Text('Partner', style: TabelText.tableText),
                            ),
                            PopupMenuItem(
                              value: '3',
                              child: Text("Contact Us",
                                  style: TabelText.tableText),
                            ),
                            PopupMenuItem(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<Language>(
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          translation(context).english,
                                          style: TabelText.helvetica11,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  ),
                                  onChanged: (Language? language) async {
                                    if (language != null) {
                                      Locale _locale = await setLocale(
                                          language.languageCode);
                                      MyApp.setLocale(context, _locale);
                                    } else {
                                      language;
                                    }
                                  },
                                  items: Language.languageList()
                                      .map<DropdownMenuItem<Language>>(
                                        (e) => DropdownMenuItem<Language>(
                                          value: e,
                                          child: Text(
                                            e.langname,
                                            style: TabelText.helvetica11,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          //  Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceAround,
                                          //   children: <Widget>[
                                          //     Text(
                                          //       e.flag,
                                          //       style: TabelText.helvetica11,
                                          //       overflow: TextOverflow.ellipsis,
                                          //     ),
                                          //     Text(
                                          //       e.langname,
                                          //       style: TabelText.helvetica11,
                                          //       overflow: TextOverflow.ellipsis,
                                          //     )
                                          //   ],
                                          // ),
                                        ),
                                      )
                                      .toList(),
                                  buttonStyleData: ButtonStyleData(
                                    height: 25,
                                    width: 103,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                  ),
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down_sharp,
                                    ),
                                    iconSize: 25,
                                    iconEnabledColor: Colors.white,
                                    iconDisabledColor: null,
                                  ),
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: 210,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.black26),
                                      color: Colors.white,
                                    ),
                                    scrollPadding: EdgeInsets.all(5),
                                    scrollbarTheme: ScrollbarThemeData(
                                      thickness:
                                          MaterialStateProperty.all<double>(6),
                                      thumbVisibility:
                                          MaterialStateProperty.all<bool>(true),
                                    ),
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return LoginPage();
                                  },
                                );
                              },
                              child: Text('Log in', style: TabelText.helvetica),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.notifications,
                              color: Color.fromRGBO(106, 102, 209, 1),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 500,
                            ),
                            items: [
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/truckslide.jpg?alt=media&token=3abaaa7a-3c22-44e3-81d2-d16af7336273'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/truckslide.jpg?alt=media&token=3abaaa7a-3c22-44e3-81d2-d16af7336273'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 355,
                            width: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Positioned(
                        top: 310,
                        left: 15.w,
                        right: 15.w,
                        child: Card(
                          elevation: 4,
                          shadowColor:
                              Color.fromRGBO(216, 216, 216, 1).withOpacity(0.5),
                          child: Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            width: 300,
                            height: 550,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              // Use ListView instead of Column
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Location text
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          SizedBox(width: 5),
                                          Container(
                                            height: 30,
                                            width: 1,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5),
                                          // Replace the below DropdownButton with your actual dropdown widget
                                          DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              value: 'Location',
                                              onChanged: (String? newValue) {
                                                // Handle dropdown value change
                                              },
                                              items: <String>[
                                                'Location',
                                                'Location1',
                                                'Location2'
                                              ].map<DropdownMenuItem<String>>(
                                                (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: HomepageText
                                                          .helvetica16black,
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 300,
                                  height: 450,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableVehicle(
                                                        user: '',
                                                      )),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5.5,
                                            shadowColor:
                                                Color.fromRGBO(216, 216, 216, 1)
                                                    .withOpacity(0.6),
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 246, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group68.png?alt=media&token=5fe75cdd-40f3-48ff-9838-dfadcaf41ae4',
                                                      width: 150,
                                                      height: 139,
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text('Vehicle',
                                                        style: HomepageText
                                                            .helvetica16black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableBus(
                                                        user: widget.user,
                                                      )),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5.5,
                                            shadowColor:
                                                Color.fromRGBO(216, 216, 216, 1)
                                                    .withOpacity(0.6),
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 246, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bus.png?alt=media&token=62ffdc20-210e-447e-a0e5-51e14b06b449',
                                                      width: 150,
                                                      height: 139,
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text('Bus',
                                                        style: HomepageText
                                                            .helvetica16black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableEquipment(
                                                        user: widget.user,
                                                      )),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5.5,
                                            shadowColor:
                                                Color.fromRGBO(216, 216, 216, 1)
                                                    .withOpacity(0.6),
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 246, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1496.png?alt=media&token=68985bbe-ba8a-4cd3-b4c9-b5f07ab7f3a5',
                                                      width: 150,
                                                      height: 139,
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text('Equipment-2',
                                                        style: HomepageText
                                                            .helvetica16black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableSpecial(
                                                        user: widget.user,
                                                      )),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5.5,
                                            shadowColor:
                                                Color.fromRGBO(216, 216, 216, 1)
                                                    .withOpacity(0.6),
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 246, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1660.png?alt=media&token=e1bdac76-bbdc-4d25-9003-665b2b936a99',
                                                      width: 150,
                                                      height: 139,
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text('Special',
                                                        style: HomepageText
                                                            .helvetica16black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AvailableSpecial(
                                                        user: widget.user,
                                                      )),
                                            );
                                          },
                                          child: Card(
                                            elevation: 5.5,
                                            shadowColor:
                                                Color.fromRGBO(216, 216, 216, 1)
                                                    .withOpacity(0.6),
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(
                                                    247, 246, 255, 1),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Image.network(
                                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1716.png?alt=media&token=416db349-0c72-4bbe-b160-74792ba49f6e',
                                                      width: 150,
                                                      height: 139,
                                                    ),
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(height: 2),
                                                    Text('Others',
                                                        style: HomepageText
                                                            .helvetica16black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Card(
                                          elevation: 5.5,
                                          shadowColor:
                                              Color.fromRGBO(216, 216, 216, 1)
                                                  .withOpacity(0.6),
                                          child: Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),

                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                                colors: [
                                                  Color.fromRGBO(
                                                      96, 105, 255, 1),
                                                  Color.fromRGBO(
                                                      123, 107, 247, 1),
                                                ],
                                              ), // // RGB color fill
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("Get an Estimate",
                                                      style: HomepageText
                                                          .helvetica16bold),
                                                  SizedBox(height: 20),
                                                  Image.network(
                                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/right-arrow.png?alt=media&token=cba6795c-11eb-449b-8a9a-ac790bf408f5',
                                                    width: 30,
                                                    height: 30,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        }
      });
    });
  }
}
