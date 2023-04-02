import 'package:flutter/material.dart';
import 'package:food_care/services/navigations.dart';
import 'package:food_care/utils/constraints.dart';
import '../../services/api services/user_api_services.dart';
import '../../services/validate_handeler.dart';
import '../../widgets/Gtextformfiled.dart';
import '../../widgets/buttons.dart';
import '../../widgets/flutter_toast.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;
  const ResetPasswordScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String id = '';
  String token = '';
  String password = '';
  String confirmPassword = '';
  final _form = GlobalKey<FormState>();

  _splitToken() {
    List<String> parts = widget.token.split("/");
    id = parts[0];
    token = parts[1];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splitToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Gpasswordformfiled(
              valid: (text) {
                return Validater.signupPassword(text!);
              },
              icon: Icons.lock_outline,
              onchange: (text) {
                password = text;
              },
              save: (text) {
                password = text!;
              },
            ),
            Gpasswordformfiled(
              hintText: "Confirm Password",
              valid: (text) {
                return Validater.confirmPassword(password, text!);
              },
              icon: Icons.lock_outline,
              onchange: (text) {
                confirmPassword = text;
              },
              save: (text) {
                confirmPassword = text!;
              },
            ),
            Genaralbutton(
              pleft: 100,
              pright: 100,
              onpress: () {
                reset();
              },
              text: "Reset Password",
            ),
          ],
        ),
      ),
    );
  }

  void reset() async {
    if (_form.currentState!.validate()) {
      int res = await UserAPiServices.resetPassword(
          password: password, id: id, token: token);

      if (res == resOk) {
        openUserSignIn(context);
        ToastWidget.toast(msg: "Password is updated successfully");
      } else if(res == 401) {
        ToastWidget.toast(msg: "Reset link is expired.");
      }else if(res == 404){
        ToastWidget.toast(msg: "You cannot use same link for change password again.");
      }else{
        ToastWidget.toast(msg: "Something went to wrong.");
      }
    }
  }
}
