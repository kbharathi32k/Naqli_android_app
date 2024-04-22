import 'dart:async';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Users/Enterprise/dashboard_page.dart';
import 'package:naqli_android_app/Users/SingleTimeUser/dashboard_page.dart';
import 'package:naqli_android_app/Users/SingleUser/homePageSingleUser.dart';
import 'package:naqli_android_app/Users/SuperUser/dashboard_page.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/createAccount.dart';
import 'package:naqli_android_app/loginPage.dart';
import 'package:sizer/sizer.dart';

class MblNoDialog1 extends StatefulWidget {
  const MblNoDialog1();

  @override
  State<MblNoDialog1> createState() => _MblNoDialogState();
}

class _MblNoDialogState extends State<MblNoDialog1> {
  bool isVerified = false;
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  AllUsersFormController controller = AllUsersFormController();
  TextEditingController otpController = TextEditingController();
  String? contactNumberError;
  String _firstName = '';
  String? storedVerificationId;
  @override
  late Stream<Map<String, dynamic>?> userStream;
  String _lastName = '';
  late StreamController<Map<String, dynamic>> _userStreamController;

  @override
  void initState() {
    super.initState();
    controller.contactNumberError = TextEditingController();
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

  // Declare a variable to store the verification ID

  Future<void> _startPhoneAuth1(String phoneNumber) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      bool isPhoneNumberRegistered =
          await checkIfPhoneNumberRegistered(phoneNumber);
      if (isPhoneNumberRegistered) {
        // If phone number is registered, navigate to LoginPage
        controller.contactNumberError.text = 'Phone number already exists';
        return;
      }
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) {
            Navigator.pop(context);
            setState(() {
              isVerified = true;
            });
            // Phone number verified, show success dialog
            _showSuccessDialog(phoneNumber);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print('Phone authentication failed: $e');
          showErrorDialog(
              "Invalid phone number format. Please enter a valid 10-digit phone number.");
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          storedVerificationId = verificationId;
          // Show OTP input dialog
          _showOTPDialog(phoneNumber);
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

  Future<bool> checkIfPhoneNumberRegistered(String phoneNumber) async {
    // Query Firestore to check if the phone number exists
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('user')
        .where('contactNumber', isEqualTo: phoneNumber)
        .get();

    // Return true if the phone number exists, false otherwise
    return snapshot.docs.isNotEmpty;
  }

  void _showOTPDialog(String phoneNumber) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: Container(
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
                          child:
                              Text('Verify', style: DialogText.helvetica30bold),
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
                  Text('Your code was sent to your mobile no',
                      style: DialogText.helvetica30),
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
                          await FirebaseAuth.instance
                              .signInWithCredential(_credential)
                              .then((value) {
                            Navigator.pop(context); // Close OTP dialog
                            _showSuccessDialog(
                                phoneNumber); // Show success dialog
                          });
                        } catch (e) {
                          print('Error during OTP verification: $e');
                          // Handle verification error
                          showErrorDialog(
                              "Invalid OTP. Please enter the correct OTP.");
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
                      Text("Didn't receive OTP ?", style: TabelText.helvetica),
                      InkWell(
                        child: Text('Resend',
                            style: FormTextStyle.purplehelvetica),
                        onTap: () async {
                          await _startPhoneAuth1(controller.contactNumber.text
                              // , adminUid
                              );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  void _showSuccessDialog(String phoneNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
          child: Dialog(
            child: SingleChildScrollView(
              child: Expanded(
                child: Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(31),
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(4.w, 5.h, 4.w, 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Row(
                                children: [
                                  ImageIcon(
                                    NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/approved.png?alt=media&token=1464e391-a8a7-4e1f-9ff8-90154603b7c9',
                                    ),
                                    color: Color.fromRGBO(60, 55, 148, 1),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Account Verified',
                                      style: DialogText.helvetica30bold),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SingleTimeUserDashboardPage()));
                            },
                            child: ImageIcon(
                              NetworkImage(
                                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text('$phoneNumber',
                          style: TextStyle(
                            fontFamily: 'Helvetica',
                            color: Colors.black,
                            fontSize: 28,
                          )),
                      SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.only(left: 2.w, right: 2.w),
                        child: Divider(),
                      ),
                      SizedBox(height: 6),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
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
              child: Expanded(
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
                                controller: controller.contactNumber,
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
                                  // String adminUid = widget.adminUid!;
                                  await _startPhoneAuth1(
                                      controller.contactNumber.text);
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
                        Text(controller.contactNumberError.text != null
                            ? controller.contactNumberError.text
                            : ''),
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
        } else {
          return Container();
        }
      });
    });
  }
}
