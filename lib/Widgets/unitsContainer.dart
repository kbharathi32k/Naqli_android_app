// ignore_for_file: must_be_immutable

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naqli_android_app/Widgets/formText.dart';
import 'package:sizer/sizer.dart';

@immutable
class UnitsContainer extends StatefulWidget {
  final String? buttonText;
  final void Function()? onPressed;
  final GlobalKey<CustomContainerState>? buttonKey;
  final List<Map<String, String>> unitNames;
  String? selectedTypeName;
  final ValueChanged<String>? onSelectionChanged;
  final ValueChanged<String>? onSelectionChanged1;
  String? size;

  UnitsContainer({
    Key? key,
    this.buttonText,
    this.selectedTypeName,
    this.onPressed,
    required this.unitNames,
    this.buttonKey,
    this.size,
    this.onSelectionChanged,
    this.onSelectionChanged1,
  }) : super(key: key);

  @override
  CustomContainerState createState() => CustomContainerState();
}

class CustomContainerState extends State<UnitsContainer> {
  late OverlayEntry _overlayEntry;
  bool _overlayVisible = false;
  bool expand = false;

  @override
  void initState() {
    super.initState();
  }

  OverlayEntry _createOverlayEntry(
      GlobalKey key, String selectedTypeName, String size) {
    RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    final position = renderBox!.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) => Positioned(
        right: position.dx + 7.5.w,
        top: position.dy + 50,
        child: Material(
          elevation: 2,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 0.4,
              color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.2),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: SizedBox(
            width: 480,
            height: widget.unitNames.length *
                70.0, // Assuming each ListTile has a height of 70
            child: Container(
              padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 0.4,
                  color: Color.fromRGBO(112, 112, 112, 1).withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                itemCount: widget.unitNames.length,
                itemExtent: 70, // Height of each ListTile
                itemBuilder: (context, index) {
                  String image = widget.unitNames[index]['image']!;
                  String name = widget.unitNames[index]['name']!;
                  String size = widget.unitNames[index]['size']!;
                  return ListTile(
                    onTap: () {
                      setState(() {
                        widget.onSelectionChanged!(name);
                        widget.onSelectionChanged1!(size);
                        expand = false;
                      });
                      _hideOverlay();
                    },
                    leading: Image.network(
                      image,
                      width: 120,
                      height: 70,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(name, style: BookingManagerText.sfpro20black),
                        Text(size, style: TriggerBookingText.sfpro16)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(GlobalKey<CustomContainerState> key,
      String selectedTypeName, String size) {
    _overlayEntry = _createOverlayEntry(key, selectedTypeName, size);
    Overlay.of(context)!.insert(_overlayEntry);
    setState(() {
      _overlayVisible = true;
    });
  }

  void _hideOverlay() {
    _overlayEntry.remove();
    setState(() {
      _overlayVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromRGBO(183, 183, 183, 1)),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/naqli-5825c.appspot.com/o/delivery-truck.png?alt=media&token=e352f9eb-3dfb-4680-85df-df6b6903b2a2',
                  width: 100,
                  height: 100,
                ),
                SizedBox(
                    width: 7.w,
                    child: Text(widget.buttonText!,
                        style: AvailableText.helvetica17black)),
                SizedBox(
                  height: double.infinity,
                  child: VerticalDivider(),
                ),
                Text(
                  widget.selectedTypeName ?? 'Select Type',
                  style: widget.selectedTypeName != null
                      ? AvailableText.helvetica
                      : AvailableText.sfproblack,
                ),
                IconButton(
                  key: widget.buttonKey,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 25,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (!_overlayVisible) {
                      _showOverlay(
                          widget.buttonKey!,
                          widget.selectedTypeName ?? 'Select Type',
                          widget.size ?? '-');
                    } else {
                      _hideOverlay();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
