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

class IosTextField extends StatelessWidget {
  final String label;
  final TextInputType keybordtype;
  final TextEditingController controller;
  final String hintText;
  final TextInputAction textInputAction;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;
  final IconData icon;
  const IosTextField({
    this.textInputAction = TextInputAction.none,
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    Key? key,
    required this.controller,
    this.label = "Textfiled",
    this.keybordtype = TextInputType.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
      child: Container(
        width: screenSize.width * 0.9,
        child: TextFormField(
          textInputAction: textInputAction,
          maxLines: null,
          keyboardType: keybordtype,
          onChanged: onchange,
          onSaved: save,
          controller: controller,
          validator: valid,
          decoration: InputDecoration(
            fillColor: Color.fromRGBO(251, 251, 251, 0.79),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Color(0xFFE2E5E6), // Change this to your desired color
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Color(0xFFE2E5E6), // Change this to your desired color
                width: 1.0,
              ),
            ),
            label: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black54),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.02),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ),
    );
  }
}

class IosPasswordTextFiled extends StatefulWidget {
  final String label;
  final IconData icon;

  final TextInputType textInput;
  final Function(String) onchange;
  final Function(String?) save;
  final String? Function(String?) valid;

  const IosPasswordTextFiled({
    this.icon = Icons.person,
    required this.onchange,
    required this.save,
    this.textInput = TextInputType.text,
    Key? key,
    required this.valid,
    required this.label,
  }) : super(key: key);

  @override
  _IosPasswordTextFiledState createState() => _IosPasswordTextFiledState();
}

class _IosPasswordTextFiledState extends State<IosPasswordTextFiled> {
  bool isHidePassword = true;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
        child: TextFormField(
          obscuringCharacter: '*',
          obscureText: isHidePassword,
          validator: widget.valid,
          onChanged: widget.onchange,
          onSaved: widget.save,
          decoration: InputDecoration(
            fillColor: Color.fromRGBO(251, 251, 251, 0.79),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Color(0xFFE2E5E6), // Change this to your desired color
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Color(0xFFE2E5E6), // Change this to your desired color
                width: 1.0,
              ),
            ),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  color: kPrimaryColorDark,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: kPrimaryColorDark),
                )
              ],
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.05,
                vertical: screenSize.height * 0.02),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            suffixIcon: InkWell(
                onTap: _viewPassword,
                child: isHidePassword == true
                    ? Icon(
                        Icons.visibility_off_rounded,
                        color: kSecondaryTextColorDark,
                      )
                    : Icon(Icons.visibility_rounded,
                        color: kSecondaryTextColorDark)),
          ),
        ),
      ),
    );
  }

  void _viewPassword() {
    if (isHidePassword == true) {
      isHidePassword = false;
    } else {
      isHidePassword = true;
    }
    setState(() {});
  }
}

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextInputType keybordtype;
  final Icon? prefixIcon;
  final TextEditingController controller;
  final String hintText;
  final bool readOnly;
  final TextInputAction textInputAction;
  final Function(String) onchange;
  final Function(String?) save;
  final FocusNode? focusNode;
  final String? Function(String?) valid;
  const TextFieldWidget({
    this.focusNode,
    this.textInputAction = TextInputAction.none,
    this.hintText = "Text",
    required this.onchange,
    required this.valid,
    required this.save,
    Key? key,
    required this.controller,
    this.label = "Textfiled",
    this.keybordtype = TextInputType.text,
    this.prefixIcon,
    this.readOnly = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        enabled: readOnly,
        focusNode: focusNode,
        autofocus: false,
        textInputAction: textInputAction,
        maxLines: null,
        keyboardType: keybordtype,
        onChanged: onchange,
        onSaved: save,
        controller: controller,
        validator: valid,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xFFE2E5E6), // Change this to your desired color
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: Color(0xFFE2E5E6), // Change this to your desired color
              width: 1.0,
            ),
          ),
          label: Text(
            label,
            style: TextStyle(
                fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
