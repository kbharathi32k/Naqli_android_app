import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'formText.dart';

@immutable
class CustomDropDown extends StatelessWidget {
  final String? value;
  final List<String?> items;
  final void Function(String?) onChanged;

  CustomDropDown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          value: value,
          items: items.map((String? value) {
            return DropdownMenuItem<String>(
              value: value!,
              child: Text(
                value!,
                style: HomepageText.helvetica16black,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            height: 45,
            padding: EdgeInsets.only(right: 9),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(112, 112, 112, 1)),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down_sharp),
            iconSize: 25,
            iconEnabledColor: Colors.black,
            iconDisabledColor: null,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 1,
            maxHeight: 200,
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromRGBO(183, 183, 183, 1).withOpacity(0.5)),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.white,
            ),
            scrollPadding: EdgeInsets.all(5),
            scrollbarTheme: ScrollbarThemeData(
              thickness: MaterialStateProperty.all<double>(6),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 30,
            padding: EdgeInsets.only(left: 9, right: 9),
          ),
        ),
      ),
    );
  }
}
