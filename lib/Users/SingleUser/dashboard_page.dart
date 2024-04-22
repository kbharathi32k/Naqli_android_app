import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/DialogBox/bookingdialog.dart';

import 'package:sizer/sizer.dart';
import '../../Widgets/customButton.dart';
import '../../Widgets/formText.dart';
import '../../classes/language.dart';
import '../../classes/language_constants.dart';
import '../../main.dart';
import 'package:naqli_android_app/Users/SingleUser/bookingHistory.dart';
import 'package:naqli_android_app/Users/SingleUser/bookings.dart';
import 'package:naqli_android_app/Users/SingleUser/payments.dart';

class SingleUserDashboardPage extends StatefulWidget {
  final String? user;
  final String? bookingId;
  final String? unitType;
  const SingleUserDashboardPage(
      {required this.user, this.unitType, this.bookingId});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SingleUserDashboardPage> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
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
  late Widget _currentContent;

  Future<Map<String, dynamic>?> fetchData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> userData = documentSnapshot.data()!;

        String address = userData['address'] ?? '';
        String firstName = userData['firstName'] ?? '';
        String lastName = userData['lastName'] ?? '';
        String userId = userData['userId'] ?? '';
        return {
          'firstName': firstName,
          'lastName': lastName,
          'address': address,
          'userId': userId
        };
      } else {
        print('Document does not exist for userId: $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching data for userId $userId: $e');
      return null;
    }
  }

  void _handleItem1Tap() {
    setState(() {
      _currentContent = Bookings(
        unitType: widget.unitType,
        user: widget.user,
        bookingId: widget.bookingId,
      );
      print('${widget.bookingId}');
    });
    Navigator.pop(context);
  }

  void _handleItem2Tap() {
    setState(() {
      _currentContent = BookingHistroy(
        user: widget.user,
      );
    });
    Navigator.pop(context);
  }

  void _handleItem3Tap() {
    setState(() {
      _currentContent = SingleUserPayment(
        unitType: widget.unitType,
        user: widget.user,
      );
    });
    Navigator.pop(context);
  }

  void _handleItem4Tap() {
    setState(() {
      _currentContent = SingleUserPayment(
        user: widget.user,
        unitType: widget.unitType,
      );
    });
    Navigator.pop(context);
  }

  void _handleItem5Tap() {
    setState(() {
      _currentContent = BookingHistroy(
        user: widget.user,
      );
    });
    Navigator.pop(context);
  }

  void handleRadioValueChanged(String? newValue) {
    setState(() {
      selectedValue = newValue;
    });
    print('Selected value: $selectedValue');
  }

  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
    _currentContent = Bookings(
      unitType: widget.unitType,
      user: widget.user,
      bookingId: widget.bookingId,
    );
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

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 850) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: Material(
                elevation: 3,
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
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // Handle the first button press
                            },
                            child: Text(
                              'User',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "HelveticaNeueRegular",
                                color: Color.fromRGBO(112, 112, 112, 1),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Color.fromRGBO(206, 203, 203, 1),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Handle the third button press
                            },
                            child: Text(
                              'Partner',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "HelveticaNeueRegular",
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
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

                                  return Row(
                                    children: [
                                      Icon(
                                        Icons.notifications,
                                        color: Color.fromRGBO(106, 102, 209, 1),
                                      ),
                                      SizedBox(
                                        width: 0.5.w,
                                      ),
                                      Text("Contact Us ",
                                          style: HomepageText.helvetica16black),
                                      SizedBox(
                                        height: 30,
                                        child: VerticalDivider(
                                          color: Colors.black,
                                        ),
                                      ),
                                      widget.user != null
                                          ? Text("Hello $firstName!",
                                              style:
                                                  HomepageText.helvetica16black)
                                          : Text("Hello Customer!",
                                              style: HomepageText
                                                  .helvetica16black),
                                    ],
                                  );
                                } else {
                                  return Text(
                                      'No data available'); // Handle case when snapshot has no data
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 4.h),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.1),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 199, 198, 198).withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset(0, 0), // Bottom side shadow
                    ),
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
                      blurRadius: 1,
                      spreadRadius: 0, // Bottom side shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(3),
                  color: Color.fromRGBO(247, 246, 255, 1).withOpacity(1),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 850,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                        color: Color.fromRGBO(236, 233, 250, 1),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 330,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Circleavatar.png?alt=media&token=1204cc77-6756-42ab-ba0e-3946a3fe6c9f',
                                ),
                              ),
                              // color: Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
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
                                  String address =
                                      snapshot.data?['address'] ?? '';
                                  String userId =
                                      snapshot.data?['userId'] ?? '';

                                  return Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("$firstName $lastName",
                                          style: DashboardText.acre),
                                      Text('$address',
                                          style: DashboardText.sfpro19),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundColor:
                                            Color.fromRGBO(127, 106, 255, 1),
                                        maxRadius: 76,
                                        minRadius: 72,
                                        child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            maxRadius: 70,
                                            minRadius: 67,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/uploadimage.png?alt=media&token=1793876b-63ca-4730-831b-4fcf4e96da0a'),
                                              maxRadius: 65,
                                              minRadius: 65,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('ID No : $userId',
                                          style: DashboardText.sfpro12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b',
                                                width: 16,
                                                height: 16,
                                              )),
                                          Text('Edit Profile',
                                              style:
                                                  DashboardText.sfpro12black),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                } else {
                                  return Text(
                                      'No data available'); // Handle case when snapshot has no data
                                }
                              },
                            ),
                          ),
                          Container(
                            height: 35.h,
                            padding: EdgeInsets.only(left: 1.5.w, top: 50),
                            child: SideMenu(
                              controller: sideMenu,
                              style: SideMenuStyle(
                                // displayMode: SideMenuDisplayMode.auto,
                                selectedColor: Color.fromRGBO(98, 105, 254, 1),
                                unselectedTitleTextStyle: const TextStyle(
                                  fontFamily: 'SFProText',
                                  fontSize: 18,
                                  color: Color.fromRGBO(128, 118, 118, 1),
                                ),
                                selectedTitleTextStyle: const TextStyle(
                                  fontFamily: 'SFProText',
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                unselectedIconColor:
                                    Color.fromRGBO(128, 118, 118, 1),
                                selectedIconColor: Colors.white,
                              ),
                              items: [
                                SideMenuItem(
                                  title: 'Booking',
                                  onTap: (page, _) {
                                    setState(() {
                                      _currentContent = Bookings(
                                        unitType: widget.unitType,
                                        user: widget.user,
                                        bookingId: widget.bookingId,
                                      );
                                    });
                                    sideMenu.changePage(page);
                                  },
                                  icon: Icon(Icons.login_outlined),
                                ),
                                SideMenuItem(
                                  title: 'Booking History',
                                  onTap: (page, _) {
                                    setState(() {
                                      _currentContent = BookingHistroy(
                                        user: widget.user,
                                      );
                                    });
                                    sideMenu.changePage(page);
                                  },
                                  icon: Icon(Icons.person_2_outlined),
                                ),
                                SideMenuItem(
                                  title: 'Payments',
                                  onTap: (page, _) {
                                    setState(() {
                                      _currentContent = SingleUserPayment(
                                        unitType: widget.unitType,
                                        user: widget.user,
                                      );
                                    });
                                    sideMenu.changePage(page);
                                  },
                                  icon: Icon(Icons.person_2_outlined),
                                  // Set the style property to change the text size
                                ),
                                SideMenuItem(
                                  title: 'Report',
                                  onTap: (page, _) {
                                    setState(() {
                                      _currentContent = SingleUserPayment(
                                        unitType: widget.unitType,
                                        user: widget.user,
                                      );
                                    });
                                    sideMenu.changePage(page);
                                  },
                                  icon: const Icon(Icons.mode_comment_outlined),
                                ),
                                SideMenuItem(
                                  title: 'Help',
                                  onTap: (page, _) {
                                    setState(() {
                                      _currentContent = SingleUserPayment(
                                        unitType: widget.unitType,
                                        user: widget.user,
                                      );
                                    });
                                    sideMenu.changePage(page);
                                  },
                                  icon: Icon(Icons.inbox_outlined),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 680,
                                decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Color.fromRGBO(199, 199, 199, 1)
                                          .withOpacity(0.5),
                                      blurRadius: 15,
                                      spreadRadius: 3,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Color.fromRGBO(255, 255, 255, 0.00),
                                ),
                                child: PageView(
                                    controller: page,
                                    children: [_currentContent]),
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
          );
        } else {
          return Scaffold(
            drawer: Drawer(
              child: ListView(
                  padding: EdgeInsets.only(
                    top: 3.h,
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            30.0), // Adjust the radius as needed
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Circleavatar.png?alt=media&token=1204cc77-6756-42ab-ba0e-3946a3fe6c9f',
                          width: 550, // Adjust the height as needed
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Booking',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = Bookings(
                              user: widget.user,
                              unitType: widget.unitType,
                              bookingId: widget.bookingId,
                            );
                          });
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Booking History',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = BookingHistroy(
                              user: widget.user,
                            );
                          });
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Payments',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = SingleUserPayment(
                              unitType: widget.unitType,
                              user: widget.user,
                            );
                          });
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Report',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = SingleUserPayment(
                              unitType: widget.unitType,
                              user: widget.user,
                            );
                          });
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Help',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = SingleUserPayment(
                              unitType: widget.unitType,
                              user: widget.user,
                            );
                          });
                          Navigator.pop(context);
                        }),
                  ]),
            ),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(
                height: 60,
                child: Material(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(2.5.w, 0, 2.5.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                            builder: (context) => IconButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  icon: Icon(
                                    Icons.menu_rounded,
                                    color: Colors.indigo.shade900,
                                  ),
                                )),
                        TextButton(
                          onPressed: () {
                            // Handle the first button press
                          },
                          child: Text(
                            'User',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "HelveticaNeueRegular",
                              color: Color.fromRGBO(112, 112, 112, 1),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: VerticalDivider(
                            color: Color.fromRGBO(206, 203, 203, 1),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Handle the third button press
                          },
                          child: Text(
                            'Partner',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "HelveticaNeueRegular",
                              color: Color.fromRGBO(206, 203, 203, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Expanded(
                child: Padding(
              padding: EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
              child: Container(
                  color: Color.fromRGBO(245, 243, 255, 1).withOpacity(0.5),
                  child: Expanded(child: _currentContent)),
            )),
          );
        }
      });
    });
  }
}
