import 'package:flutter/material.dart';
import 'package:naqli_android_app/Users/SingleTimeUser/bookingDetails.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/classes/language.dart';
import 'package:naqli_android_app/classes/language_constants.dart';
import 'package:naqli_android_app/main.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class SingleTimeUserDashboardPage extends StatefulWidget {
  String? adminUid;
  SingleTimeUserDashboardPage({this.adminUid});
  @override
  State<SingleTimeUserDashboardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SingleTimeUserDashboardPage> {
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
  Widget _currentContent = BookingDetails(); // Initial content

  void _handleItem1Tap() {
    setState(() {
      _currentContent = BookingDetails();
    });
    Navigator.pop(context);
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Hello Faizal!",
                                    style: TabelText.helvetica11),
                                Text("Admin", style: TabelText.usertext),
                                Text("Faizal industries",
                                    style: TabelText.usertext),
                              ],
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
              padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
              child: Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(4.w, 5.h, 3.w, 5.h),
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
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                          width: 1000,
                          height: 850,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 216, 214, 214)
                                  .withOpacity(0.2),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color.fromARGB(255, 199, 198, 198)
                                    .withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 10,
                                offset: Offset(0, 0.5), // Bottom side shadow
                              ),
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 255, 255)
                                    .withOpacity(0.2),
                                blurRadius: 1,
                                spreadRadius: 0, // Bottom side shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          child: PageView(
                              controller: page, children: [_currentContent]))),
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
                    // ListTile(
                    //     hoverColor: Colors.indigo.shade100,
                    //     title: Text(
                    //       'Booking',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         _currentContent = Bookings();
                    //       });
                    //       Navigator.pop(context);
                    //     }),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // ListTile(
                    //     hoverColor: Colors.indigo.shade100,
                    //     title: Text(
                    //       'Booking History',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         _currentContent = BookingHistroy();
                    //       });
                    //       Navigator.pop(context);
                    //     }),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // ListTile(
                    //     hoverColor: Colors.indigo.shade100,
                    //     title: Text(
                    //       'Payments',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         _currentContent = SingleUserPayment();
                    //       });
                    //       Navigator.pop(context);
                    //     }),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // ListTile(
                    //     hoverColor: Colors.indigo.shade100,
                    //     title: Text(
                    //       'Report',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         _currentContent = SingleUserPayment();
                    //       });
                    //       Navigator.pop(context);
                    //     }),
                    // SizedBox(
                    //   height: 2.h,
                    // ),
                    // ListTile(
                    //     hoverColor: Colors.indigo.shade100,
                    //     title: Text(
                    //       'Help',
                    //       style: TextStyle(color: Colors.black),
                    //     ),
                    //     onTap: () {
                    //       setState(() {
                    //         _currentContent = Dashboard();
                    //       });
                    //       Navigator.pop(context);
                    //     }),
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
            body: Padding(
              padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
              child: Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(4.w, 5.h, 3.w, 5.h),
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
                  child: Align(
                      alignment: Alignment.center,
                      child: Expanded(
                        child: Container(
                            height: 850,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromARGB(255, 216, 214, 214)
                                    .withOpacity(0.2),
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromARGB(255, 199, 198, 198)
                                      .withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 10,
                                  offset: Offset(0, 0.5), // Bottom side shadow
                                ),
                                BoxShadow(
                                  color: Color.fromARGB(255, 255, 255, 255)
                                      .withOpacity(0.2),
                                  blurRadius: 1,
                                  spreadRadius: 0, // Bottom side shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                            ),
                            child: PageView(
                                controller: page, children: [_currentContent])),
                      )),
                ),
              ),
            ),
          );
        }
      });
    });
  }
}
