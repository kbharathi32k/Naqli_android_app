import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/customTextField.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:sizer/sizer.dart';

import '../../Controllers/allUsersFormController.dart';
import '../../Widgets/customButton.dart';

class Users extends StatefulWidget {
  String? user;
  Users({this.user});
  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool value = false;
  bool addUser = false;
  bool isButtonEnabled = false;
  bool isButtonEnabled1 = false;
  bool isButtonEnabled2 = false;
  int? selectedRadioValue;
  int? selectedRadioValue1;
  int? selectedRadioValue2;
  bool checkbox1 = false;
  bool checkbox2 = false;
  bool checkbox3 = false;
  List<String> dropdownValues = ['None'];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _Scroll = ScrollController();
  AllUsersFormController controller = AllUsersFormController();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildDropdown(int index) {
    return Row(
      children: [
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: dropdownValues[index], // Use value from the list
            items: <String>[
              'Trigger Bookings',
              'Booking Manager',
              'Contract',
              'None'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'SegoeItalic',
                      color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValues[index] = newValue!; // Update value in the list
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 45,
              width: 15.w,
              padding: EdgeInsets.only(left: 9, right: 9),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(112, 112, 112, 1)),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.white,
              ),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down_sharp,
              ),
              iconSize: 25,
              iconEnabledColor: Colors.black,
              iconDisabledColor: null,
            ),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              maxHeight: 200,
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(112, 112, 112, 1)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                color: Colors.white,
              ),
              scrollPadding: EdgeInsets.all(5),
              scrollbarTheme: ScrollbarThemeData(
                thickness: MaterialStateProperty.all<double>(6),
                thumbVisibility: MaterialStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              height: 30,
              padding: EdgeInsets.only(left: 9, right: 9),
            ),
          ),
        ),
        SizedBox(
          width: 2.w,
        )
      ],
    );
  }

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
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(75, 61, 82, 1),
                          border: Border.all(
                            width: 1.0,
                            color: Color.fromRGBO(75, 61, 82, 1),
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 80, top: 20),
                          child: Text(addUser ? 'New User' : 'Users',
                              style: BookingHistoryText.helvetica40),
                        ),
                      ),
                    ),
                  ],
                ),
                addUser
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 6.h),
                        child: Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color.fromRGBO(199, 199, 199, 1)
                                        .withOpacity(0.5),
                                    blurRadius: 15,
                                    spreadRadius: 3,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(20.0),
                                color: Color.fromRGBO(255, 255, 255, 0.00),
                              ),
                              child: Container(
                                padding:
                                    EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 8.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.0),
                                  color: Color.fromRGBO(255, 255, 255, 0.925),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 9.w,
                                            child: Text('Name',
                                                style: TabelText.helvetica)),
                                        Expanded(
                                            child: CustomTextfield(
                                          controller: controller.firstName,
                                          text: 'Enter name',
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 9.w,
                                            child: Text('Address',
                                                style: TabelText.helvetica)),
                                        Expanded(
                                            child: CustomTextfield(
                                          controller: controller.address,
                                          text: 'Enter address',
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 9.w,
                                            child: Text('Email ID',
                                                style: TabelText.helvetica)),
                                        Expanded(
                                            child: CustomTextfield(
                                          text: 'Enter email address',
                                          controller: controller.email,
                                        )),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SizedBox(
                                            width: 9.w,
                                            child: Text('Password',
                                                style: TabelText.helvetica)),
                                        Expanded(
                                            child: CustomTextfield(
                                          text: 'Enter password',
                                          controller: controller.password,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: 9.w,
                                            child: Text('Mobile No',
                                                style: TabelText.helvetica)),
                                        Expanded(
                                            child: CustomTextfield(
                                          text: 'Enter mobile no',
                                          controller: controller.contactNumber,
                                        )),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        SizedBox(
                                            width: 9.w,
                                            child: Text('User Photo',
                                                style: TabelText.helvetica)),
                                        Expanded(child: CustomTextfield()),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                width: 9.w,
                                                child: Text('Access to',
                                                    style:
                                                        TabelText.helvetica)),
                                            Row(
                                              children: [
                                                for (int i = 0;
                                                    i < dropdownValues.length;
                                                    i++)
                                                  _buildDropdown(i),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        dropdownValues.add(
                                                            'None'); // Add a new dropdown value
                                                      });
                                                    },
                                                    icon: Icon(Icons
                                                        .add_circle_outline_sharp)),
                                                Text(
                                                  'Add Access',
                                                  style: TabelText.helvetica,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        CustomButton(
                                          onPressed: () async {
                                            try {
                                              String? adminUid = widget.user;
                                              final FirebaseAuth _auth =
                                                  FirebaseAuth.instance;
                                              UserCredential userCredential =
                                                  await _auth
                                                      .createUserWithEmailAndPassword(
                                                email: controller.email.text,
                                                password:
                                                    controller.password.text,
                                              );

                                              // Extract UID from the userCredential.user object
                                              String userId =
                                                  userCredential.user!.uid;

                                              // Gather admin user fields
                                              String adminEmail =
                                                  'controller.adnEmail.text';
                                              // Add other admin fields as needed

                                              // Gather fields for subcollection documents
                                              String firstName =
                                                  controller.firstName.text;
                                              String lastName =
                                                  controller.lastName.text;
                                              String email =
                                                  controller.email.text;
                                              String password =
                                                  controller.password.text;
                                              String contactNumber =
                                                  controller.contactNumber.text;
                                              String address =
                                                  controller.address.text;
                                              String accounttype = controller
                                                  .selectedAccounttype.text;

                                              // Call functions to create documents in collection and subcollection
                                              await createCollectionAndSubcollection(
                                                  userId,
                                                  adminEmail,
                                                  adminUid!,
                                                  firstName,
                                                  lastName,
                                                  email,
                                                  password,
                                                  contactNumber,
                                                  address,
                                                  accounttype);
                                            } catch (e) {
                                              print("Error creating user: $e");
                                            }
                                          },
                                          text: 'Confirm',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                width: 127,
                                height: 45,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      addUser = !addUser;
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
                                  label: Text('Add user',
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
                                controller: _Scroll,
                                thumbVisibility:
                                    true, // Set to true to always show the scrollbar
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  controller: _Scroll,
                                  child: Container(
                                    height: 370,
                                    width: 1090,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: 220,
                                      child: ListView(
                                        children: [_booking1Table()],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
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
                    color: Color.fromRGBO(255, 255, 255, 157),
                    child: Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(3.w, 1.5.h, 1.5.w, 1.5.h),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromRGBO(240, 240, 240, 1)
                                        .withOpacity(0.1),
                                    offset: Offset(0, 0),
                                    spreadRadius: 2.0,
                                    blurRadius:
                                        0.01, // changes position of shadow
                                  ),
                                ],
                                color: Color.fromRGBO(75, 61, 82, 1),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0)),
                              ),
                              height: 80, // Brown color
                              child: Row(
                                children: [
                                  Text(
                                    addUser ? 'New User' : 'Users',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Helvetica",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            addUser
                                ? Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(7.w, 7.h, 7.w, 7.h),
                                    child: Expanded(
                                      child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Color.fromRGBO(
                                                        199, 199, 199, 1)
                                                    .withOpacity(0.5),
                                                blurRadius: 15,
                                                spreadRadius: 3,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.00),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                8.w, 8.h, 8.w, 8.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 0.925),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text('Name',
                                                            style: TabelText
                                                                .helvetica)),
                                                    Expanded(
                                                        child: CustomTextfield(
                                                      text: 'Enter name',
                                                      controller:
                                                          controller.firstName,
                                                    )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text('Email ID',
                                                            style: TabelText
                                                                .helvetica)),
                                                    Expanded(
                                                        child: CustomTextfield(
                                                      text:
                                                          'Enter email address',
                                                      controller:
                                                          controller.email,
                                                    )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text('Address',
                                                            style: TabelText
                                                                .helvetica)),
                                                    Expanded(
                                                        child: CustomTextfield(
                                                      text: 'Enter address',
                                                      controller:
                                                          controller.address,
                                                    )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text('Mobile No',
                                                            style: TabelText
                                                                .helvetica)),
                                                    Expanded(
                                                        child: CustomTextfield(
                                                      text: 'Enter mobile no',
                                                      controller: controller
                                                          .companyidNumber,
                                                    )),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text(
                                                            'User Photo',
                                                            style: TabelText
                                                                .helvetica)),
                                                    Expanded(
                                                        child:
                                                            CustomTextfield()),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: 100,
                                                        child: Text('Access to',
                                                            style: TabelText
                                                                .helvetica)),
                                                    Row(
                                                      children: [
                                                        for (int i = 0;
                                                            i <
                                                                dropdownValues
                                                                    .length;
                                                            i++)
                                                          _buildDropdown(i),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                dropdownValues.add(
                                                                    'None'); // Add a new dropdown value
                                                              });
                                                            },
                                                            icon: Icon(Icons
                                                                .add_circle_outline_sharp)),
                                                        Text(
                                                          'Add Access',
                                                          style: TabelText
                                                              .helvetica,
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(child: SizedBox()),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                CustomButton(
                                                  onPressed: () async {
                                                    try {
                                                      String? adminUid =
                                                          widget.user;
                                                      final FirebaseAuth _auth =
                                                          FirebaseAuth.instance;
                                                      UserCredential
                                                          userCredential =
                                                          await _auth
                                                              .createUserWithEmailAndPassword(
                                                        email: controller
                                                            .email.text,
                                                        password: controller
                                                            .password.text,
                                                      );

                                                      // Extract UID from the userCredential.user object
                                                      String userId =
                                                          userCredential
                                                              .user!.uid;

                                                      // Gather admin user fields
                                                      String adminEmail =
                                                          'controller.adnEmail.text';
                                                      // Add other admin fields as needed

                                                      // Gather fields for subcollection documents
                                                      String firstName =
                                                          controller
                                                              .firstName.text;
                                                      String lastName =
                                                          controller
                                                              .lastName.text;
                                                      String email =
                                                          controller.email.text;
                                                      String password =
                                                          controller
                                                              .password.text;
                                                      String contactNumber =
                                                          controller
                                                              .contactNumber
                                                              .text;
                                                      String address =
                                                          controller
                                                              .address.text;
                                                      String accounttype =
                                                          controller
                                                              .selectedAccounttype
                                                              .text;

                                                      // Call functions to create documents in collection and subcollection
                                                      await createCollectionAndSubcollection(
                                                          userId,
                                                          adminEmail,
                                                          adminUid!,
                                                          firstName,
                                                          lastName,
                                                          email,
                                                          password,
                                                          contactNumber,
                                                          address,
                                                          accounttype);
                                                    } catch (e) {
                                                      print(
                                                          "Error creating user: $e");
                                                    }
                                                  },
                                                  text: 'Confirm',
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  )
                                : Container(
                                    padding:
                                        EdgeInsets.fromLTRB(4.w, 8.h, 4.w, 2.h),
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: SizedBox(
                                            width: 127,
                                            height: 45,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  addUser = !addUser;
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                    color: Color.fromRGBO(
                                                        98, 84, 84, 1),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15), // Adjust border radius as needed
                                                ),
                                              ),
                                              icon: Icon(
                                                Icons.add,
                                                size: 15,
                                              ),
                                              label: Text('Add user',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        98, 84, 84, 1),
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
                                            controller: _Scroll,
                                            thumbVisibility:
                                                true, // Set to true to always show the scrollbar
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              controller: _Scroll,
                                              child: Container(
                                                height: 370,
                                                width: 1090,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  border: Border.all(
                                                    color: Color.fromRGBO(
                                                            112, 112, 112, 1)
                                                        .withOpacity(0.3),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: 220,
                                                  child: ListView(
                                                    children: [
                                                      _booking1Table()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                          ]),
                    ))),
          );
        }
      });
    });
  }

  // Future<String?> addUserDataToSubcollection() async {
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;

  //     // Reference to the user's document
  //     DocumentReference userDocRef =
  //         firestore.collection('enterprisedummy').doc();

  //     // Reference to the subcollection 'posts' under the user's document
  //     CollectionReference postsCollectionRef =
  //         userDocRef.collection('enterpriseUsers');

  //     // Data to be saved in the subcollection
  //     Map<String, dynamic> postData = {
  //       'firstName': controller.firstName.text,
  //       'lastName': controller.lastName.text,
  //       'email': controller.email.text,
  //       'password': controller.password.text,
  //       'contactNumber': controller.contactNumber.text,
  //       'address': controller.address.text,
  //       'alternateNumber': controller.alternateNumber.text,
  //       'address2': controller.address2.text,
  //       'city': controller.selectedCity.text,
  //       'accounttype': controller.selectedAccounttype.text,
  //       'createdTime': Timestamp.now(),
  //     };

  //     // Add data to the subcollection
  //     await postsCollectionRef.add(postData);

  //     return 'Data added to subcollection successfully!';
  //   } catch (error) {
  //     print('Error adding data to subcollection: $error');
  //     return null;
  //   }
  // }

  // Future<String?> addMultipleCollections() async {
  //   FirebaseFirestore.instance
  //       .collection('enterprisedummy')
  //       .doc('uid')
  //       .collection('enterpriseUsers')
  //       .add(
  //     {
  //       'firstName': controller.firstName.text,
  //       'lastName': controller.lastName.text,
  //       'email': controller.email.text,
  //       'password': controller.password.text,
  //       'contactNumber': controller.contactNumber.text,
  //       'address': controller.address.text,
  //       'alternateNumber': controller.alternateNumber.text,
  //       'address2': controller.address2.text,
  //       'city': controller.selectedCity.text,
  //       'accounttype': controller.selectedAccounttype.text,
  //     },
  //   );
  //   // FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   // CollectionReference users = firestore.collection('enterprisedummy');
  //   // users.doc(id).collection('enterpriseUsers').add({
  //   //   'firstName': controller.firstName.text,
  //   //   'lastName': controller.lastName.text,
  //   //   'email': controller.email.text,
  //   //   'password': controller.password.text,
  //   //   'contactNumber': controller.contactNumber.text,
  //   //   'address': controller.address.text,
  //   //   'alternateNumber': controller.alternateNumber.text,
  //   //   'address2': controller.address2.text,
  //   //   'city': controller.selectedCity.text,
  //   //   'accounttype': controller.selectedAccounttype.text,
  //   // });
  //   return 'Success';
  // }

  Future<void> createCollectionAndSubcollection(
    String userId,
    String adminEmail,
    String adminUid,
    String firstName,
    String lastName,
    String email,
    String password,
    String contactNumber,
    String address,
    String accountType,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's document
      DocumentReference userDocRef =
          firestore.collection('enterpriseuser').doc(adminUid);

      // Reference to the subcollection 'enterpriseUsers' under the user's document
      CollectionReference enterpriseUsersCollectionRef =
          userDocRef.collection('userEnterprise');

      // Data for top-level document
      // Map<String, dynamic> adminUserData = {
      //   'adminEmail': adminEmail,
      //   // Add other admin fields as needed
      // };

      // Data for subcollection document
      Map<String, dynamic> subcollectionUserData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'contactNumber': contactNumber,
        'address': address,
        'accountType': accountType,
        'createdTime': Timestamp.now(),
      };

      // Add top-level document
      // await userDocRef.set(adminUserData);

      // Add document to subcollection
      await enterpriseUsersCollectionRef.add(subcollectionUserData);

      print('Collection and subcollection documents created successfully!');
    } catch (error) {
      print('Error creating documents: $error');
    }
  }

  // Future<String?> createSubcollection(String userId) async {
  //   try {
  //     FirebaseFirestore firestore = FirebaseFirestore.instance;

  //     // Reference to the user's document
  //     DocumentReference userDocRef =
  //         firestore.collection('enterprisedummy').doc(userId);

  //     // Reference to the subcollection 'enterpriseUsers' under the user's document
  //     CollectionReference enterpriseUsersCollectionRef =
  //         userDocRef.collection('enterpriseUsers');

  //     // Data to be saved in the subcollection
  //     Map<String, dynamic> userData = {
  //       'firstName': controller.firstName.text,
  //       'lastName': controller.lastName.text,
  //       'email': controller.email.text,
  //       'password': controller.password.text,
  //       'contactNumber': controller.contactNumber.text,
  //       'address': controller.address.text,
  //       'accounttype': controller.selectedAccounttype.text,
  //       'createdTime': Timestamp.now(),
  //     };

  //     // Add data to the subcollection
  //     await enterpriseUsersCollectionRef.add(userData);

  //     return 'Subcollection created successfully!';
  //   } catch (error) {
  //     print('Error creating subcollection: $error');
  //     return null;
  //   }
  // }

  DataTable _booking1Table() {
    return DataTable(
        headingRowHeight: 60,
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => Color.fromRGBO(75, 61, 82, 1),
        ),
        dividerThickness: BorderSide.strokeAlignOutside,
        columnSpacing: 20,
        dataRowHeight: 73,
        columns: _booking1Columns(),
        rows: _booking1Rows());
  }

  List<DataColumn> _booking1Columns() {
    return [
      DataColumn(label: Text('dfsd', style: TabelText.helvetica16)),
      DataColumn(label: Text('User name', style: TabelText.helvetica16)),
      DataColumn(label: Text('User id', style: TabelText.helvetica16)),
      DataColumn(label: Text('Email id', style: TabelText.helvetica16)),
      DataColumn(label: Text('Last sign-in', style: TabelText.helvetica16)),
      DataColumn(label: Text('Contact no', style: TabelText.helvetica16)),
      DataColumn(label: Text('Address', style: TabelText.helvetica16)),
      DataColumn(
          label: SizedBox(
              width: 70,
              child: Text('Access to', style: TabelText.helvetica16))),
      DataColumn(label: Text('Action', style: TabelText.helvetica16)),
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
          SizedBox(
            width: 27,
            height: 27,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 51, 116, 53),
            ),
          ),
        ),
        DataCell(Text('Zenithusu', style: TabelText.helvetica)),
        DataCell(Text('#3524154212', style: TabelText.helvetica)),
        DataCell(Text('xyz@gmail.com', style: TabelText.helvetica)),
        DataCell(Text('Last hour', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(SizedBox(
            width: 60,
            child: Text('Trigger Booking', style: TabelText.helvetica))),
        DataCell(Row(
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
                onPressed: () {},
                icon: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
          ],
        ))
      ]),
      DataRow(cells: [
        DataCell(
          SizedBox(
            width: 27,
            height: 27,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 51, 116, 53),
            ),
          ),
        ),
        DataCell(Text('Akaza', style: TabelText.helvetica)),
        DataCell(Text('#3524154212', style: TabelText.helvetica)),
        DataCell(Text('xyz@gmail.com', style: TabelText.helvetica)),
        DataCell(Text('2 days', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(SizedBox(
            width: 72, child: Text('Contracts', style: TabelText.helvetica))),
        DataCell(Row(
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
                onPressed: () {},
                icon: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
          ],
        ))
      ]),
      DataRow(cells: [
        DataCell(
          SizedBox(
            width: 27,
            height: 27,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 51, 116, 53),
            ),
          ),
        ),
        DataCell(Text('Inosuke', style: TabelText.helvetica)),
        DataCell(Text('#3524154212', style: TabelText.helvetica)),
        DataCell(Text('xyz@gmail.com', style: TabelText.helvetica)),
        DataCell(Text('1 week', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(SizedBox(
            width: 70,
            child: Text('Booking Manager', style: TabelText.helvetica))),
        DataCell(Row(
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
                onPressed: () {},
                icon: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
          ],
        ))
      ]),
      DataRow(cells: [
        DataCell(
          SizedBox(
            width: 27,
            height: 27,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 51, 116, 53),
            ),
          ),
        ),
        DataCell(Text('Tengen', style: TabelText.helvetica)),
        DataCell(Text('#3524154212', style: TabelText.helvetica)),
        DataCell(Text('xyz@gmail.com', style: TabelText.helvetica)),
        DataCell(Text('6 days', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(Text('XXXXXXXXX', style: TabelText.helvetica)),
        DataCell(Text('-', style: TabelText.helvetica)),
        DataCell(Row(
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
                onPressed: () {},
                icon: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
          ],
        ))
      ]),
    ];
  }
}

