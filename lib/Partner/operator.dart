import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Partner/Dashboard/bookings.dart';
import 'package:naqli_android_app/Partner/Dashboard/dashboard_page.dart';
import 'package:sizer/sizer.dart';

class Operator extends StatefulWidget {
  final String? user;
  const Operator({this.user});

  @override
  _OperatorState createState() => _OperatorState();
}

class _OperatorState extends State<Operator> {
  final _formKey = GlobalKey<FormState>();

  List<String> cities = ['City 1', 'City 2', 'City 3', 'City 4'];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AllUsersFormController controller = AllUsersFormController();
  String? selectedCity;
  String? selectedType;
  String? selectedUnitOption;
  String? selectedSubOption;
  bool isVerified = false;
  int? groupValue = 1;
  late int _selectedValue = 0;
  late String operatorID;
  TextEditingController opfirstNameController = TextEditingController();
  TextEditingController oplastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController plateController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController subController = TextEditingController();

  TextEditingController contactNumberController = TextEditingController();
  TextEditingController panelinfoController = TextEditingController();

  TextEditingController dobController = TextEditingController();
  TextEditingController iqamaController = TextEditingController();

  TextEditingController istimaraController = TextEditingController();
  // TextEditingController idNumberController = TextEditingController();
  TextEditingController mobilenoController = TextEditingController();
  TextEditingController accounttypeController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String _generateBookingID() {
    Random random = Random();

    String operatorID = '';
    for (int i = 0; i < 10; i++) {
      operatorID += random.nextInt(10).toString();
    }
    return operatorID;
  }

  void initState() {
    super.initState();
    operatorID = _generateBookingID();
  }

  Future<String> createOperator(
    String unit,
    String sub,
    String plateNo,
    String istimaraNo,
    String name,
    String email,
    String mblNo,
    String iqamaNo,
    String dob,
    String plateinfo,
    String operName,
    String operatorid,
    String user,
  ) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user's document
      DocumentReference partneruserDocRef =
          firestore.collection('partneruser').doc(user);

      // Reference to the subcollection 'userBooking' under the user's document
      CollectionReference partneruserRegCollectionRef =
          partneruserDocRef.collection('operatorReg');

      // Add document to subcollection and get the document reference
      DocumentReference newOperatorDocRef =
          await partneruserRegCollectionRef.add({
        'unit': unit,
        'sub': sub,
        'plateNo': plateNo,
        'istimara': istimaraNo,
        'name': name,
        'email': email,
        'mblno': mblNo,
        'iqamaNo': iqamaNo,
        'dob': dob,
        'plateinfo': plateinfo,
        'operName': operName,
        'operId': operatorID,
      });

      // Store the auto-generated ID
      String newOperatorId = newOperatorDocRef.id;

      // Update the document with the stored ID
      // await newBookingDocRef.update({'id': newBookingId});

