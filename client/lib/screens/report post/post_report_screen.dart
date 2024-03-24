import 'package:flutter/material.dart';
import 'package:food_care/models/reportModel.dart';
import 'package:food_care/services/validate_handeler.dart';
import 'package:food_care/view%20models/forum%20view/forum_list-view_model.dart';
import 'package:food_care/widgets/Gtextformfiled.dart';
import 'package:food_care/widgets/buttons.dart';
import 'package:provider/provider.dart';

import '../../services/navigations.dart';
import '../../utils/constraints.dart';
import '../../view models/food post view/food_post_list_view_model.dart';
import '../../view models/report view/report_add_view_model.dart';
import '../../view models/user view/userViewModel.dart';
import '../../widgets/flutter_toast.dart';

class PostReportScreen extends StatefulWidget {
  final String id;
  final String type;
  const PostReportScreen({super.key, required this.id, required this.type});

  @override
  _PostReportScreenState createState() => _PostReportScreenState();
}

class _PostReportScreenState extends State<PostReportScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  late AddReportViewModel _addReportViewModel;
  late ForumListViewModel _forumListViewModel;
  late FoodPostListViewModel _foodPostListViewModel;
  @override
  void initState() {
    // TODO: implement initState
    _addReportViewModel =
        Provider.of<AddReportViewModel>(context, listen: false);
    if (widget.type == "FOOD") {
      _foodPostListViewModel =
          Provider.of<FoodPostListViewModel>(context, listen: false);
    } else {
      _forumListViewModel =
          Provider.of<ForumListViewModel>(context, listen: false);
    }

    super.initState();
  }

  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      if ((userViewModel.user == null)) {
        userViewModel.getCurrentUser();
        return const Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 2,
            iconTheme: IconThemeData(color: kPrimaryColorDark),
            titleTextStyle: TextStyle(
                color: kPrimaryColorDark,
                fontWeight: FontWeight.w500,
                fontSize: 18),
            title: Text("Report the post"),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: size.height * 0.1),
                  Text(
                    reportText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: size.height * 0.1),
                  Gtextformfiled(
                      label: "Write your complain",
                      onchange: (value) {},
                      valid: (value) {
                        return Validater.genaralvalid(value!);
                      },
                      save: (value) {},
                      controller: _descriptionController),
                  SizedBox(height: size.height * 0.02),
                  Genaralbutton(
                    text: "Submit",
                    onpress: () async {
                      uploadReport(context, userViewModel);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }

  void uploadReport(BuildContext context, UserViewModel user) async {
    if (_form.currentState!.validate()) {
      setState(() {
        _addReportViewModel.id = user.user!.id.toString();
        _addReportViewModel.action = "NO";
        _addReportViewModel.description = _descriptionController.text;
        _addReportViewModel.post = Post(id: widget.id, type: widget.type);
      });
      int res = await _addReportViewModel.saveReport();

      if (res == resOk) {
        print(resOk);
        if (widget.type == "FOOD") {
          await _foodPostListViewModel.getAllFoodPosts();
          openHome(context, user.user!, 0);
        } else {
          await _forumListViewModel.getAllForums();
          openForums(context);
        }

        ToastWidget.toast(msg: "Report sent successfully");
      } else {
        ToastWidget.toast(msg: "Something went to wrong.");
      }
    }
  }
}
