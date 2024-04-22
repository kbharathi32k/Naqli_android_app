import 'dart:async';

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Users/Enterprise/dashboard_page.dart';
import 'package:naqli_android_app/Users/SingleUser/homePageSingleUser.dart';
import 'package:naqli_android_app/Users/SuperUser/dashboard_page.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/createAccount.dart';
import 'package:sizer/sizer.dart';

class MblNoDialog extends StatefulWidget {
  final String? email;
  final String? password;
  final String? selectedAccounttype;
  final String? firstName;
  final String? lastName;
  final String? legalName;
  final String? contactNumber;
  final String? address;
  final String? govtId;
  final String? selectedGovtId;
  final String? confirmPassword;
  final String? alternateNumber;
  final String? address2;
  final String? idNumber;
  final String? city;
  final String? selectedCity;
  final String? companyidNumber;
  final String? adminUid;

  const MblNoDialog({
    this.email,
    this.password,
    this.selectedAccounttype,
    this.firstName,
    this.lastName,
    this.legalName,
    this.address,
    this.city,
    this.govtId,
    this.address2,
    this.alternateNumber,
    this.companyidNumber,
    this.confirmPassword,
    this.contactNumber,
    this.idNumber,
    this.selectedCity,
    this.selectedGovtId,
    this.adminUid,
  });

  @override
  State<MblNoDialog> createState() => _MblNoDialogState();
}

class _MblNoDialogState extends State<MblNoDialog> {
  bool isVerified = false;
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  AllUsersFormController controller = AllUsersFormController();
  TextEditingController otpController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  String _firstName = '';
  @override
  late Stream<Map<String, dynamic>?> userStream;
  String _lastName = '';
  late StreamController<Map<String, dynamic>> _userStreamController;

  @override
  void initState() {
    super.initState();
    userStream = fetchData().map((data) => data);
  }

  Stream<Map<String, dynamic>?> fetchData() {
    try {
      String collectionName = '';

      if (widget.selectedAccounttype == 'Enterprise') {
        collectionName = 'enterpriseuser';
      } else if (widget.selectedAccounttype == 'Super User') {
        collectionName = 'superuser';
      } else if (widget.selectedAccounttype == 'User') {
        collectionName = 'user';
      }

      String adminUid = widget.adminUid!;
      return FirebaseFirestore.instance
          .collection(collectionName)
          .doc(adminUid)
          .snapshots()
          .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()!;
          String firstName = data['firstName'];
          String lastName = data['lastName'];
          _firstName = firstName;
          _lastName = lastName;
          return data;
        } else {
          print('Document does not exist');
          return null;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
      return Stream.value(null);
    }
  }

