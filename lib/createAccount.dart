import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naqli_android_app/Controllers/allUsersFormController.dart';
import 'package:naqli_android_app/Users/Enterprise/dashboard_page.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/mblNoDialog.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/optDialog.dart';
import 'package:naqli_android_app/Users/SingleUser/dashboard_page.dart';
import 'package:naqli_android_app/Users/SuperUser/dashboard_page.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/customDropdown.dart';
import 'package:naqli_android_app/Widgets/customTextField.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/loginPage.dart';
import 'package:sizer/sizer.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount();

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController contactNumberController = TextEditingController();

  List<String> cities = ['City 1', 'City 2', 'City 3', 'City 4'];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isVerified = false;
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String enterpriseSelect = 'User';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ScrollController _Scroll1 = ScrollController();
  AllUsersFormController controller = AllUsersFormController();
  TextEditingController otpController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 1180) {
          return Padding(
            padding: EdgeInsets.only(
              left: 18.w,
              right: 18.w,
              top: 8.h,
              bottom: 8.h,
            ),
            child: Scrollbar(
              controller: _Scroll1,
              thumbVisibility: true,
              child: SingleChildScrollView(
                controller: _Scroll1,
                scrollDirection: Axis.vertical,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(31))),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 5.w, right: 5.w, top: 50, bottom: 45),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(31)),
                    height: 770,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SizedBox()),
                              Text(
                                'Create your account',
                                style: LoginpageText.helvetica30bold,
                              ),
                              Expanded(child: SizedBox()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ImageIcon(
                                  NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('First Name',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('Email Address',
                                      style: HomepageText.helvetica16black),
                                ],
                              ),
                              SizedBox(
                                width: 42,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: CustomTextfield(
                                          validator: nameValidator,
                                          controller: controller.firstName,
                                          text: 'First Name',
                                        )),
                                        SizedBox(width: 25),
                                        Expanded(
                                            child: CustomTextfield(
                                          validator: nameValidator,
                                          controller: controller.lastName,
                                          text: 'Last Name',
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextfield(
                                      controller: controller.email,
                                      validator: emailValidator,
                                      text: 'Email address',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Password',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('Contact Number',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('Address 1',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('City',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text(
                                      enterpriseSelect == 'Enterprise'
                                          ? 'Company ID No'
                                          : 'Govt ID',
                                      style: HomepageText.helvetica16black),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextfield(
                                      controller: controller.password,
                                      validator: validatePassword,
                                      text: 'Password',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextfield(
                                      controller: controller.contactNumber,
                                      validator: (value) {
                                        if (value!.length != 10)
                                          return 'Mobile Number must be of 10 digit';
                                        else
                                          return null;
                                      },
                                      text: 'Phone Number',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextfield(
                                      controller: controller.address,
                                      validator: nameValidator,
                                      text: 'Address',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomDropDown(
                                      value: controller
                                              .selectedCity.text.isNotEmpty
                                          ? controller.selectedCity.text
                                          : 'Select',
                                      items: [
                                        'City 1',
                                        'City 2',
                                        'City 3',
                                        'City 4',
                                        'Select'
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          controller.selectedCity.text =
                                              newValue!;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    enterpriseSelect == 'Enterprise'
                                        ? CustomTextfield(
                                            validator: (value) {
                                              if (value!.length != 10)
                                                return 'Mobile Number must be of 10 digit';
                                              else
                                                return null;
                                            },
                                            controller:
                                                controller.companyidNumber,
                                            text: 'Id number',
                                          )
                                        : CustomDropDown(
                                            value: controller.selectedGovtId
                                                    .text.isNotEmpty
                                                ? controller.selectedGovtId.text
                                                : 'Select',
                                            items: [
                                              'National ID',
                                              'Iqama No.',
                                              'Visit Visa / Border No',
                                              'Select',
                                            ],
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                controller.selectedGovtId.text =
                                                    newValue!;
                                              });
                                            },
                                          ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Confirm Password',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('Alternate Number',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('Address 2',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text('Account Type',
                                      style: HomepageText.helvetica16black),
                                  SizedBox(
                                    height: 45,
                                  ),
                                  Text(
                                      enterpriseSelect == 'Enterprise'
                                          ? 'Legal Name'
                                          : 'ID Number',
                                      style: HomepageText.helvetica16black),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextfield(
                                      controller: controller.confirmPassword,
                                      validator: validatePassword,
                                      text: 'Confirm Password',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextfield(
                                      validator: (value) {
                                        if (value!.length != 10)
                                          return 'Mobile Number must be of 10 digit';
                                        else
                                          return null;
                                      },
                                      controller: controller.alternateNumber,
                                      text: 'Phone Number',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextfield(
                                      validator: nameValidator,
                                      controller: controller.address2,
                                      text: 'Address',
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    CustomDropDown(
                                      value: controller.selectedAccounttype.text
                                              .isNotEmpty
                                          ? controller.selectedAccounttype.text
                                          : 'Select',
                                      items: <String>[
                                        'User',
                                        'Super User',
                                        'Enterprise',
                                        'Select',
                                      ],
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          controller.selectedAccounttype.text =
                                              newValue!;
                                          enterpriseSelect = controller
                                              .selectedAccounttype.text;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    enterpriseSelect == 'Enterprise'
                                        ? CustomTextfield(
                                            validator: nameValidator,
                                            controller: controller.legalName,
                                            text: 'Leagl name',
                                          )
                                        : CustomTextfield(
                                            validator: (value) {
                                              if (value!.length != 10)
                                                return 'Mobile Number must be of 10 digit';
                                              else
                                                return null;
                                            },
                                            controller: controller.idNumber,
                                            text: 'ID Number',
                                          ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GradientButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String email = controller.email.text;
                                    String password = controller.password.text;
                                    String selectedAccounttype =
                                        controller.selectedAccounttype.text;

                                    String firstName =
                                        controller.firstName.text;
                                    String lastName = controller.lastName.text;
                                    String legalName =
                                        controller.legalName.text;
                                    String contactNumber =
                                        controller.contactNumber.text;
                                    String address = controller.address.text;
                                    String govtId =
                                        controller.selectedGovtId.text;
                                    String confirmPassword =
                                        controller.confirmPassword.text;
                                    String alternateNumber =
                                        controller.alternateNumber.text;
                                    String address2 = controller.address2.text;
                                    String idNumber = controller.idNumber.text;
                                    String city = controller.selectedCity.text;
                                    String companyidNumber =
                                        controller.companyidNumber.text;
                                    UserCredential userCredential = await _auth
                                        .createUserWithEmailAndPassword(
                                      email: controller.email.text,
                                      password: controller.password.text,
                                    );
                                    // User creation successful
                                    String adminUid = userCredential.user!.uid;
                                    String accountType =
                                        controller.selectedAccounttype.text;
                                    print(
                                        "User created: ${userCredential.user!.email}");
                                    print(
                                        'Account Type before create Account : $accountType');
                                    await _createAccount(
                                        userCredential.user!.uid, accountType);
                                    print('value passed$accountType');
                                    print("track1");
                                    showDialog(
                                      barrierColor:
                                          Colors.grey.withOpacity(0.5),
                                      context: context,
                                      builder: (context) {
                                        return MblNoDialog(
                                          email: email,
                                          password: password,
                                          selectedAccounttype:
                                              selectedAccounttype,
                                          firstName: firstName,
                                          legalName: legalName,
                                          lastName: legalName,
                                          confirmPassword: confirmPassword,
                                          contactNumber: contactNumber,
                                          address2: address2,
                                          address: address,
                                          govtId: govtId,
                                          alternateNumber: alternateNumber,
                                          idNumber: idNumber,
                                          city: city,
                                          companyidNumber: companyidNumber,
                                          adminUid: adminUid,
                                        );
                                      },
                                    );
                                  }
                                },
                                text: 'Create Account',
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    fixedSize:
                                        const Size.fromWidth(double.infinity),
                                    backgroundColor:
                                        Color.fromRGBO(112, 112, 112, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          7), // Adjust border radius as needed
                                    ),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(3.w, 0, 3.w, 0),
                                    child: Text('Cancel',
                                        style: LoginpageText.helvetica16white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account? ',
                                  style: HomepageText.helvetica16black),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Color.fromRGBO(128, 123, 229, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: const Color.fromRGBO(112, 112, 112, 1),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('By Clicking Sign up, you agree to the ',
                                  style: HomepageText.helvetica16black),
                              Text(
                                'Terms & Privacy policy.',
                                style: TextStyle(
                                  color: Color.fromRGBO(128, 123, 229, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Padding(
              padding: EdgeInsets.only(
                left: 18.w,
                right: 18.w,
                top: 8.h,
                bottom: 8.h,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(31))),
                child: Container(
                  padding: EdgeInsets.only(
                      left: 5.w, right: 5.w, top: 50, bottom: 45),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(31)),
                  height: 770,
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: SizedBox()),
                              Text(
                                'Create your account',
                                style: LoginpageText.helvetica30bold,
                              ),
                              Expanded(child: SizedBox()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: ImageIcon(
                                  NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/cancel.png?alt=media&token=dd1ed39b-abda-4780-94dd-f5c15e7d12f5'),
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text('First Name ',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                  child: CustomTextfield(
                                // validator: nameValidator,
                                controller: controller.firstName,
                                text: 'First Name',
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text('Last Name',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                  child: CustomTextfield(
                                // validator: nameValidator,
                                controller: controller.lastName,
                                text: 'Last Name',
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  width: 150,
                                  child: Text('Email Address',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  controller: controller.email,
                                  validator: emailValidator,
                                  text: 'Email address',
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
                                  child: Text('Password',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  controller: controller.password,
                                  validator: validatePassword,
                                  text: 'Password',
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
                                  child: Text('Confirm Password',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  controller: controller.confirmPassword,
                                  validator: validatePassword,
                                  text: 'Confirm Password',
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
                                  child: Text('Contact Number',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  validator: (value) {
                                    if (value!.length != 10)
                                      return 'Mobile Number must be of 10 digit';
                                    else
                                      return null;
                                  },
                                  controller: controller.contactNumber,
                                  text: 'Phone Number',
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
                                  child: Text('Alternate Number',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  validator: (value) {
                                    if (value!.length != 10)
                                      return 'Mobile Number must be of 10 digit';
                                    else
                                      return null;
                                  },
                                  controller: controller.alternateNumber,
                                  text: 'Phone Number',
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
                                  child: Text('Address 1',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  validator: nameValidator,
                                  controller: controller.address,
                                  text: 'Address',
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
                                  child: Text('Address 2',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomTextfield(
                                  validator: nameValidator,
                                  controller: controller.address2,
                                  text: 'Address',
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
                                  child: Text('Çity',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomDropDown(
                                  value: controller.selectedCity.text.isNotEmpty
                                      ? controller.selectedCity.text
                                      : 'Select',
                                  items: [
                                    'City 1',
                                    'City 2',
                                    'City 3',
                                    'City 4',
                                    'Select',
                                  ],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      controller.selectedCity.text = newValue!;
                                    });
                                  },
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
                                  child: Text('Account Type',
                                      style: HomepageText.helvetica16black)),
                              SizedBox(width: 5),
                              Expanded(
                                child: CustomDropDown(
                                  value: controller
                                          .selectedAccounttype.text.isNotEmpty
                                      ? controller.selectedAccounttype.text
                                      : 'Select',
                                  items: <String>[
                                    'User',
                                    'Super User',
                                    'Enterprise',
                                    'Select',
                                  ],
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      controller.selectedAccounttype.text =
                                          newValue!;
                                      enterpriseSelect =
                                          controller.selectedAccounttype.text;
                                    });
                                  },
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
                                    enterpriseSelect == 'Enterprise'
                                        ? 'Company ID No'
                                        : 'Govt ID',
                                    style: HomepageText.helvetica16black),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: enterpriseSelect == 'Enterprise'
                                    ? CustomTextfield(
                                        // validator: nameValidator,
                                        controller: controller.companyidNumber,
                                        text: 'Id number',
                                      )
                                    : CustomDropDown(
                                        value: controller
                                                .selectedGovtId.text.isNotEmpty
                                            ? controller.selectedGovtId.text
                                            : 'Select',
                                        items: [
                                          'National ID',
                                          'Iqama No.',
                                          'Visit Visa / Border No',
                                          'Select',
                                        ],
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            controller.selectedGovtId.text =
                                                newValue!;
                                          });
                                        },
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
                                    enterpriseSelect == 'Enterprise'
                                        ? 'Legal Name'
                                        : 'ID Number',
                                    style: HomepageText.helvetica16black),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: enterpriseSelect == 'Enterprise'
                                    ? CustomTextfield(
                                        validator: nameValidator,
                                        controller: controller.legalName,
                                        text: 'Leagl name',
                                      )
                                    : CustomTextfield(
                                        validator: (value) {
                                          if (value!.length != 10)
                                            return 'Mobile Number must be of 10 digit';
                                          else
                                            return null;
                                        },
                                        controller: controller.idNumber,
                                        text: 'ID Number',
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      try {
                                        UserCredential userCredential =
                                            await _auth
                                                .createUserWithEmailAndPassword(
                                          email: controller.email.text,
                                          password: controller.password.text,
                                        );
                                        // User creation successful
                                        String accountType =
                                            controller.selectedAccounttype.text;
                                        print(
                                            "User created: ${userCredential.user!.email}");
                                        print(
                                            'Account Type before create Account : $accountType');
                                        await _createAccount(
                                            userCredential.user!.uid,
                                            accountType);
                                        print('value passed$accountType');
                                      } catch (e) {
                                        print("Error creating user: $e");
                                      }
                                      print("track1");
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 128, 123, 229),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontFamily: 'Colfax',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    fixedSize:
                                        const Size.fromWidth(double.infinity),
                                    backgroundColor:
                                        Color.fromARGB(112, 112, 112, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // Adjust border radius as needed
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
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
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have an account? ',
                                  style: HomepageText.helvetica16black),
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Color.fromRGBO(128, 123, 229, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: const Color.fromRGBO(112, 112, 112, 1),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('By Clicking Sign up, you agree to the ',
                                  style: HomepageText.helvetica16black),
                              Text(
                                'Terms & Privacy policy.',
                                style: TextStyle(
                                  color: Color.fromRGBO(128, 123, 229, 1),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        }
      });
    });
  }

  Future<void> _createAccount(
    String uid,
    String selectedType,
  ) async {
    try {
      Random random = Random();

      String bookingID = '';
      for (int i = 0; i < 10; i++) {
        bookingID += random.nextInt(10).toString();
      }
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
        'userId': bookingID,
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
}
