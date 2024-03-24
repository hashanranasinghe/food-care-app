import 'package:flutter/material.dart';
import 'package:food_care/view%20models/report%20view/report_view_model.dart';

import '../../services/api services/report_post.dart';

enum Status { loading, empty, success }

class ReportListViewModel extends ChangeNotifier {
  List<ReportViewModel> reports = <ReportViewModel>[];
  Status status = Status.empty;

  Future<void> getOwnAllReports() async {
    status = Status.loading;
    final results = await ReportApiServices.getOwnReports();
    reports = results.map((report) => ReportViewModel(report: report)).toList();
    status = reports.isEmpty ? Status.empty : Status.success;

    notifyListeners();
  }
}