  void fetchData1() async {
    try {
      String selectedAccounttype = widget.selectedAccounttype!;
      String smsCode =
          otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
      String adminUid = widget.adminUid!;
      PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: storedVerificationId!,
        smsCode: smsCode,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(_credential);
      // Fetch user details from Firebase
      User? user = userCredential.user;
      String? phoneNumber = user?.phoneNumber;

      // Determine the collection based on selectedAccountType
      String collectionName = '';

      if (selectedAccounttype == 'Enterprise') {
        collectionName = 'enterpriseuser';
      } else if (selectedAccounttype == 'Super User') {
        collectionName = 'superuser';
      } else if (selectedAccounttype == 'User') {
        collectionName = 'user';
      }

      FirebaseFirestore.instance
          .collection(collectionName)
          .doc(adminUid)
          .snapshots()
          .listen((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data = documentSnapshot.data()!;
          _userStreamController.add(data);
        } else {
          print('Document does not exist');
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void dispose() {
    _userStreamController.close();
    super.dispose();
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(errorMessage),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression pattern to match a 10-digit phone number
    RegExp regex = RegExp(r'^[0-9]{10}$');

    // Check if the phone number matches the pattern
    if (regex.hasMatch(phoneNumber)) {
      // Phone number format is valid
      return true;
    } else {
      // Phone number format is invalid
      return false;
    }
  }

  String?
      storedVerificationId; // Declare a variable to store the verification ID

  Future<void> _startPhoneAuth(String phoneNumber) async {
    print("mobtrack3");

    FirebaseAuth _auth = FirebaseAuth.instance;
    String? adminUid = widget.adminUid;
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${contactNumberController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) {
            Navigator.pop(context);
            setState(() {
              isVerified = true;
            });
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle the verification failure
          print('Phone authentication failed: $e');
          showErrorDialog(
              "Invalid phone number format. Please enter a valid 10-digit phone number.");
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          // Store the verification ID for later use (e.g., resend OTP)
          storedVerificationId = verificationId;

          // Show the dialog to enter OTP

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                // titlePadding: EdgeInsets.zero,
                // contentPadding: EdgeInsets.zero,
                child: Container(
                  height: 310,
                  width: 1215,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(31),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(4.w, 4.h, 4.w, 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text('Verify',
                                  style: TabelText.helveticablack19),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ImageIcon(
                              NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Adjust spacing as needed
                      Text(
                        'Your code was sent to your mobile no',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Helvetica',
                          fontSize: 22,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: TextField(
                              controller: otp1,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: TextField(
                              controller: otp2,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: TextField(
                              controller: otp3,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: TextField(
                              controller: otp4,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: TextField(
                              controller: otp5,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.5.w,
                          ),
                          SizedBox(
                            height: 45,
                            width: 45,
                            child: TextField(
                              controller: otp6,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Adjust spacing as needed
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            String selectedAccounttype =
                                widget.selectedAccounttype!;
                            String smsCode = otp1.text +
                                otp2.text +
                                otp3.text +
                                otp4.text +
                                otp5.text +
                                otp6.text;

                            PhoneAuthCredential _credential =
                                PhoneAuthProvider.credential(
                              verificationId: storedVerificationId!,
                              smsCode: smsCode,
                            );

                            try {
                              // Sign in with phone credential
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .signInWithCredential(_credential);

                              if (userCredential.user != null) {
                                print("OTP verified successfully");
                                String adminUid = widget.adminUid!;
                                // Fetch user details from Firebase
                                User? user = userCredential.user;
                                String? phoneNumber = user?.phoneNumber;

                                // Determine the collection based on selectedAccountType
                                String collectionName = '';

                                if (selectedAccounttype == 'Enterprise') {
                                  collectionName = 'enterpriseuser';
                                } else if (selectedAccounttype ==
                                    'Super User') {
                                  collectionName = 'superuser';
                                } else if (selectedAccounttype == 'User') {
                                  collectionName = 'user';
                                }

                                // Fetch user details from the determined collection
                                FirebaseFirestore.instance
                                    .collection(collectionName)
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  if (querySnapshot.docs.isNotEmpty) {
                                    QueryDocumentSnapshot recentDocument =
                                        querySnapshot.docs.first;
                                    Map<String, dynamic> userData =
                                        recentDocument.data()
                                            as Map<String, dynamic>;

                                    // Check if 'firstName' field exists in the document
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: Container(
                                            height: 340,
                                            width: 1225,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(31),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ImageIcon(
                                                            NetworkImage(
                                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/approved.png?alt=media&token=1464e391-a8a7-4e1f-9ff8-90154603b7c9'),
                                                            color:
                                                                Color.fromRGBO(
                                                                    60,
                                                                    55,
                                                                    148,
                                                                    1),
                                                            size: 30,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            'Account Verified',
                                                            style: TabelText
                                                                .helveticablack19,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        //dfgsfdg
                                                        UserCredential
                                                            userCredential =
                                                            await _auth
                                                                .signInWithEmailAndPassword(
                                                          email: widget.email!,
                                                          password:
                                                              widget.password!,
                                                        );
                                                        String userId =
                                                            userCredential
                                                                .user!.uid;
                                                        if (widget
                                                                .selectedAccounttype ==
                                                            'Enterprise') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    EnterDashboardPage(
                                                                        user:
                                                                            userId)),
                                                          );
                                                        } else if (widget
                                                                .selectedAccounttype ==
                                                            'Super User') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    SuperUserDashboardPage(
                                                                        user:
                                                                            userId)),
                                                          );
                                                        } else if (widget
                                                                .selectedAccounttype ==
                                                            'User') {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    MyHomePagesingle(
                                                                        user:
                                                                            userId)),
                                                          );
                                                        } else {
                                                          // Handle invalid selectedType
                                                          print(
                                                              'Invalid selected type: ${widget.selectedAccounttype}');
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Center(
                                                            child: ImageIcon(
                                                              NetworkImage(
                                                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 20),
                                                StreamBuilder<
                                                    Map<String, dynamic>?>(
                                                  stream: userStream,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.data != null) {
                                                      return Column(
                                                        children: [
                                                          Text(
                                                            "$_firstName $_lastName",
                                                            style: DialogText
                                                                .helvetica41,
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      // Loading or error state
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                  },
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "$phoneNumber",
                                                  style: DialogText.helvetica42,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 2.w, right: 5.w),
                                                  child: Divider(
                                                    color: Color.fromRGBO(
                                                        112, 112, 112, 1),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                }).catchError((e) {
                                  print("Error fetching user data: $e");
                                  // Handle error during document fetch
                                  // Show an error message or take appropriate action
                                });
                              } else {
                                showErrorDialog(
                                    "Invalid verification code. Please enter the correct code.");
                              }
                            } catch (e) {
                              print("Error signing in with credential: $e");
                              // Handle error during sign-in
                              // Show an error message or take appropriate action
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(60, 55, 148, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Verify", style: TabelText.dialogtext1),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Didn't receive OTP ?",
                              style: TabelText.helvetica),
                          InkWell(
                            child: Text('Resend',
                                style: FormTextStyle.purplehelvetica),
                            onTap: () async {
                              await _startPhoneAuth(
                                contactNumberController.text,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle code auto retrieval timeout if needed
        },
        timeout: Duration(seconds: 45),
      );
    } catch (e) {
      print('Error during phone authentication: $e');
      showErrorDialog(
          "Error during phone number verification. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1180) {
          return Padding(
            padding: EdgeInsets.fromLTRB(18.w, 33.h, 18.w, 33.h),
            child: SingleChildScrollView(
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(31))),
                child: Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(31),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(4.w, 4.h, 2.w, 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text('Enter Mobile No',
                                  style: LoginpageText.helvetica30bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: ImageIcon(
                              NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 200,
                            child: TextField(
                              controller: contactNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '99999 99999',
                                contentPadding: EdgeInsets.only(
                                  left: 1.w,
                                ),
                                hintStyle: DialogText.helvetica16sandal,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0)),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (widget.adminUid != null) {
                                    String adminUid = widget.adminUid!;
                                    await _startPhoneAuth(
                                      contactNumberController.text,
                                    );
                                  } else {
                                    await _startPhoneAuth(
                                        contactNumberController.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(60, 55, 148, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Text(
                                  "Get OTP",
                                  style: LoginpageText.helvetica16white,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 5.w),
                        child: Divider(
                          color: Color.fromRGBO(112, 112, 112, 1),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: HomepageText.helvetica16black),
                          InkWell(
                            child: Text('Create One!',
                                style: LoginpageText.purplehelvetica),
                            onTap: () {
                              showDialog(
                                barrierColor: Colors.grey.withOpacity(0.5),
                                context: context,
                                builder: (context) {
                                  return CreateAccount();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Dialog(
            child: Padding(
              padding: EdgeInsets.fromLTRB(18.w, 33.h, 18.w, 33.h),
              child: SingleChildScrollView(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(31))),
                  child: Container(
                    height: 280,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(31),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(4.w, 4.h, 2.w, 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text('Enter Mobile No',
                                  style: LoginpageText.helvetica30bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: ImageIcon(
                                NetworkImage(
                                    'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                              width: 200,
                              child: TextField(
                                controller: contactNumberController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: '99999 99999',
                                  contentPadding: EdgeInsets.only(
                                    left: 1.w,
                                  ),
                                  hintStyle: DialogText.helvetica16sandal,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () async {
                                  String adminUid = widget.adminUid!;
                                  await _startPhoneAuth(
                                    contactNumberController.text,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(60, 55, 148, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    )),
                                child: Text("Get OTP",
                                    style: LoginpageText.helvetica16white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 5.w),
                          child: Divider(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: HomepageText.helvetica16black),
                            InkWell(
                              child: Text('Create One!',
                                  style: LoginpageText.purplehelvetica),
                              onTap: () {
                                showDialog(
                                  barrierColor: Colors.grey.withOpacity(0.5),
                                  context: context,
                                  builder: (context) {
                                    return CreateAccount();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
  }
}
