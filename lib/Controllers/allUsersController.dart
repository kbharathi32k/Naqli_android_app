import 'package:cloud_firestore/cloud_firestore.dart';

import 'allUsers.dart';
import 'allUsersFormController.dart';

class AllUsersController {
  AllUsersController({
    required this.formController,
  });
  final AllUsersFormController formController;

  static final AllUsersRef =
      FirebaseFirestore.instance.collection('greycollaruser');

  AllUsers get allUsers => formController.allUsers;

  Future<void> addAllUsers(AllUsersFormController controller) async {
    try {
      await controller.reference.set({
        'reference': controller.reference,
        'firstName': controller.firstName.text,
        'lastName': controller.lastName.text,
        'legalName': controller.legalName.text,
        'email': controller.email.text,
        'password': controller.password.text,
        'contactNumber': controller.contactNumber.text,
        'address': controller.address.text,
        'govtId': controller.selectedGovtId.text,
        'confirmPassword': controller.confirmPassword.text,
        'alternateNumber': controller.alternateNumber.text,
        'address2': controller.address2.text,
        'idNumber': controller.idNumber.text,
        'city': controller.selectedCity.text,
        'companyidNumber': controller.companyidNumber.text,
        'accounttype': controller.selectedAccounttype.text,
      }, SetOptions(merge: true));

      print('AllUsers added successfully');
    } catch (error) {
      print('Error adding AllUsers: $error');
      throw error;
    }
  }

  static Future<List<AllUsers>> loadStaffs(String search) {
    return AllUsersRef.where('search', arrayContains: search)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((e) => AllUsers.fromSnapshot(e)).toList();
    });
  }
}
