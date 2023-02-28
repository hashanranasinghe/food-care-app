//icon
import 'package:flutter/material.dart';

import '../utils/constraints.dart';

class Iconbutton extends StatelessWidget {
  final Color color;
  final Color textcolor;
  final String text;
  final double pleft;
  final double pright;
  final double ptop;
  final double pbottom;
  final double fontsize;
  final Function onpress;
  final Icon bicon;
  const Iconbutton({
    this.color = kPrimaryColordark,
    this.textcolor = Colors.white,
    this.text = "Button",
    this.pleft = 15,
    this.pright = 15,
    this.ptop = 10,
    this.pbottom = 10,
    required this.bicon,
    Key? key,
    required this.onpress,
    this.fontsize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        onpress();
      },
      icon: bicon,
      label: Text(
        text,
        style: TextStyle(color: textcolor, fontSize: fontsize),
      ),
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 15.0,
          primary: color,
          padding: EdgeInsets.only(
              left: pleft, right: pright, top: ptop, bottom: pbottom)),
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
  const Genaralbutton({
    this.color = kPrimaryColordark,
    this.textcolor = kPrimaryColorlight,
    this.text = "Button",
    this.pleft = 15,
    this.pright = 15,
    this.ptop = 10,
    this.pbottom = 10,
    Key? key,
    required this.onpress,
    this.fontsize = 20,
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
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 15.0,
            primary: color,
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
    this.color = kPrimaryColordark,
    this.textcolor = kPrimaryColorlight,
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
      padding: const EdgeInsets.only(top: 15,left: 10,bottom: 15,right: 10),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _isButtonClicked = !_isButtonClicked;
          });
        },
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5.0,
            primary: _isButtonClicked ? kPrimaryColordark : kPrimaryColorlight,
            padding: EdgeInsets.only(
                left: widget.pleft, right: widget.pright, top: widget.ptop, bottom: widget.pbottom)),
        child: Text(
          widget.text,
          style: TextStyle(
              color: _isButtonClicked ? kPrimaryColorlight
                  : kPrimaryColordark,
              fontSize: widget.fontsize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
