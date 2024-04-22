import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

import 'allUsers.dart';

class AllUsersFormController {
  AllUsersFormController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final legalName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final contactNumber = TextEditingController();
  final address = TextEditingController();
  final selectedGovtId = TextEditingController();
  final confirmPassword = TextEditingController();
  final alternateNumber = TextEditingController();
  final address2 = TextEditingController();
  final idNumber = TextEditingController();
  final selectedCity = TextEditingController();
  final fromDate = TextEditingController();
  final toDate = TextEditingController();
  final truck = TextEditingController();
  final truck1 = TextEditingController();
  final truck2 = TextEditingController();
  final truck3 = TextEditingController();
  final truck4 = TextEditingController();
  final truck5 = TextEditingController();
  final load = TextEditingController();
  final size = TextEditingController();
  final time = TextEditingController();
  final booking = TextEditingController();
  final companyidNumber = TextEditingController();
  final selectedAccounttype = TextEditingController();
  TextEditingController contactNumberError = TextEditingController();
  final selectedTypeName = TextEditingController();
  final selectedTypeName1 = TextEditingController();
  final selectedTypeName2 = TextEditingController();
  final selectedTypeName3 = TextEditingController();
  final selectedTypeName4 = TextEditingController();
  final selectedTypeName5 = TextEditingController();
  final selectedTypeName6 = TextEditingController();
  final selectedTypeName7 = TextEditingController();
  final selectedTypeName8 = TextEditingController();
  final unitClassi = TextEditingController();
  final subClassi = TextEditingController();
  final plateInfo = TextEditingController();
  final istimaraNo = TextEditingController();
  final iqamaNo = TextEditingController();
  final dob = TextEditingController();
  final operPlatInfo = TextEditingController();
  final partnerName = TextEditingController();
  final otp = TextEditingController();
  final equip = TextEditingController();
  final date = TextEditingController();

  // String get newDocId => FirebaseFirestore.instance.collection('AllUserss').doc().id;

  DocumentReference? _reference;

  DocumentReference get reference {
    _reference ??= FirebaseFirestore.instance.collection('enterprise').doc();
    return _reference!;
  }

  AllUsers get allUsers => AllUsers(
        reference: reference,
        firstName: firstName.text,
        lastName: lastName.text,
        legalName: legalName.text,
        email: email.text,
        password: password.text,
        contactNumber: contactNumber.text,
        address: address.text,
        govtId: selectedGovtId.text,
        confirmPassword: confirmPassword.text,
        alternateNumber: alternateNumber.text,
        address2: address2.text,
        idNumber: idNumber.text,
        city: selectedCity.text,
        companyidNumber: companyidNumber.text,
        accounttype: selectedAccounttype.text,
      );
}
