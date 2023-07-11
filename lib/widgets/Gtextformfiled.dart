import 'package:flutter/material.dart';

import '../utils/constraints.dart';

////////////////// textfiled//////////////////////////////////
class Gtextformfiled extends StatelessWidget {
  final String label;
  final TextInputType keybordtype;
  final TextEditingController controller;
  final String hintText;

  final TextInputAction textInputAction;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;
  const Gtextformfiled({
    this.textInputAction = TextInputAction.none,
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    Key? key,
    required this.controller,
    this.label = "Textfiled",
    this.keybordtype = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        textInputAction: textInputAction,
        maxLines: null,
        keyboardType: keybordtype,
        onChanged: onchange,
        onSaved: save,
        controller: controller,
        validator: valid,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.5),
          ),
        ),
      ),
    );
  }
}

////////////////// passwordfiled//////////////////////////////////
class Gpasswordformfiled extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextInputType textinput;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;

  const Gpasswordformfiled({
    this.hintText = "Password",
    this.icon = Icons.person,
    required this.onchange,
    required this.save,
    this.textinput = TextInputType.text,
    Key? key,
    required this.valid,
  }) : super(key: key);

  @override
  _GpasswordformfiledState createState() => _GpasswordformfiledState();
}

class _GpasswordformfiledState extends State<Gpasswordformfiled> {
  bool isHidepassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30, bottom: 5, top: 20),
              child: Text(
                widget.hintText,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        obscureText: isHidepassword,
                        validator: widget.valid,
                        onChanged: widget.onchange,
                        onSaved: widget.save,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: kPrimaryColorlight,
                          prefixIcon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              color: kPrimaryColordark,
                            ),
                            width: 20,
                            height: 20,
                            child: Icon(
                              widget.icon,
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: InputBorder.none,
                          suffixIcon: InkWell(
                              onTap: _viewPassword,
                              child: isHidepassword == true
                                  ? Icon(Icons.visibility_off_rounded)
                                  : Icon(Icons.visibility_rounded)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _viewPassword() {
    if (isHidepassword == true) {
      isHidepassword = false;
    } else {
      isHidepassword = true;
    }
    setState(() {});
  }
}

///////////////////////////////np icon /////////////////////////////
///
class Gnoiconformfiled extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxlines;
  final IconData? icon;
  final TextInputType textinput;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;
  const Gnoiconformfiled({
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    this.textinput = TextInputType.text,
    Key? key,
    required this.controller,
    this.label = "Textfiled",
    this.maxlines = 1,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30, bottom: 5, top: 20),
              child: Text(
                label,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        keyboardType: textinput,
                        onChanged: onchange,
                        maxLines: maxlines,
                        onSaved: save,
                        validator: valid,
                        controller: controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: kPrimaryColorlight,
                          prefixIcon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              color: kPrimaryColordark,
                            ),
                            width: 20,
                            height: 20,
                            child: Icon(
                              icon,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
