import 'package:flutter/material.dart';

class ConfirmTrip extends StatefulWidget {
  const ConfirmTrip({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfirmTrip> createState() => _ConfirmTrip();
}

class _ConfirmTrip extends State<ConfirmTrip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, right: 50),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            elevation: 0.0,
            title: Container(
              padding: const EdgeInsets.only(left: 400),
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/naqlilogo.png?alt=media&token=db201cb1-dd7b-4b9e-b364-8fb7fa3b95db',
                width: 140,
                height: 140,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 300.0, top: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: Color.fromRGBO(106, 102, 209, 1),
                    ),
                    SizedBox(
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 5),
                        child: Text(
                          "Contact Us",
                          style: TextStyle(fontFamily: 'Colfax', fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 30,
                      child: VerticalDivider(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 170,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13, top: 5),
                        child: Text(
                          "Hello Customer!",
                          style: TextStyle(fontFamily: 'Colfax', fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
                    top: 135,
                    child: Container(
                      width: 1000,
                      height: 600,
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/delivery-truck.png?alt=media&token=e352f9eb-3dfb-4680-85df-df6b6903b2a2',
                                        width: 300,
                                        height: 300,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      TextEditingController(
                                                    text: '0',
                                                  ),
                                                  onChanged: (value) {
                                                    // Handle the value change if needed
                                                  },
                                                  decoration: InputDecoration(
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
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromRGBO(
                                                      106, 102, 209, 1),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "+",
                                                    style: TextStyle(
                                                        color: Colors.white),
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
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors
                                                          .black), // Add a black border
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(
                                                        color: Colors.black),
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
                            padding: const EdgeInsets.only(right: 210),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "Total_Estimated_Cost",
                                  style: TextStyle(
                                      fontFamily: 'Colfax', fontSize: 17),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "XXXX",
                                  style: TextStyle(
                                      fontFamily: 'Colfax', fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50),
                            child: Row(
                              children: [
                                Text(
                                  "*Driver_will_not_be_helping_in_loading_and_unloading",
                                  style: TextStyle(
                                      fontFamily: 'Colfax', fontSize: 16),
                                ),
                                SizedBox(width: 20),
                                // Create Request Button
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Handle Create Request button click
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromRGBO(106, 102, 209, 1),
                                      side: BorderSide(
                                        color: Color.fromRGBO(106, 102, 209, 1),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Create Request",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Colfax',
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                // Cancel Button
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle Cancel button click
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(112, 112, 112, 1),
                                    side: BorderSide(
                                        color:
                                            Color.fromRGBO(112, 112, 112, 1)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Colfax',
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
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
