import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class Iconbutton extends StatelessWidget {
  final Function onpress;
  final Icon bicon;
  final Color backgroundColor; // Add a background color property

  const Iconbutton({
    Key? key,
    required this.onpress,
    required this.bicon,
    this.backgroundColor = Colors.blue, // Default background color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.2), // Set the background color here
        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
      ),
      child: IconButton(
        color: kPrimaryColorDark,
        icon: bicon,
        onPressed: () {

            onpress();
         
        },
      ),
    );
  }
}



//genral

class Genaralbutton extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final double pleft;
  final double pright;
  final double ptop;
  final double pbottom;
  final Function onpress;
  final double fontsize;
  final bool isActive;
  const Genaralbutton({
    this.color = kPrimaryColorDark,
    this.textcolor = Colors.white,
    this.text = "Button",
    this.pleft = 15,
    this.pright = 15,
    this.ptop = 10,
    this.pbottom = 10,
    Key? key,
    required this.onpress,
    this.fontsize = 20,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ElevatedButton(
        onPressed: () {
          onpress();
        },
        child: Text(
          text,
          style: TextStyle(
              color: textcolor,
              fontSize: fontsize,
              fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: isActive ? color : color.withOpacity(0.5),
            elevation: 3.0,
            padding: EdgeInsets.only(
                left: pleft, right: pright, top: ptop, bottom: pbottom)),
      ),
    );
  }
}

// clcik and color change
class ColorChangeButton extends StatefulWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final double pleft;
  final double pright;
  final double ptop;
  final double pbottom;
  final Function onpress;
  final double fontsize;

  const ColorChangeButton({
    super.key,
    this.color = kPrimaryColorDark,
    this.textcolor = kPrimaryColorLight,
    this.text = "Button",
    this.pleft = 15,
    this.pright = 15,
    this.ptop = 10,
    this.pbottom = 10,
    required this.onpress,
    this.fontsize = 20,
  });
  @override
  _ColorChangeButtonState createState() => _ColorChangeButtonState();
}

class _ColorChangeButtonState extends State<ColorChangeButton> {
  bool _isButtonClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, bottom: 15, right: 10),
      child: ElevatedButton(
        onPressed: () {
          widget.onpress();
          setState(() {
            _isButtonClicked = !_isButtonClicked;
          });
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor:
                _isButtonClicked ? kPrimaryColorDark : kPrimaryColorLight,
            elevation: 5.0,
            padding: EdgeInsets.only(
                left: widget.pleft,
                right: widget.pright,
                top: widget.ptop,
                bottom: widget.pbottom)),
        child: Text(
          widget.text,
          style: TextStyle(
              color: _isButtonClicked ? kPrimaryColorLight : kPrimaryColorDark,
              fontSize: widget.fontsize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class RadioButton extends StatefulWidget {
  final Function(String?) onValueChanged;
  final String storeValue;
  const RadioButton(
      {Key? key, required this.onValueChanged, required this.storeValue})
      : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  String? _selectedValue;

  void _handleRadioValueChange(String? value) {
    setState(() {
      if (widget.storeValue == value) {
        _selectedValue = null;
        widget.onValueChanged(null);
      } else {
        _selectedValue = value;
        widget.onValueChanged(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          value: 'newest',
          groupValue: widget.storeValue != "" && widget.storeValue == "newest"
              ? widget.storeValue
              : _selectedValue,
          onChanged: (value) {
            _handleRadioValueChange(value.toString());
          },
          title: Text('Newest'),
        ),
        RadioListTile(
          value: 'closest',
          groupValue: widget.storeValue != "" && widget.storeValue == "closest"
              ? widget.storeValue
              : _selectedValue,
          onChanged: (value) {
            _handleRadioValueChange(value.toString());
          },
          title: Text('Closest'),
        ),
      ],
    );
  }
}