// class CandidateListSource extends DataTableSource {
//   CandidateListSource();

//   @override
//   DataRow? getRow(int index) {
//     return DataRow.byIndex(
//       index: index,
//       cells: [
//         DataCell(
//           SizedBox(
//             width: 27,
//             height: 27,
//             child: CircleAvatar(
//               backgroundColor: const Color.fromARGB(255, 51, 116, 53),
//             ),
//           ),
//         ),
//         DataCell(Text('Zenithusu')),
//         DataCell(Text('#3524154212')),
//         DataCell(Text('xyz@gmail.com')),
//         DataCell(Text('Last hour')),
//         DataCell(Text('XXXXXXXXX')),
//         DataCell(Text('XXXXXXXXX')),
//         DataCell(Text('Trigger Booking')),
//         DataCell(Row(
//           children: [
//             IconButton(
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//                 onPressed: () {},
//                 icon: Image.network('https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/editicon.png?alt=media&token=b0315743-5ecb-437e-94e2-c6c3c82d343b')),
//             SizedBox(
//               width: 1.w,
//             ),
//             IconButton(
//                 padding: EdgeInsets.zero,
//                 constraints: BoxConstraints(),
//                 onPressed: () {},
//                 icon: Image.network('https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
//           ],
//         ))
//         // DataCell(
//         //   Text(e.name.toString()),
//         //   onTap: () {
//         //     onSelect(e);
//         //   },
//         // ),
//         // DataCell(
//         //   SizedBox(
//         //     width: 27,
//         //     height: 27,
//         //     child: CircleAvatar(
//         //       backgroundColor: const Color.fromARGB(255, 51, 116, 53),
//         //     ),
//         //   ),
//         // ),
//         // DataCell(Text(e.qualification?.toString() ?? 'nill')),
//         // DataCell(Text(e.skills!.isNotEmpty ? e.skills![0] : '')),
//         // DataCell(Text(e.skills!.isNotEmpty ? e.skills![1] : '')),
//         // DataCell(Text(e.selectedOption?.toString() ?? '- - - -')),
//         // DataCell(Text(e.mobile.toString())),
//         // DataCell(Text(e.name.toString())),
//       ],
//     );
//   }

