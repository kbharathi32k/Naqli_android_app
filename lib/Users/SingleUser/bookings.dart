import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/DialogBox/SingleTimeUser/paymentSuccessDialog.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/Widgets/customButton.dart';
import 'package:naqli_android_app/Widgets/customRadio.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:naqli_android_app/homePage.dart';
import 'package:naqli_android_app/test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../DialogBox/SingleTimeUser/bookingConfirmDialog.dart';

class Bookings extends StatefulWidget {
  final String? user;
  final String? bookingId;
  final String? unitType;
  Bookings({required this.user, this.unitType, this.bookingId});
  @override
  State<Bookings> createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  GoogleMapController? mapController;
  List<Marker> _markers = [];
  bool isButtonEnabled = false;
  bool isButtonEnabled1 = false;
  bool isButtonEnabled2 = false;
  bool showmaps = true;
  int selectedRadioValue = -1;
  int? selectedRadioValue1;
  int? selectedRadioValue2;
  int screenState = 0;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  final ScrollController _book1Scroll = ScrollController();
  final ScrollController _book2Scroll = ScrollController();
  final ScrollController _book3Scroll = ScrollController();
  final ScrollController _scrollController = ScrollController();
  late Stream<Map<String, dynamic>?> userStream;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _BookingConfirm(BuildContext context, String bookingId) {
    print('track 2');
    print('==================$bookingId');
    showDialog(
      barrierColor: Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
      context: context,
      builder: (context) {
        print('track 3');
        print('------------------$bookingId');
        return Padding(
          padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
          child: Padding(
            padding: const EdgeInsets.only(left: 350),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ElevationContainer(
                width: 1000,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        color: Color.fromRGBO(98, 106, 254, 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'Booking Confirmation',
                                style: DialogText.dialogtext1,
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.only(right: 2),
                            icon: Icon(Icons.close),
                            onPressed: () {
                              // _handleItem1Tap();
                              Navigator.pop(
                                context,
                              );
                              setState(() {
                                screenState = 1; // Change the screenState to 1
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => Bookings(    user: widget.user,),
                              //   ),
                              // );
                            },
                            color: Colors.white, // Setting icon color
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'BOOKING ID $bookingId Confirmed',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color.fromRGBO(104, 102, 124, 1),
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'With Advance Payment of SAR XXXXXX',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(104, 102, 124, 1),
                                fontFamily: 'Helvetica',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Stream<List<String>> fetchAllVendorNames() {
    try {
      return FirebaseFirestore.instance
          .collection('partneruser')
          .snapshots()
          .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        List<String> vendorNames = [];
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in querySnapshot.docs) {
          if (doc.exists) {
            Map<String, dynamic> data = doc.data()!;
            String name = data['firstName'] ??
                ''; // Assuming 'firstName' is the field containing vendor names
            vendorNames.add(name);
          }
        }
        return vendorNames;
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Return an empty stream in case of an error
      return Stream.value([]);
    }
  }

  Stream<Map<String, dynamic>> fetchData(String userId) {
    // Create a StreamController to manage the stream
    StreamController<Map<String, dynamic>> controller = StreamController();

    try {
      // Perform the asynchronous operation
      String userCollection;
      if (widget.unitType == 'Vehicle') {
        userCollection = 'vehicleBooking';
      } else if (widget.unitType == 'Equipment') {
        userCollection = 'equipmentBookings';
      } else {
        throw Exception('Invalid selected type');
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection('user').doc(userId);
      CollectionReference userBookingCollectionRef =
          userDocRef.collection(userCollection);
      Map<String, dynamic>? lastUserData;
      // Listen to the collection's stream, order by timestamp, and limit to 1 document
      userBookingCollectionRef.limit(1).snapshots().listen((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (doc.exists) {
            // Explicitly cast doc.data() to Map<String, dynamic>
            Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

            if (data != null) {
              String truck = data['truck'] ?? '';
              String load = data['load'] ?? '';
              String size = data['size'] ?? '';
              String bookingid = data['bookingid'] ?? '';

              // Create a map containing truck, load, and size
              Map<String, dynamic> userData = {
                'truck': truck,
                'load': load,
                'size': size,
                'bookingid': bookingid
              };

              // Update lastUserData with the new userData
              lastUserData = userData;
              // Emit the data to the stream
              controller.add(data);
            }
          } else {
            print('Document does not exist');
            controller.addError('Document does not exist');
          }
        });
      }, onError: (error) {
        print('Error fetching data: $error');
        controller.addError(error);
      });
    } catch (e) {
      print('Error fetching data: $e');
      controller.addError(e);
    }

    // Return the stream from the StreamController
    return controller.stream;
  }

  @override
  void initState() {
    super.initState();
    // if (_markers.isNotEmpty) {
    //   _markers.add(const Marker(
    //     markerId: MarkerId("Mylocation"),
    //     position: LatLng(59.948680, 11.010630),
    //   ));
    //   setState(() {
    //     showmaps = true;
    //   });
    // }
  }

  Widget _buildScreen0() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(3.w, 7.h, 0, 4.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<List<String>>(
              stream: fetchAllVendorNames(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  List<String> vendorNames = snapshot.data!;
                  return Column(
                    children: [
                      Container(
                        height: 250,
                        child: ListView.builder(
                          itemCount: vendorNames.length,
                          itemBuilder: (context, index) {
                            String name = vendorNames[index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomRadio1(
                                  onChanged: (val) {
                                    setState(() {
                                      selectedRadioValue = val!;
                                      isButtonEnabled = true;
                                    });
                                  },
                                  groupValue: selectedRadioValue,
                                  value:
                                      index, // Or any unique identifier for each radio button
                                  text1: name,
                                  colors: Colors.white,
                                  text2: "XXXX SAR",
                                ),
                                SizedBox(
                                  height: 23,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  // Loading or error state
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      barrierColor: Colors.grey.withOpacity(0.5),
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 335),
                          child: BookingConfirmationDialog(),
                        );
                      },
                    );
                  },
                  child: Text("Cancel Request",
                      style: DialogText.purplehelveticabold),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton2(
                    onPressed: () {
                      print('track 1');
                      if (widget.bookingId != null) {
                        _BookingConfirm(context, widget.bookingId!);
                      } else {
                        // Handle the case where widget.bookingId is null
                        print('Error: bookingId is null');
                      }
                    },
                    text1: 'Pay Advance: ',
                    text2: 'XXXX',
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
                Expanded(
                  child: CustomButton2(
                    onPressed: () {
                      showDialog(
                          barrierColor:
                              Color.fromRGBO(59, 57, 57, 1).withOpacity(0.5),
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 350),
                                  child: BookingSuccessDialog(
                                      bookingId: widget.bookingId)),
                            );
                          });
                    },
                    text1: 'Pay: ',
                    text2: 'XXXX',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildScreen1() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 2.h, 1.w, 2.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vendor Name',
                  style: TabelText.tableText4,
                ),
                Text(
                  'Kamado',
                  style: TabelText.tableText5,
                ),
              ],
            ),
            Divider(
              color: Color.fromRGBO(204, 195, 195, 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Operator id',
                  style: TabelText.tableText4,
                ),
                Text(
                  '#456789142',
                  style: TabelText.tableText5,
                ),
              ],
            ),
            Divider(
              color: Color.fromRGBO(204, 195, 195, 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Operator name',
                  style: TabelText.tableText4,
                ),
                Text(
                  'Tanjiro',
                  style: TabelText.tableText5,
                ),
              ],
            ),
            Divider(
              color: Color.fromRGBO(204, 195, 195, 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mode',
                  style: TabelText.tableText4,
                ),
                Text(
                  'Box truck',
                  style: TabelText.tableText5,
                ),
              ],
            ),
            Divider(
              color: Color.fromRGBO(204, 195, 195, 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No.of units',
                  style: TabelText.tableText4,
                ),
                Text(
                  '2',
                  style: TabelText.tableText5,
                ),
              ],
            ),
            Divider(
              color: Color.fromRGBO(204, 195, 195, 1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking status',
                  style: TabelText.tableText4,
                ),
                Text(
                  'Completed',
                  style: TabelText.tableText5,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Pending Amount',
              style: TabelText.helveticablack16,
            ),
            Text(
              'XXXXX SAR',
              style: TextStyle(
                  color: Color.fromRGBO(145, 79, 157, 1),
                  fontFamily: 'Helvetica',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            CustomButton(
              onPressed: () {
                showDialog(
                  barrierColor: Colors.grey.withOpacity(0.5),
                  context: context,
                  builder: (context) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
                        child: BookingSuccessDialog());
                  },
                );
              },
              text: 'Pay Now',
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints) {
        if (constraints.maxWidth >= 950) {
          return SingleChildScrollView(
            child: Container(
              height: 680,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Color.fromRGBO(255, 255, 255, 0.925),
              ),
              padding: EdgeInsets.fromLTRB(6.w, 10.h, 4.w, 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 3.w),
                      child: StreamBuilder<Map<String, dynamic>>(
                        stream: fetchData(widget.user!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                          } else if (snapshot.hasError) {
                            return Text(
                                'Error: ${snapshot.error}'); // Show an error message if there's an error
                          } else {
                            // If data is available, build the UI using the retrieved userData
                            Map<String, dynamic> userData = snapshot.data ?? {};

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1787.png?alt=media&token=d2066c85-560c-4a61-80bc-d020dcd73f95',
                                      width: 62,
                                      height: 61,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Booking Id ${userData['bookingid']}",
                                        style: BookingText.helvetica21),
                                  ],
                                ),
                                Container(
                                  height: 380,
                                  width: 700,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: GoogleMap(
                                      onMapCreated: (controller) {
                                        setState(() {
                                          mapController = controller;
                                        });
                                      },
                                      markers: Set<Marker>.of(_markers),
                                      mapType: MapType.normal,
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(24.755562, 46.589584),
                                          zoom: 13)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(
                                        right: 4.w,
                                        left: 4.w,
                                        top: 1.w,
                                        bottom: 2.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Pick up truck",
                                                style: DialogText
                                                    .helvetica25black),
                                            Text('${userData['truck']}',
                                                style:
                                                    BookingText.helveticablack)
                                          ],
                                        ),
                                        SizedBox(
                                          height: 63,
                                          child: VerticalDivider(
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1),
                                            thickness: 2,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text("Load",
                                                style:
                                                    BookingText.helveticablack),
                                            Text('${userData['load']}',
                                                style: HomepageText
                                                    .helvetica16black)
                                          ],
                                        ),
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              Text("Size",
                                                  style: BookingText
                                                      .helveticablack),
                                              Text('${userData['size']}',
                                                  style: HomepageText
                                                      .helvetica16black)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ))
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  VerticalDivider(
                    color: Color.fromRGBO(204, 195, 195, 1),
                    thickness: 1,
                  ),
                  screenState == 0 ? _buildScreen0() : _buildScreen1()
                ],
              ),
            ),
          );
        } else {
          return Container(
            height: 680,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(255, 255, 255, 0.925),
            ),
            padding: EdgeInsets.fromLTRB(6.w, 10.h, 6.w, 10.h),
            child: Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 900,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            'Group1787.png',
                            width: 62,
                            height: 61,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Booking Id #1345789345",
                              style: BookingText.helvetica21),
                        ],
                      ),
                      Container(
                        height: 380,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: GoogleMap(
                            onMapCreated: (controller) {
                              setState(() {
                                mapController = controller;
                              });
                            },
                            markers: Set<Marker>.of(_markers),
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(24.755562, 46.589584),
                                zoom: 13)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("Pick up truck",
                                  style: DialogText.helvetica25black),
                              Text("Toyota Hilux",
                                  style: BookingText.helveticablack)
                            ],
                          ),
                          SizedBox(
                            height: 63,
                            child: VerticalDivider(
                              color: Color.fromRGBO(112, 112, 112, 1),
                              thickness: 2,
                            ),
                          ),
                          Column(
                            children: [
                              Text("Load", style: BookingText.helveticablack),
                              Text("Woods",
                                  style: HomepageText.helvetica16black)
                            ],
                          ),
                          SizedBox(
                            child: Column(
                              children: [
                                Text("Size", style: BookingText.helveticablack),
                                Text(" 1 to 1.5",
                                    style: HomepageText.helvetica16black)
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<List<String>>(
                        stream: fetchAllVendorNames(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            List<String> vendorNames = snapshot.data!;
                            return Column(
                              children: [
                                Container(
                                  height: 250,
                                  child: ListView.builder(
                                    itemCount: vendorNames.length,
                                    itemBuilder: (context, index) {
                                      String name = vendorNames[index];
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomRadio1(
                                            onChanged: (val) {
                                              setState(() {
                                                selectedRadioValue = val!;
                                                isButtonEnabled = true;
                                              });
                                            },
                                            groupValue: selectedRadioValue,
                                            value:
                                                index, // Or any unique identifier for each radio button
                                            text1: name,
                                            colors: Colors.white,
                                            text2: "XXXX SAR",
                                          ),
                                          SizedBox(
                                            height: 23,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          } else {
                            // Loading or error state
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDialog(
                                barrierColor: Colors.grey.withOpacity(0.5),
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 335),
                                    child: BookingConfirmationDialog(),
                                  );
                                },
                              );
                            },
                            child: Text("Cancel Request",
                                style: DialogText.purplehelveticabold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton2(
                            onPressed: () {},
                            text1: 'Pay Advance: ',
                            text2: 'XXXX',
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          CustomButton2(
                            onPressed: () {
                              showDialog(
                                barrierColor: Color.fromRGBO(59, 57, 57, 1)
                                    .withOpacity(0.5),
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 380, top: 40),
                                    child: BookingConfirmDialog(),
                                  );
                                },
                              );
                            },
                            text1: 'Pay: ',
                            text2: 'XXXX',
                          ),
                        ],
                      ),
                    ],
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
