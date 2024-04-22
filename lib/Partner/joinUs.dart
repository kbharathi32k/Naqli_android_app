import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Partner/Dashboard/dashboard_page.dart';
import 'package:naqli_android_app/Partner/homepage.dart';
import 'package:naqli_android_app/Partner/operator.dart';
import 'package:naqli_android_app/Widgets/customTextField.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:quiver/time.dart';
import 'package:sizer/sizer.dart';

class Partner extends StatefulWidget {
  final String? user;
  Partner({
    this.user,
  });
  @override
  _State createState() => _State();
}

class _State extends State<Partner> {
  late int _selectedValue = 0;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AllUsersFormController controller = AllUsersFormController();
  String otpPin = '';
  String countryDial = '+91';
  String verID = '';
  bool isVerified = false;
  int screenState = 0;

  bool isValidName(String name) {
    final RegExp nameRegExp = RegExp(r"^[A-Za-z']+([- ][A-Za-z']+)*$");
    return nameRegExp.hasMatch(name);
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidName(value)) {
      return 'Invalid format';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '*Required';
    } else if (!isValidEmail(value)) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    RegExp regex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$',
    );
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  Future<void> verifyPhone(String number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: Duration(seconds: 20),
      phoneNumber: "+91$number",
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
      codeSent: (String verificationId, int? resendToken) {
        verID = verificationId;
        setState(() {
          showDialog(
            barrierColor: Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
            context: context,
            builder: (context) {
              return AlertDialog(
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 310,
                  width: 1215,
                  child: Column(
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
                      PinCodeTextField(
                        onDone: (value) {
                          setState(() {
                            otpPin = value;
                          });
                        },
                        maxLength: 6,
                      ),
                      SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (otpPin.length >= 6) {
                              verifyOTP();
                              screenState = 1;
                            } else {
                              SnackBar(
                                content: Text('Enter OTP Correctly'),
                              );
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
                      )
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle code auto retrieval timeout if needed
      },
    );
  }

  Future<void> verifyOTP() async {
    PhoneAuthCredential _credential =
        PhoneAuthProvider.credential(verificationId: verID, smsCode: otpPin);
    Navigator.pop(context);
    screenState = 1;
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

  Future<void> _saveUserDataToFirestore(String uid) async {
    print("track2");

    try {
      Random random = Random();

      String bookingID = '';
      for (int i = 0; i < 10; i++) {
        bookingID += random.nextInt(10).toString();
      }
      String userCollection;
      Map<String, dynamic> userData = {
        'firstName': controller.firstName.text,
        'email': controller.email.text,
        'phoneNumber': controller.contactNumber.text,
        'password': controller.password.text,
        'userId': bookingID,
      };
      userCollection = 'partneruser';
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(uid)
          .set(userData);
    } catch (e) {
      print("Data doesn't store : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1180) {
          return Dialog(
            child: Container(
              width: 580,
              height: 600,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(31),
                  bottomLeft: Radius.circular(31),
                  topRight: Radius.circular(31),
                  bottomRight: Radius.circular(31),
                ),
              ),
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 50,
                            color: Color.fromRGBO(142, 151, 160, 1),
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text('Join Us',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.5.w, 2.h, 0.5.w, 3.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Transform.scale(
                                scale: 0.8,
                                child: Radio(
                                  value: 1,
                                  groupValue: _selectedValue,
                                  toggleable: false,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value ??
                                          0; // Use null-aware operator to handle null value
                                      print('Selected value: $_selectedValue');
                                    });
                                  },
                                ),
                              ),
                              Text('Enterprise',
                                  style: PartRegText.helvetica17grey),
                              Transform.scale(
                                scale: 0.8,
                                child: Radio(
                                  value: 2,
                                  groupValue: _selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value ??
                                          0; // Use null-aware operator to handle null value
                                      print('Selected value: $_selectedValue');
                                    });
                                  },
                                ),
                              ),
                              Text('Multiple Units',
                                  style: PartRegText.helvetica17grey),
                              Transform.scale(
                                scale: 0.8,
                                child: Radio(
                                  value: 3,
                                  groupValue: _selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value ??
                                          0; // Use null-aware operator to handle null value
                                      print('Selected value: $_selectedValue');
                                    });
                                  },
                                ),
                              ),
                              Text('Single Unit + operator',
                                  style: PartRegText.helvetica17grey),
                              Transform.scale(
                                scale: 0.8,
                                child: Radio(
                                  value: 4,
                                  groupValue: _selectedValue,
                                  onChanged: (int? value) {
                                    setState(() {
                                      _selectedValue = value ??
                                          0; // Use null-aware operator to handle null value
                                      print('Selected value: $_selectedValue');
                                    });
                                  },
                                ),
                              ),
                              Text('Operator',
                                  style: PartRegText.helvetica17grey),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5.w, 6.h, 5.w, 0),
                          child: Container(
                            height: 350,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  CustomTextfield(
                                    validator: nameValidator,
                                    controller: controller.firstName,
                                    text: 'Enter your Name',
                                  ),
                                  Text('Mobile No',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 50,
                                          child: TextFormField(
                                            style: TextStyle(height: 1),
                                            validator: (value) {
                                              if (value!.length != 10)
                                                return 'Mobile Number must be of 10 digit';
                                              else
                                                return null;
                                            },
                                            controller:
                                                controller.contactNumber,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.only(left: 0.9.w),
                                              hintStyle: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13,
                                                  fontFamily: 'SegoeItalic',
                                                  color: Color.fromRGBO(
                                                          112, 112, 112, 1)
                                                      .withOpacity(0.5)),
                                              hintText:
                                                  'Enter your Mobile Number',
                                              errorStyle: TextStyle(
                                                  height: 0, fontSize: 8.5),
                                              errorMaxLines: 2,
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      202, 202, 202, 1),
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(5),
                                                    topLeft:
                                                        Radius.circular(5)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 49,
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromRGBO(
                                                  98, 105, 254, 1),
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(5),
                                                    topRight: Radius.circular(
                                                        5)), // Make button shape square
                                              ),
                                            ),
                                            onPressed: () {
                                              print('track 1');
                                              // if (screenState == 0) {
                                              if (controller
                                                  .firstName.text.isEmpty) {
                                                print('track 2');
                                                SnackBar(
                                                  content: Text(
                                                      'Username is still empty'),
                                                );
                                              } else if (controller
                                                  .companyidNumber
                                                  .text
                                                  .isEmpty) {
                                                print('track 3');
                                                SnackBar(
                                                  content: Text(
                                                      'Mobil Number is still empty'),
                                                );
                                              } else {
                                                print('track 4');
                                              }
                                              // } else {
                                              //   if (otpPin.length >= 6) {
                                              //     verifyOTP();
                                              //   } else {
                                              //     SnackBar(
                                              //       content: Text(
                                              //           'Enter OTP Correctly'),
                                              //     );
                                              //   }
                                              // }
                                              verifyPhone(controller
                                                  .contactNumber.text);
                                            },
                                            child: screenState == 0
                                                ? Text('Verify')
                                                : Text('Verified')),
                                      ),
                                    ],
                                  ),
                                  Text('Email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  CustomTextfield(
                                    controller: controller.email,
                                    validator: emailValidator,
                                    text: 'Enter your Email ID',
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('Password',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  CustomTextfield(
                                    controller: controller.password,
                                    validator: validatePassword,
                                    text: 'Enter your Password',
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color.fromRGBO(98, 105,
                                            254, 1), // Set button color to blue
                                        foregroundColor: Colors.white,
                                        minimumSize:
                                            Size(230, 50), // Set button size
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // Set button shape to rounded rectangle
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            PhoneAuthCredential _credential =
                                                PhoneAuthProvider.credential(
                                                    verificationId: verID,
                                                    smsCode: otpPin);
                                            // Sign in with phone credential
                                            UserCredential userCredential =
                                                await _auth
                                                    .createUserWithEmailAndPassword(
                                              email: controller.email.text,
                                              password:
                                                  controller.password.text,
                                            );
                                            String userId =
                                                userCredential.user!.uid;
                                            await _saveUserDataToFirestore(
                                                userId);

                                            if (userCredential.user != null) {
                                              showDialog(
                                                barrierColor:
                                                    Colors.transparent,
                                                context: context,
                                                builder: (context) {
                                                  return Operator(
                                                    user: userId,
                                                  );
                                                },
                                              );
                                            } else {
                                              showErrorDialog(
                                                  "Invalid verification code. Please enter the correct code.");
                                            }
                                          } catch (e) {
                                            print(
                                                "Error signing in with credential: $e");
                                            // Handle error during sign-in
                                            // Show an error message or take appropriate action
                                          }
                                        }
                                      },
                                      child: Text('Register'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: AppBar(
                      centerTitle: false,
                      title: Container(
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                          width: 50,
                          height: 50,
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 16, top: 5),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "User",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.brown[100]),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Partner",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 20,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.notifications),
                                  color: Colors.blue[900], // Bell icon
                                  padding: EdgeInsets.zero, // No padding
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Contect us",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    "Hello Customer",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5),
                      ]),
                ),
                body: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          height: 53.h,
                          width: 100.w,
                          color: Colors.blue[900],
                        ),
                        Container(
                          height: 40.h,
                          width: 100.w,
                          color: Colors.brown[50],
                        ),
                      ],
                    ),
                    Positioned(
                      top: 90,
                      left: 30,
                      right: 30,
                      child: Container(
                        height: 450,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(31),
                            bottomRight: Radius.circular(31),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 6.h,
                                  child: Container(
                                    color: Colors.blueGrey[400],
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text('Join Us',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value ??
                                              0; // Use null-aware operator to handle null value
                                          print(
                                              'Selected value: $_selectedValue');
                                        });
                                      },
                                    ),
                                    Text('Enterprice')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value ??
                                              0; // Use null-aware operator to handle null value
                                          print(
                                              'Selected value: $_selectedValue');
                                        });
                                      },
                                    ),
                                    Text('Multiple Units'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value ??
                                              0; // Use null-aware operator to handle null value
                                          print(
                                              'Selected value: $_selectedValue');
                                        });
                                      },
                                    ),
                                    Text('Operator/Owner')
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: _selectedValue,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _selectedValue = value ??
                                              0; // Use null-aware operator to handle null value
                                          print(
                                              'Selected value: $_selectedValue');
                                        });
                                      },
                                    ),
                                    Text('owner')
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 60),
                            Padding(
                              padding: EdgeInsets.only(left: 260),
                              child: Row(
                                children: [
                                  Text('Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 260),
                                  child: SizedBox(
                                    height: 35,
                                    width: 400,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter Your name',
                                        contentPadding: EdgeInsets.all(5.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 260),
                              child: Row(
                                children: [
                                  Text('Mobile No',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 260),
                                  child: SizedBox(
                                    height: 35,
                                    width: 400,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter Your Mobile No',
                                        contentPadding: EdgeInsets.all(5.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                        suffixIcon: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue[
                                                900], // Set button color to blue
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  0), // Make button shape square
                                            ),
                                          ),
                                          onPressed: () {},
                                          child: Text('Verify'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.only(left: 260),
                              child: Row(
                                children: [
                                  Text('Email (Opational)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 260),
                                  child: SizedBox(
                                    height: 35,
                                    width: 400,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Enter Your Email',
                                        contentPadding: EdgeInsets.all(5.0),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(children: [
                              Padding(
                                padding: EdgeInsets.only(left: 285),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.indigo[
                                        800], // Set button color to blue
                                    foregroundColor: Colors.white,
                                    minimumSize:
                                        Size(230, 50), // Set button size
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Set button shape to rounded rectangle
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text('Register'),
                                ),
                              ),
                            ])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }
      });
    });
  }
}