      print('New booking added successfully with ID: $newOperatorId');
      return newOperatorId;
    } catch (error) {
      print('Error creating new booking: $error');
      return '';
    }
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

  Future<void> _startPhoneAuth(String phoneNumber) async {
    print("track3");

    FirebaseAuth _auth = FirebaseAuth.instance;

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
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {
          // Store the verification ID for later use (e.g., resend OTP)
          String storedVerificationId = verificationId;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text("Enter OTP"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: otpController,
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    String smsCode = otpController.text;
                    PhoneAuthCredential _credential =
                        PhoneAuthProvider.credential(
                      verificationId: storedVerificationId,
                      smsCode: smsCode,
                    );

                    auth.signInWithCredential(_credential).then((result) {
                      // Check if the verification is successful
                      if (result.user != null) {
                        print("otp verified successfully");

                        setState(() {
                          isVerified = true;
                        });
                      } else {
                        showErrorDialog(
                            "Invalid verification code. Please enter the correct code.");
                      }
                    }).catchError((e) {
                      print("Error signing in with credential: $e");
                    });
                  },
                  child: Text("Done"),
                ),
              ],
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle code auto retrieval timeout (optional)
        },
      );
    } catch (e) {
      print('Error during phone authentication: $e');
    }
  }

  void _showOtpVerificationDialog() {
    print("track4");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Verification"),
          content: Column(
            children: [
              Text("Enter OTP"),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'OTP',
                ),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            InkWell(
              onTap: () async {
                // Validate OTP and proceed if valid
                String enteredOtp = otpController.text;
                if (enteredOtp.isNotEmpty) {
                  // You can add OTP validation logic here
                  // If the OTP is valid, you can perform further actions
                  // For now, let's just close the dialog
                  Navigator.of(context).pop();
                } else {
                  // Handle case where OTP is empty
                }
              },
              child: Text("Verify"),
            ),
          ],
        );
      },
    );
  }

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
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
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

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 900) {
          return Dialog(
            child: Container(
              width: 1100,
              height: 850,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(206, 205, 205, 1),
                    offset: Offset(0, 1),
                    spreadRadius: 0.5,
                    blurRadius: 0.1, // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(31),
                  bottomLeft: Radius.circular(31),
                  topRight: Radius.circular(31),
                  bottomRight: Radius.circular(31),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 100, right: 100, top: 50, bottom: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          'Operator/Owner',
                          style: TextStyle(
                              fontFamily: 'HelveticaNeueRegular',
                              fontSize: 44,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(106, 102, 209, 1)),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 30,
                              child: Text(
                                "Unit",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Helvetica",
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Text('Vehicle')
                                  ],
                                ),
                              ],
                            ),
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
                                    print('Selected value: $_selectedValue');
                                  });
                                },
                              ),
                              Text('Bus')
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
                                    print('Selected value: $_selectedValue');
                                  });
                                },
                              ),
                              Text('Equipment')
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
                                    print('Selected value: $_selectedValue');
                                  });
                                },
                              ),
                              Text('Special')
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 5,
                                groupValue: _selectedValue,
                                onChanged: (int? value) {
                                  setState(() {
                                    _selectedValue = value ??
                                        0; // Use null-aware operator to handle null value
                                    print('Selected value: $_selectedValue');
                                  });
                                },
                              ),
                              Text('Others')
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Unit Classification',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 275,
                                child: DropdownButtonFormField<String>(
                                  value: controller.unitClassi.text.isNotEmpty
                                      ? controller.unitClassi.text
                                      : 'Vehicle',
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      controller.unitClassi.text = newValue!;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'Vehicle',
                                      child: Text('Vehicle'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Bus',
                                      child: Text('Bus'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Equipment',
                                      child: Text('Equipment'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Sub Classification',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 275,
                                child: DropdownButtonFormField<String>(
                                  value: controller.subClassi.text.isNotEmpty
                                      ? controller.subClassi.text
                                      : 'Vehicle',
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 2.0, horizontal: 10.0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      controller.subClassi.text = newValue!;
                                    });
                                  },
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: 'Vehicle',
                                      child: Text('Vehicle'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Bus',
                                      child: Text('Bus'),
                                    ),
                                    DropdownMenuItem<String>(
                                      value: 'Equipment',
                                      child: Text('Equipment'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Plate Information',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 275,
                            child: TextFormField(
                              controller: controller.plateInfo,
                              validator: validatePassword,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Segoe",
                                    color: Color.fromRGBO(112, 112, 112, 1)
                                        .withOpacity(0.5)),
                                hintText: 'Enter your mobile no',
                                contentPadding: EdgeInsets.all(0.9.w),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Istimara no',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 275,
                                child: TextFormField(
                                  controller: controller.istimaraNo,
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Segoe",
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.5)),
                                    hintText: 'Enter your mobile no',
                                    contentPadding: EdgeInsets.all(0.9.w),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Istimara Card',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 45,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Wrap(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Your onTap functionality here
                                      },
                                      child: Row(
                                        children: [
                                          Image.network(
                                            'assets/cancel.png', // Assuming you have an image asset named 'upload_icon.png' in your assets folder
                                            width: 17,
                                            height: 17,
                                            // color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Upload a file',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Helvetica",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(width: 165),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Picture of Vehicle',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 45,
                                  width: 160,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Wrap(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Your onTap functionality here
                                          },
                                          child: Row(
                                            children: [
                                              Image.network(
                                                'assets/cancel.png', // Assuming you have an image asset named 'upload_icon.png' in your assets folder
                                                width: 17,
                                                height: 17,
                                                // color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Upload a file',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Helvetica",
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        child: Divider(
                          color: Color.fromRGBO(112, 112, 112, 1),
                          thickness: 1,
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Operator',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 352,
                                child: TextFormField(
                                  controller: controller.firstName,
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Segoe",
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.5)),
                                    hintText: 'First Name',
                                    contentPadding: EdgeInsets.all(0.9.w),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 45),
                          Row(
                            children: [
                              SizedBox(
                                height: 45,
                                width: 352,
                                child: TextFormField(
                                  controller: controller.lastName,
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Segoe",
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.5)),
                                    hintText: 'Last Name',
                                    contentPadding: EdgeInsets.all(0.9.w),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: 150,
                              child: Text(
                                'Email ID',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Helvetica",
                                ),
                              )),
                          Expanded(
                            child: SizedBox(
                              height: 45,
                              child: TextFormField(
                                controller: controller.email,
                                validator: emailValidator,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "Segoe",
                                      color: Color.fromRGBO(112, 112, 112, 1)
                                          .withOpacity(0.5)),
                                  hintText: 'Email address',
                                  contentPadding: EdgeInsets.all(0.9.w),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Mobile No',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 275,
                            child: TextFormField(
                              controller: controller.contactNumber,
                              validator: validatePassword,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Segoe",
                                    color: Color.fromRGBO(112, 112, 112, 1)
                                        .withOpacity(0.5)),
                                hintText: 'Enter your mobile no',
                                contentPadding: EdgeInsets.all(0.9.w),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Iqama No',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 275,
                                child: TextFormField(
                                  controller: controller.iqamaNo,
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Segoe",
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.5)),
                                    hintText: 'XXXXXXXXXX',
                                    contentPadding: EdgeInsets.all(0.9.w),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Date of Birth',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 45,
                            width: 275,
                            child: TextFormField(
                              controller: controller.dob,
                              validator: validatePassword,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: 13,
                                    fontFamily: "Segoe",
                                    color: Color.fromRGBO(112, 112, 112, 1)
                                        .withOpacity(0.5)),
                                hintText: 'DD/MM/YYYY',
                                labelText: 'Date of birth',
                                contentPadding: EdgeInsets.all(0.9.w),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 50),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Panel Information',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 45,
                                width: 275,
                                child: TextFormField(
                                  controller: controller.operPlatInfo,
                                  validator: validatePassword,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Segoe",
                                        color: Color.fromRGBO(112, 112, 112, 1)
                                            .withOpacity(0.5)),
                                    hintText: 'XXXXXXXXXX',
                                    contentPadding: EdgeInsets.all(0.9.w),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Driving License',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Helvetica",
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 45,
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Wrap(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Your onTap functionality here
                                      },
                                      child: Row(
                                        children: [
                                          Image.network(
                                            'assets/cancel.png', // Assuming you have an image asset named 'upload_icon.png' in your assets folder
                                            width: 17,
                                            height: 17,
                                            // color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Upload a file',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontFamily: "Helvetica",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          SizedBox(width: 165),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'National ID',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 45,
                                  width: 160,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: Wrap(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Your onTap functionality here
                                          },
                                          child: Row(
                                            children: [
                                              Image.network(
                                                'assets/cancel.png', // Assuming you have an image asset named 'upload_icon.png' in your assets folder
                                                width: 17,
                                                height: 17,
                                                // color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Upload a file',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontFamily: "Helvetica",
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 27,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () async {
                                print("track1");
                                await _startPhoneAuth(
                                    contactNumberController.text);
                                // _showOtpVerificationDialog();
                                // Save user data and start phone authentication

                                String unit = controller.unitClassi.text;
                                String sub = controller.subClassi.text;
                                String plateNo = controller.plateInfo.text;
                                String istimaraNo = controller.istimaraNo.text;

                                String name =
                                    '${opfirstNameController.text} ${oplastNameController.text}';
                                String email = controller.email.text;
                                String mblno = controller.contactNumber.text;
                                String iqamaNo = controller.iqamaNo.text;
                                String dob = controller.dob.text;
                                String plateinfo = controller.operPlatInfo.text;
                                String operName = controller.partnerName.text;
                                String operatorid = operatorID;
                                await createOperator(
                                  unit,
                                  sub,
                                  plateNo,
                                  istimaraNo,
                                  name,
                                  email,
                                  mblno,
                                  iqamaNo,
                                  dob,
                                  plateinfo,
                                  operName,
                                  operatorid,
                                  widget.user!,
                                );

                                // Navigate to the desired class after submitting
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PartnerDashboardPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 128, 123, 229),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontFamily: 'Colfax',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Dialog(
              child: SingleChildScrollView(
                  child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(31),
                  bottomLeft: Radius.circular(31),
                  topRight: Radius.circular(31),
                  bottomRight: Radius.circular(31),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 2.5.h, right: 2.5.h, top: 3.w, bottom: 3.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          'Driver/Owner',
                          style: TextStyle(
                            fontFamily: 'ColfaxBold',
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 150, child: Text('First Name ')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: opfirstNameController,
                                validator: nameValidator,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'First Name',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal:
                                          10.0), // Adjust padding as needed
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Last Name')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: oplastNameController,
                                validator: nameValidator,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'Last Name',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Email ID')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: emailController,
                                validator: emailValidator,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'Email address',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Mobile No')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'Enter your mobile no',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Iqama No')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'XXXXXXXXXX',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Date of birth')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'DD/MM/YYYY',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                              width: 150, child: Text('Panel Information')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(fontSize: 12),
                                  hintText: 'XXXXXXXXXX',
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Unit Type')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: DropdownButtonFormField<String>(
                                value: selectedSubOption,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSubOption = newValue;
                                  });
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Vehicle',
                                    child: Text('Vehicle'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Bus',
                                    child: Text('Bus'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Equipment',
                                    child: Text('Equipment'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Classification')),
                          SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: DropdownButtonFormField<String>(
                                value: selectedSubOption,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(5.0),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSubOption = newValue;
                                  });
                                },
                                items: [
                                  DropdownMenuItem<String>(
                                    value: 'Vehicle',
                                    child: Text('Vehicle'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Bus',
                                    child: Text('Bus'),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: 'Equipment',
                                    child: Text('Equipment'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('Driving License')),
                          SizedBox(width: 5),
                          SizedBox(
                            height: 40,
                            width: 160,
                            child: Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  'Upload a file',
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 3, 3, 1)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('ID Copy')),
                          SizedBox(width: 5),
                          SizedBox(
                            height: 40,
                            width: 160,
                            child: Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  'Upload a file',
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 3, 3, 1)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 150, child: Text('National ID')),
                          SizedBox(width: 5),
                          SizedBox(
                            height: 40,
                            width: 160,
                            child: Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  'Upload a file',
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 3, 3, 1)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Picture of',
                                    style: TextStyle(fontSize: 15)),
                                Text('Equipment/Vehicle',
                                    style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                          SizedBox(width: 5),
                          SizedBox(
                            height: 40,
                            width: 160,
                            child: Expanded(
                              child: ElevatedButton(
                                child: Text(
                                  'Upload a file',
                                  style: TextStyle(
                                      color: Color.fromRGBO(20, 3, 3, 1)),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 2,
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  print("track1");
                                  await _startPhoneAuth(
                                      contactNumberController.text);
                                  // _showOtpVerificationDialog();
                                  // Save user data and start phone authentication
                                  String unit = controller.unitClassi.text;
                                  String sub = controller.subClassi.text;
                                  String plateNo = controller.plateInfo.text;
                                  String istimaraNo =
                                      controller.istimaraNo.text;

                                  String name =
                                      '${opfirstNameController.text} ${oplastNameController.text}';
                                  String email = controller.email.text;
                                  String mblno = controller.contactNumber.text;
                                  String iqamaNo = controller.iqamaNo.text;
                                  String dob = controller.dob.text;
                                  String plateinfo =
                                      controller.operPlatInfo.text;
                                  String operName = controller.partnerName.text;
                                  String operatorid = operatorID;
                                  await createOperator(
                                      unit,
                                      sub,
                                      plateNo,
                                      istimaraNo,
                                      name,
                                      email,
                                      mblno,
                                      iqamaNo,
                                      dob,
                                      plateinfo,
                                      operName,
                                      operatorid,
                                      widget.user!);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize:
                                    const Size.fromWidth(double.infinity),
                                backgroundColor:
                                    Color.fromARGB(255, 128, 123, 229),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5), // Adjust border radius as needed
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                  fontFamily: 'Colfax',
                                  fontSize: 16,
                                  color: Colors.white,
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
            ),
          )));
        }
      });
    });
  }
}
