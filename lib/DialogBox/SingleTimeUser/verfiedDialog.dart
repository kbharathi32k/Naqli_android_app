import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Users/Enterprise/dashboard_page.dart';
import 'package:naqli_android_app/Users/SingleUser/dashboard_page.dart';
import 'package:naqli_android_app/Users/SuperUser/dashboard_page.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:sizer/sizer.dart';

import '../../availableVehicle.dart';
import '../../homePage.dart';

class VerifiedDialog extends StatefulWidget {
  String email;
  String password;
  String selectedAccounttype;

  VerifiedDialog(this.email, this.password, this.selectedAccounttype);

  @override
  _VerifiedDialogState createState() => _VerifiedDialogState();
}

class _VerifiedDialogState extends State<VerifiedDialog> {
  bool isVerified = false;
  String? storedVerificationId;
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController otpController = TextEditingController();
  AllUsersFormController controller = AllUsersFormController();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc('user_id').get();

      setState(() {
        firstName = userDoc['firstName'];
        lastName = userDoc['lastName'];
        phoneNumber = userDoc['phoneNumber'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
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

  Future<void> _createAccount(String uid, String selectedType) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );
      String userCollection;
      Map<String, dynamic> userData = {
        'firstName': controller.firstName.text,
        'lastName': controller.lastName.text,
        'email': controller.email.text,
        'password': controller.password.text,
        'contactNumber': controller.contactNumber.text,
        'address': controller.address.text,
        'alternateNumber': controller.alternateNumber.text,
        'address2': controller.address2.text,
        'city': controller.selectedCity.text,
        'accounttype': controller.selectedAccounttype.text,
      };

      if (selectedType == 'Enterprise') {
        userCollection = 'enterpriseuser';
        userData['legalName'] = controller.legalName.text;
        userData['companyidNumber'] = controller.companyidNumber.text;
      } else if (selectedType == 'User') {
        userCollection = 'user';
        userData['govtId'] = controller.selectedGovtId.text;
        userData['idNumber'] = controller.idNumber.text;
      } else if (selectedType == 'Super User') {
        userCollection = 'superuser';
        userData['govtId'] = controller.selectedGovtId.text;
        userData['idNumber'] = controller.idNumber.text;
      } else {
        throw Exception('Invalid selected type');
      }

      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(uid)
          .set(userData);
    } catch (e) {
      print("Data doesn't store : $e");
    }
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
          showErrorDialog(
              "Invalid phone number format. Please enter a valid 10-digit phone number.");
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                        );
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

  TextEditingController contactNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1180) {
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
                                  style: TabelText.helveticablack19),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.close),
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
                                        UserCredential userCredential =
                                            await FirebaseAuth.instance
                                                .signInWithCredential(
                                                    _credential);
                                        String userId =
                                            userCredential.user!.uid;
                                        if (userCredential.user != null) {
                                          String email = widget.email;
                                          String accountType =
                                              widget.selectedAccounttype;
                                          print(
                                              "User created: ${userCredential.user!.email}");
                                          print(
                                              'Account Type before create Account : $accountType');
                                          await _createAccount(
                                              userCredential.user!.uid,
                                              accountType);
                                          print('value passed$accountType');

                                          // Navigate to different pages based on selectedType
                                          if (accountType == 'Enterprise') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EnterDashboardPage(
                                                        user: userId),
                                              ),
                                            );
                                          } else if (accountType ==
                                              'Super User') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SuperUserDashboardPage(
                                                        user: userId),
                                              ),
                                            );
                                          } else if (accountType == 'User') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SingleUserDashboardPage(
                                                        user: userId),
                                              ),
                                            );
                                          } else {
                                            // Handle invalid selectedType
                                            print(
                                                'Invalid selected type: $accountType');
                                          }
                                        } else {
                                          showErrorDialog(
                                              "Invalid verification code. Please enter the correct code.");
                                        }
                                      } catch (e) {
                                        print(
                                            "Error signing in with credential: $e");
                                      }
                                    },
                                    color: Colors.black, // Setting icon color
                                  ),
                                ],
                              )
                            ],
                          )),
                        ),
                        Text('99999 99999',
                            style: TextStyle(
                              color: Color.fromRGBO(78, 68, 68, 1),
                              fontFamily: 'Helvetica',
                              fontSize: 18,
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
        } else {
          return Padding(
            padding: EdgeInsets.fromLTRB(2.w, 6.h, 2.w, 6.h),
            child: Dialog(
              child: SingleChildScrollView(
                child: Expanded(
                  child: Container(
                    width: 350,
                    height: 350,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(31),
                      ),
                    ),
                    padding: EdgeInsets.fromLTRB(1.5.w, 4.h, 1.5.w, 4.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              NetworkImage(
                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/approved.png?alt=media&token=1464e391-a8a7-4e1f-9ff8-90154603b7c9',
                              ),
                              color: Color.fromRGBO(60, 55, 148, 1),
                              size: 2,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Number Verified',
                              style: TextStyle(
                                fontFamily: 'Colfax',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('99999 99999',
                            style: TextStyle(
                              color: Color.fromRGBO(78, 68, 68, 1),
                              fontFamily: 'Helvetica',
                              fontSize: 18,
                            )),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          child: Divider(),
                        ),
                        SizedBox(height: 10),
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
