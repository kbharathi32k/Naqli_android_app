import 'package:cloud_firestore/cloud_firestore.dart';

class AllUsers {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? confirmPassword;
  String? contactNumber;
  String? alternateNumber;
  String? address;
  String? address2;
  String? city;
  String? accounttype;
  String? govtId;
  String? idNumber;
  String? companyidNumber;
  String? legalName;

  DocumentReference? reference;
  String? selectedOption;

  AllUsers({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    this.contactNumber,
    this.alternateNumber,
    this.address,
    this.address2,
    this.city,
    this.accounttype,
    this.govtId,
    this.idNumber,
    this.companyidNumber,
    this.legalName,
    this.selectedOption,
    this.reference,
  });

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "contactNumber": contactNumber,
        "alternameNumber": alternateNumber,
        "address": address,
        "address2": address2,
        "city": city,
        "accounttype": accounttype,
        "govtId": govtId,
        "idNumber": idNumber,
        "companyidNumber": companyidNumber,
        "legalName": legalName,
        "reference": reference,
      };

  static AllUsers fromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return AllUsers(
        firstName: data["firstName"],
        lastName: data["lastName"],
        email: data["email"],
        password: data["password"],
        confirmPassword: data["confirmPassword"],
        contactNumber: data["contactNumber"],
        alternateNumber: data["alternateNumber"],
        address: data["address"],
        address2: data["address2"],
        city: data["city"],
        accounttype: data["accounttype"],
        govtId: data["govtId"],
        idNumber: data["idNumber"],
        companyidNumber: data["companyidNumber"],
        legalName: data["legalName"],
        reference: snapshot.reference);
  }

  factory AllUsers.fromJson(data) {
    return AllUsers(
        firstName: data["firstName"],
        lastName: data["lastName"],
        email: data["email"],
        password: data["password"],
        confirmPassword: data["confirmPassword"],
        contactNumber: data["contactNumber"],
        alternateNumber: data["alternateNumber"],
        address: data["address"],
        address2: data["address2"],
        city: data["city"],
        accounttype: data["accounttype"],
        govtId: data["govtId"],
        idNumber: data["idNumber"],
        companyidNumber: data["companyidNumber"],
        legalName: data["legalName"]);
  }

  static Future<List<AllUsers>> getAllUserss() {
    return FirebaseFirestore.instance.collection('enterpriseuser').get().then(
        (value) => value.docs.map((e) => AllUsers.fromSnapshot(e)).toList());
  }
}
