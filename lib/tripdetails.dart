import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TripDetails extends StatefulWidget {
  const TripDetails({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TripDetails> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TripDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
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
                    const SizedBox(
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
                    SizedBox(width: 8.0),
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
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 500,
                        ),
                        items: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bridge.jpg?alt=media&token=2e6245a3-09b3-49c3-a71c-ab1e8a8da677'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 80),
                            child: Container(
                              margin: EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/bridge.jpg?alt=media&token=2e6245a3-09b3-49c3-a71c-ab1e8a8da677'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 450, right: 200, top: 200),
                        child: Container(
                          height: 750,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 310,
                    left: 420,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 1100,
                            height: 200,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 2, // changes position of shadow
                                  ),
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25))),
                            child: ListView(
                              // Use ListView instead of Column
                              shrinkWrap: true,
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Trip Details",
                                        style: TextStyle(
                                            fontFamily: 'Colfax',
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      // Vertical divider
                                      SizedBox(width: 10),
                                      // Location text
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.location_on_outlined),
                                              SizedBox(width: 5),
                                              Container(
                                                height: 30,
                                                width: 1,
                                                color: Colors.black,
                                              ),
                                              SizedBox(width: 5),
                                              // Replace the below DropdownButton with your actual dropdown widget
                                              DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: 'Location Selected',
                                                  onChanged:
                                                      (String? newValue) {
                                                    // Handle dropdown value change
                                                  },
                                                  items: <String>[
                                                    'Location Selected',
                                                    'Location1',
                                                    'Location2'
                                                  ].map<
                                                      DropdownMenuItem<String>>(
                                                    (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Colfax',
                                                              fontSize: 16),
                                                        ),
                                                      );
                                                    },
                                                  ).toList(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Divider(
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Text(
                                      "Enter Pickup Point",
                                      style: TextStyle(
                                          fontFamily: 'Colfax', fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 280,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "Enter Drop Point",
                                      style: TextStyle(
                                          fontFamily: 'Colfax', fontSize: 16),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: 280,
                                      height: 40,
                                      child: TextField(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: 200,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: Color.fromRGBO(
                                            106, 102, 209, 1), // RGB color fill
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Get an Estimate",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Colfax',
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    10), // Adjust this space as needed
                                            Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/right-arrow.png?alt=media&token=cba6795c-11eb-449b-8a9a-ac790bf408f5',
                                              width: 30,
                                              height: 20,
                                              color: Colors.white,
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