//   static List<DataColumn> getColumns(BuildContext context) {
//     return [
//       DataColumn(label: Text('dfsd')),
//       DataColumn(label: Text('User name')),
//       DataColumn(label: Text('User id')),
//       DataColumn(label: Text('Email id')),
//       DataColumn(label: Text('Last sign-in')),
//       DataColumn(label: Text('Contact no')),
//       DataColumn(label: Text('Address')),
//       DataColumn(label: Text('Access to')),
//       DataColumn(label: Text('Action')),
//     ];
//   }

//   @override
//   bool get isRowCountApproximate => false;

//   @override
//   int get rowCount => 0;

//   @override
//   int get selectedRowCount => 0;
// }

class SimpleCandidate {
  final String? name;
  final String? id;
  final String? mailid;
  final String? lastsignin;
  final String? contact;
  final String? address;
  final String? access;
  final Row? row;

  SimpleCandidate(
      {this.name,
      this.id,
      this.mailid,
      this.lastsignin,
      this.contact,
      this.access,
      this.address,
      this.row});
}

class SimpleCandidateListSource extends DataTableSource {
  final List<SimpleCandidate> candidates;

  SimpleCandidateListSource(
    this.candidates,
  );

  @override
  DataRow getRow(int index) {
    final candidate = candidates[index];
    return DataRow(cells: [
      DataCell(
        SizedBox(
          width: 27,
          height: 27,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 51, 116, 53),
          ),
        ),
      ),
      DataCell(Text(candidate.name?.toString() ?? 'nill')),
      DataCell(Text(candidate.id.toString())),
      DataCell(Text(candidate.mailid.toString())),
      DataCell(Text(candidate.lastsignin.toString())),
      DataCell(Text(candidate.contact.toString())),
      DataCell(Text(candidate.address.toString())),
      DataCell(Text(candidate.access.toString())),
      DataCell(Row(
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
              onPressed: () {},
              icon: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
        ],
      ))
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => candidates.length;

