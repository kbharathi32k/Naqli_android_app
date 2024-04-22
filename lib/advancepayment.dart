import 'package:flutter/material.dart';

class AdvancePayment extends StatefulWidget {
  const AdvancePayment({
    Key? key,
  }) : super(key: key);

  @override
  State<AdvancePayment> createState() => _AdvancePayment();
}

class _AdvancePayment extends State<AdvancePayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 500,
                        color: Color.fromRGBO(106, 102, 209, 1),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: Text(
                                  'Confirm the trip',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: 'Colfax',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 500,
                      )
                    ],
                  ),
                  Positioned(
                    top: 150,
                    child: Container(
                      height: 600,
                      width: 1000,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2, // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Positioned(
                            top: 135,
                            left: 300,
                            child: Container(
                              width: 500,
                              height: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 100),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/delivery-truck.png?alt=media&token=e352f9eb-3dfb-4680-85df-df6b6903b2a2',
                                                width: 80,
                                                height: 80,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Vehicle 1",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    fontFamily: 'Colfax',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "Upto 500 kg / Good for Small Parcels",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: 'Colfax',
                                                  ),
                                                ),
                                                Text(
                                                  "Starting_from_XXX",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontFamily: 'Colfax',
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Best for Sending",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 19,
                                                    fontFamily: 'Colfax',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  "1. Goods",
                                                  style: TextStyle(
                                                      fontFamily: 'Colfax',
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "2. Goods",
                                                  style: TextStyle(
                                                      fontFamily: 'Colfax',
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "3. Goods",
                                                  style: TextStyle(
                                                      fontFamily: 'Colfax',
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Additional Labour",
                                                      style: TextStyle(
                                                          fontFamily: 'Colfax',
                                                          fontSize: 16),
                                                    ),
                                                    SizedBox(width: 50),
                                                    // Rectangular TextField
                                                    Container(
                                                      width: 60,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextField(
                                                          textAlign:
                                                              TextAlign.center,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          controller:
                                                              TextEditingController(
                                                            text: '0',
                                                          ),
                                                          onChanged: (value) {
                                                            // Handle the value change if needed
                                                          },
                                                          decoration:
                                                              InputDecoration(
                                                            border: InputBorder
                                                                .none, // Remove underline
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    // Circular Plus Button
                                                    GestureDetector(
                                                      onTap: () {
                                                        // Increment logic
                                                      },
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color.fromRGBO(
                                                              106, 102, 209, 1),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "+",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    // Circular Minus Button
                                                    GestureDetector(
                                                      onTap: () {
                                                        // Decrement logic
                                                      },
                                                      child: Container(
                                                        width: 30,
                                                        height: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black), // Add a black border
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "-",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 700,
                                      child: Divider(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Total_Estimated_Cost",
                                          style: TextStyle(
                                              fontFamily: 'Colfax',
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          "XXXX",
                                          style: TextStyle(
                                              fontFamily: 'Colfax',
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              width: 500,
                              height: 600,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                  "Confirm_your_trip_with_a_advance_payment")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
