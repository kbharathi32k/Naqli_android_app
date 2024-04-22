import 'package:flutter/material.dart';

class BookingSuccessful extends StatefulWidget {
  const BookingSuccessful();

  @override
  _BookingSuccessfulState createState() => _BookingSuccessfulState();
}

class _BookingSuccessfulState extends State<BookingSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 260),
      child: Dialog(
        child: Material(
          child: SingleChildScrollView(
            child: Container(
              width: 1000, height: 378, // Adjust the width as needed
              child: Column(
                children: [
                  Container(
                    height: 50,
                    color: Color.fromRGBO(98, 105, 254, 1),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Booking XXXXXX',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      child: Text(
                        "Booking Successful",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(116, 97, 97, 1)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
