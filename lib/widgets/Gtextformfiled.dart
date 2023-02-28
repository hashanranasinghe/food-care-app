import 'package:flutter/material.dart';

import '../services/validate_handeler.dart';
import '../utils/constraints.dart';

////////////////// textfiled//////////////////////////////////
class Gtextformfiled extends StatelessWidget {
  final String label;
  final TextInputType keybordtype;
  final TextEditingController controller;
  final String hintText;

  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;
  const Gtextformfiled({
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
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        // initialValue: "sdsd",
        keyboardType: keybordtype,
        onChanged: onchange,
        onSaved: save,
        controller: controller,
        validator: valid,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFE3E3E3FF),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3FF), width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide:
                const BorderSide(color: Color(0xFFE3E3E3FF), width: 1.5),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
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
    Key? key, required this.valid,
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
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kPrimaryColordark,
                ),
                height: 48,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 7, right: 7),
                        child: Icon(
                          widget.icon,
                          size: 30,
                          color: Colors.white,
                        )),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: kPrimaryColorlight,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: TextFormField(
                            obscureText: isHidepassword,
                            validator: widget.valid,
                            onChanged: widget.onchange,
                            onSaved: widget.save,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              suffixIcon: InkWell(
                                  onTap: _viewPassword,
                                  child: const Icon(Icons.visibility)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: kPrimaryColordark,
                ),
                height: 48,
                child: Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 7, right: 7),
                        child: Icon(
                          icon,
                          size: 30,
                          color: Colors.white,
                        )),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: kPrimaryColorlight,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextFormField(
                            keyboardType: textinput,
                            onChanged: onchange,
                            maxLines: maxlines,
                            onSaved: save,
                            controller: controller,
                            validator: valid,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
