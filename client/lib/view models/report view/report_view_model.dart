import 'package:food_care/models/reportModel.dart';

class ReportViewModel {
  final Report report;

  ReportViewModel({required this.report});

  String? get id {
    return report.id;
  }

  String? get userId {
    return report.userId;
  }

  String get description {
    return report.description;
  }

  String get action {
    return report.action;
  }

  Post get post {
    return report.post;
  }
}