  @override
  int get selectedRowCount => 0;
}

final List<SimpleCandidate> simpleCandidates = [
  SimpleCandidate(
      name: 'Zenithusu',
      id: '3524154212',
      mailid: 'xyz@gmail.com',
      lastsignin: 'Last hour',
      contact: 'XXXXXXXXX',
      address: 'XXXXXXXXX',
      access: 'Trigger Booking',
      row: Row(
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
              onPressed: () {},
              icon: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
        ],
      )),
  SimpleCandidate(
      name: 'Inosuke',
      id: '3524154212',
      mailid: 'xyz@gmail.com',
      lastsignin: '2 days',
      contact: 'XXXXXXXXX',
      address: 'XXXXXXXXX',
      access: 'Contracts',
      row: Row(
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
              onPressed: () {},
              icon: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
        ],
      )),
  SimpleCandidate(
      name: 'Tengen',
      id: '3524154212',
      mailid: 'xyz@gmail.com',
      lastsignin: '1 week',
      contact: 'XXXXXXXXX',
      address: 'XXXXXXXXX',
      access: 'Booking Manager',
      row: Row(
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
              onPressed: () {},
              icon: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
        ],
      )),
  SimpleCandidate(
      name: '6 days',
      id: '3524154212',
      mailid: 'xyz@gmail.com',
      lastsignin: 'Last hour',
      contact: 'XXXXXXXXX',
      address: 'XXXXXXXXX',
      access: 'Trigger Booking',
      row: Row(
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
              onPressed: () {},
              icon: Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/deleteicon.png?alt=media&token=ffdc3710-03dc-482a-90e5-72c72c83eb87')),
        ],
      )),
];
