import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum SingleUserStatus { verified, notVerified }

enum ActiveStatus { selected, curated, rejected }

class SingleUserBooking {
  final String? truck;
  final String? load;
  final String? size;
  final String? date;
  final String? bookingid;
  String? get docId => reference!.id;

  final DocumentReference? reference;
  ActiveStatus activeStatus;

  SingleUserBooking({
    this.truck,
    this.load,
    this.size,
    this.date,
    this.bookingid,
    this.reference,
    this.activeStatus = ActiveStatus.curated,
  });

  toJson() => {
        "truck": truck,
        "reference": reference,
        "load": load,
        "size": size,
        "date": date,
        "bookingid": bookingid,
        "docId": docId,
      };

  factory SingleUserBooking.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return SingleUserBooking(
      truck: data["truck"],
      load: data["load"],
      size: data["size"],
      date: data["date"],
      bookingid: data["bookingid"],
      reference: snapshot.reference,
    );
  }

  factory SingleUserBooking.fromJson(json, DocumentReference reference) {
    return SingleUserBooking(
      truck: json["truck"],
      load: json["load"],
      size: json["size"],
      date: json["date"],
      bookingid: json["bookingid"],
      // reference: json["reference"],
      reference: reference,
    );
  }
}

class SingleUser {
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
  String? get docId => reference!.id;

  final DocumentReference? reference;
  ActiveStatus activeStatus;

  SingleUser({
    this.email,
    this.password,
    this.selectedAccounttype,
    this.firstName,
    this.lastName,
    this.legalName,
    this.contactNumber,
    this.address,
    this.govtId,
    this.selectedGovtId,
    this.confirmPassword,
    this.alternateNumber,
    this.address2,
    this.idNumber,
    this.city,
    this.selectedCity,
    this.companyidNumber,
    this.adminUid,
    this.reference,
    this.activeStatus = ActiveStatus.curated,
  });

  toJson() => {
        "email": email,
        "password": password,
        "selectedAccounttype": selectedAccounttype,
        "firstName": firstName,
        "legalName": legalName,
        "lastName": legalName,
        "confirmPassword": confirmPassword,
        "contactNumber": contactNumber,
        "address2": address2,
        "address": address,
        "govtId": govtId,
        "alternateNumber": alternateNumber,
        "idNumber": idNumber,
        "city": city,
        "companyidNumber": companyidNumber,
        "adminUid": adminUid,
        "docId": docId,
      };

  factory SingleUser.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return SingleUser(
      email: data["email"],
      password: data["password"],
      selectedAccounttype: data["selectedAccounttype"],
      firstName: data["firstName"],
      legalName: data["legalName"],
      lastName: data["legalName"],
      confirmPassword: data["confirmPassword"],
      contactNumber: data["contactNumber"],
      address2: data["address2"],
      address: data["address"],
      govtId: data["govtId"],
      alternateNumber: data["alternateNumber"],
      idNumber: data["idNumber"],
      city: data["city"],
      companyidNumber: data["companyidNumber"],
      adminUid: data["adminUid"],
      reference: snapshot.reference,
    );
  }

  factory SingleUser.fromJson(json, DocumentReference reference) {
    return SingleUser(
      email: json["email"],
      password: json["password"],
      selectedAccounttype: json["selectedAccounttype"],
      firstName: json["firstName"],
      legalName: json["legalName"],
      lastName: json["legalName"],
      confirmPassword: json["confirmPassword"],
      contactNumber: json["contactNumber"],
      address2: json["address2"],
      address: json["address"],
      govtId: json["govtId"],
      alternateNumber: json["alternateNumber"],
      idNumber: json["idNumber"],
      city: json["city"],
      companyidNumber: json["companyidNumber"],
      adminUid: json["adminUid"],
      reference: json["reference"],
    );
  }
}
