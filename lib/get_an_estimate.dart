import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/colorContainer.dart';
import 'package:naqli_android_app/availableBus.dart';
import 'package:naqli_android_app/availableEquipment.dart';
import 'package:naqli_android_app/availableSpecial.dart';
import 'package:naqli_android_app/availableVehicle.dart';
import 'package:sizer/sizer.dart';

class GetanEstimate extends StatefulWidget {
  final String? user;
  const GetanEstimate({this.user});
  @override
  _GetanEstimateState createState() => _GetanEstimateState();
}

class _GetanEstimateState extends State<GetanEstimate> {
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
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(31))),
              child: Container(
                height: 770,
                child: Row(
                  children: [
                    Container(
                      width: 23.w,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(13, 13, 255, 1).withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(31),
                          bottomLeft: Radius.circular(31),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60, top: 90),
                            child: Row(
                              children: [
                                Text(
                                  'Get an\n'
                                  'Estimate',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontFamily: "Helvetica",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(height:3.0),

                          SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: Row(
                              children: [
                                Text(
                                  'To ensure we give you the best\n'
                                  'Possible service ,kindly fill out the\n'
                                  'Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Helvetica",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 775,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(31),
                            bottomRight: Radius.circular(31),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AvailableVehicle()),
                                        );
                                      },
                                      child: ElevationUnitContainer(
                                        text1: 'Vehicle',
                                        imgpath:
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group68.png?alt=media&token=5fe75cdd-40f3-48ff-9838-dfadcaf41ae4',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AvailableBus()),
                                        );
                                      },
                                      child: ElevationUnitContainer(
                                        text1: 'Bus',
                                        imgpath:
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bus.png?alt=media&token=62ffdc20-210e-447e-a0e5-51e14b06b449',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AvailableEquipment()),
                                        );
                                      },
                                      child: ElevationUnitContainer(
                                        text1: 'Equipment',
                                        imgpath:
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1496.png?alt=media&token=68985bbe-ba8a-4cd3-b4c9-b5f07ab7f3a5',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AvailableSpecial()),
                                        );
                                      },
                                      child: ElevationUnitContainer(
                                        text1: 'Special',
                                        imgpath:
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1660.png?alt=media&token=e1bdac76-bbdc-4d25-9003-665b2b936a99',
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AvailableSpecial()),
                                        );
                                      },
                                      child: ElevationUnitContainer(
                                        text1: 'Others',
                                        imgpath:
                                            'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/Group1716.png?alt=media&token=416db349-0c72-4bbe-b160-74792ba49f6e',
                                      ),
                                    ),
                                    SizedBox(height: 25),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      });
    });
  }
}
