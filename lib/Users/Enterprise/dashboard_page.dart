import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naqli_android_app/Users/Enterprise/booking_manager.dart';
import 'package:naqli_android_app/Users/Enterprise/contracts.dart';
import 'package:naqli_android_app/Users/Enterprise/dashboard.dart';
import 'package:naqli_android_app/Users/Enterprise/payments.dart';
import 'package:naqli_android_app/Users/Enterprise/trigger_booking.dart';
import 'package:naqli_android_app/Users/Enterprise/users.dart';
import 'package:naqli_android_app/classes/language.dart';

import 'package:sizer/sizer.dart';
import '../../Widgets/customButton.dart';
import '../../Widgets/formText.dart';
import '../../classes/language_constants.dart';
import '../../main.dart';

class EnterDashboardPage extends StatefulWidget {
  final String user;
  EnterDashboardPage({required this.user});

  @override
  State<EnterDashboardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EnterDashboardPage> {
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
  bool expandWork = false;
  String? selectedValue;
  Widget _currentContent = enterDashboard(
    user: '',
  ); // Initial content

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
  }

  void enablePayNowButton() {
    setState(() {
      payNowButtonEnabled = true;
    });
  }

  Future<Map<String, dynamic>?> fetchData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('enterpriseuser')
              .doc(userId)
              .get();

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

  void disablePayNowButton() {
    setState(() {
      payNowButtonEnabled = false;
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
              preferredSize: Size.fromHeight(75),
              child: Material(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 0, 2.5.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                        width: 10.w,
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
                                fontSize: 16,
                                fontFamily: "HelveticaNeueRegular",
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<Language>(
                              isExpanded: true,
                              hint: Row(
                                children: [
                                  Text(
                                    translation(context).english,
                                    style: TabelText.helvetica11,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(child: SizedBox()),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 25,
                                  )
                                ],
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            e.flag,
                                            style: TabelText.helvetica11,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            e.langname,
                                            style: TabelText.helvetica11,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList(),
                              buttonStyleData: ButtonStyleData(
                                height: 30,
                                width: 130,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
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
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 15),
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
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 40,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Hello $firstName $lastName!",
                                          style: TabelText.helvetica11),
                                      Text("Admin", style: TabelText.usertext),
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
            body: Padding(
              padding: EdgeInsets.fromLTRB(6.w, 4.h, 6.w, 4.h),
              child: Expanded(
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text('Faizal Khan',
                                      style: DashboardText.acre),
                                  Text('Location',
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
                                  Text('ID No : xxxxxxxxxx',
                                      style: DashboardText.sfpro12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Image.network(
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b',
                                            width: 16,
                                            height: 16,
                                          )),
                                      Text('Edit Profile',
                                          style: DashboardText.sfpro12black),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 37.h,
                              padding: EdgeInsets.only(left: 1.5.w, top: 20),
                              child: SideMenu(
                                controller: sideMenu,
                                style: SideMenuStyle(
                                  displayMode: SideMenuDisplayMode.auto,
                                  selectedColor:
                                      Color.fromRGBO(98, 105, 254, 1),
                                  unselectedTitleTextStyle: const TextStyle(
                                    fontFamily: 'SFProText',
                                    fontSize: 18,
                                    color: Color.fromRGBO(128, 118, 118, 1),
                                  ),
                                  selectedTitleTextStyle: const TextStyle(
                                      fontFamily: 'SFProText',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  unselectedIconColor:
                                      Color.fromRGBO(128, 118, 118, 1),
                                  selectedIconColor: Colors.white,
                                ),
                                items: [
                                  SideMenuItem(
                                    title: 'Dashboard',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent = enterDashboard(
                                          user: widget.user,
                                        );
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon: const Icon(Icons.login_outlined),
                                  ),
                                  SideMenuItem(
                                    title: 'Trigger Booking',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent = TriggerBooking();
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon: const Icon(Icons.person_2_outlined),
                                  ),
                                  SideMenuItem(
                                    title: 'Bookings Manager',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent =
                                            Bookings(user: widget.user);
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon: const Icon(Icons.person_2_outlined),
                                    // Set the style property to change the text size
                                  ),
                                  SideMenuItem(
                                    title: 'Contracts',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent = Contracts();
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon: const Icon(Icons.person_2_outlined),
                                    // Set the style property to change the text size
                                  ),
                                  SideMenuItem(
                                    title: 'Payments',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent = Payments();
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon:
                                        const Icon(Icons.mode_comment_outlined),
                                  ),
                                  SideMenuItem(
                                    title: 'Users',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent = Users(
                                          user: widget.user!,
                                        );
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon:
                                        const Icon(Icons.mode_comment_outlined),
                                  ),
                                  SideMenuItem(
                                    title: 'Help',
                                    onTap: (page, _) {
                                      setState(() {
                                        _currentContent = TriggerBooking();
                                      });
                                      sideMenu.changePage(page);
                                    },
                                    icon: const Icon(Icons.inbox_outlined),
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
                          padding: EdgeInsets.fromLTRB(4.w, 4.5.h, 3.w, 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 630,
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
                                child: PageView(controller: page, children: [
                                  _currentContent,
                                ]),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              CustomButton(
                                onPressed: () {},
                                text: 'Confirm Booking',
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
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
                          'Dashboard',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = enterDashboard(
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
                          'Trigger Booking',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = TriggerBooking();
                          });
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Booking Manager',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = Bookings(
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
                          'Contracts',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = Contracts();
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
                            _currentContent = Payments();
                          });
                          Navigator.pop(context);
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    ListTile(
                        hoverColor: Colors.indigo.shade100,
                        title: Text(
                          'Users',
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          setState(() {
                            _currentContent = Users(user: widget.user!);
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
                            _currentContent = Bookings(
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
                        Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                          width: 10.w,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(2.0.w, 0, 0, 0),
                          child: TextButton(
                            onPressed: () {
                              // Handle the first button press
                            },
                            child: Text(
                              'User',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "HelveticaNeueRegular",
                                color: Color.fromRGBO(206, 203, 203, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                          height: 20, // Adjust this value to reduce space
                          child: VerticalDivider(
                            color: Color.fromRGBO(206, 203, 203, 1),
                          ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Hello $firstName $lastName!",
                                        style: TabelText.helvetica11),
                                    Text("Admin", style: TabelText.usertext),
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
                        Container(
                          padding: EdgeInsets.only(left: 5.0, top: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications,
                                color: Color.fromRGBO(106, 102, 209, 1),
                              ),
                              SizedBox(
                                height: 30,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 3, top: 5),
                                  child: Text(
                                    "Contact Us",
                                    style: TextStyle(
                                      fontFamily: 'Colfax',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: VerticalDivider(
                                  color: Color.fromRGBO(206, 203, 203, 1),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: Text(
                                    "Hello Faizal!",
                                    style: TextStyle(
                                      fontFamily: 'Colfax',
                                      fontSize: 12,
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
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(6.w, 3.h, 6.w, 3.h),
              child: Container(
                  color: Color.fromRGBO(240, 237, 250, 1),
                  child: Expanded(child: _currentContent)),
            ),
          );
        }
      });
    });
  }
}
