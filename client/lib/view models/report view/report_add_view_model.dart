import 'package:flutter/material.dart';

import '../../models/reportModel.dart';
import '../../services/api services/report_post.dart';

class AddReportViewModel extends ChangeNotifier {
  late String id;

  late String description;
  late String action;
  late Post post;

  Future<int> saveReport() async {

    final report = Report(description: description, action: action, post: post);
    int res = await ReportApiServices.createReport(report: report);

    notifyListeners();
    return res;
  }
}
