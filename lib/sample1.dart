import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class Sample1 extends StatefulWidget {
  @override
  _Sample1State createState() => _Sample1State();
}

class _Sample1State extends State<Sample1> {
  DateTime? _pickedDate;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Date Picker Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showDatePicker(context);
                },
                child: Text('Pick a Date'),
              ),
              SizedBox(height: 20),
              Text(
                _pickedDate != null
                    ? 'Selected date: ${DateFormat('dd/MM/yyyy').format(_pickedDate!)}'
                    : 'No date selected',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
      });
    }
  }
}
