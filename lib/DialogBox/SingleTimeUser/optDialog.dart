import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/verfiedDialog.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:sizer/sizer.dart';

import '../../createAccount.dart';
import '../../homePage.dart';

class OTPDialog extends StatefulWidget {
  final String? verificationId;
  OTPDialog({required this.verificationId});

  @override
  _OTPDialogState createState() => _OTPDialogState();
}

class _OTPDialogState extends State<OTPDialog> {
  bool isVerified = false;
  AllUsersFormController controller = AllUsersFormController();
  TextEditingController otpController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();
  TextEditingController otp5 = TextEditingController();
  TextEditingController otp6 = TextEditingController();
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
    RegExp regex = RegExp(r'^[0-9]{10}$');
    return regex.hasMatch(phoneNumber);
  }

  Future<void> verifyOTP(
      BuildContext context,
      String verificationId,
      String otp1,
      String otp2,
      String otp3,
      String otp4,
      String otp5,
      String otp6) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      String smsCode = otpController.text;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final result = await auth.signInWithCredential(credential);
      if (result.user != null) {
        print("OTP verified successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        showErrorDialog(
          "Invalid verification code. Please enter the correct code.",
        );
      }
    } catch (e) {
      print("Error signing in with credential: $e");
      showErrorDialog("Error verifying OTP. Please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1180) {
          return Padding(
            padding: EdgeInsets.fromLTRB(18.w, 27.h, 18.w, 27.h),
            child: SingleChildScrollView(
              child: Expanded(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(31))),
                  child: Container(
                    height: 360,
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
                                child: Text('Verify',
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
                        Text('Your code was sent to your mobile no',
                            style: DialogText.helvetica25black),
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
                        SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () async {
                              await verifyOTP(
                                context,
                                otp1.text,
                                otp2.text,
                                otp3.text,
                                otp4.text,
                                otp5.text,
                                otp6.text,
                                widget.verificationId ??
                                    '', // Accessing the verificationId passed to OTPDialog
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(60, 55, 148, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11),
                                )),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 1.w,
                                right: 1.w,
                              ),
                              child:
                                  Text("Verify", style: DialogText.helvetica20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 5.w),
                          child: Divider(
                            color: Color.fromRGBO(112, 112, 112, 1),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Didn't receive OTP ?",
                                style: HomepageText.helvetica16black),
                            InkWell(
                              child: Text(' Resend',
                                  style: DialogText.purplehelveticabold),
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
                        Text(
                          'Enter Mobile NO',
                          style: TextStyle(
                            fontFamily: 'Colfax',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 30,
                          width: 200,
                          child: TextField(
                            controller: contactNumberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0)),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              String email = controller.email.text;
                              String password = controller.password.text;
                              String selectedAccounttype =
                                  controller.selectedAccounttype.text;
                              showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return VerifiedDialog(
                                      email, password, selectedAccounttype);
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(60, 55, 148, 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                )),
                            child: Text(
                              "Get OTP",
                              style: TextStyle(
                                fontFamily: 'Colfax',
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w, right: 2.w),
                          child: Divider(),
                        ),
                        SizedBox(height: 10),
                        Text("Didn't receive an email? ",
                            style: TabelText.helvetica),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            // Implement the logic to resend the OTP
                            // For now, let's close the dialog
                            Navigator.pop(context);
                          },
                          child: Text("Resend.",
                              style: FormTextStyle.purplehelvetica),
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
