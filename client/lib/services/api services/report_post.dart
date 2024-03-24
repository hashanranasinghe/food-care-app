import 'dart:convert';

import 'package:food_care/models/reportModel.dart';
import 'package:food_care/utils/config.dart';
import 'package:http/http.dart' as http;

import '../../utils/constraints.dart';
import '../store_token.dart';

class ReportApiServices {
  static var client = http.Client();
  //get all forums
  static Future<List<Report>> getOwnReports() async {
    // Get the JWT token from secure storage
    String? token = await StoreToken.getToken();

    // Send a GET request to the API with the token in the Authorization header
    final response = await client.get(
      Uri.http(Config.apiURL, Config.getOwnReports),
      headers: {'Authorization': 'Bearer $token'},
    );

    // Check if the response was successful and parse the forum information
    if (response.statusCode == 200) {
      final List<dynamic> reportJsonList = json.decode(response.body);
      List<Report> reportList = reportJsonList
          .map((reportJson) => Report.fromJson(reportJson))
          .toList();
      return reportList;
    } else {
      throw Exception('Failed to get reports');
    }
  }

  static Future<int> createReport({required Report report}) async {
    int res = resFail;
    String? token = await StoreToken.getToken();
    var url = Uri.http(Config.apiURL, Config.reports);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = jsonEncode({
      'description': report.description,
      'action': report.action,
      'post': {
        'id': report.post.id,
        'type': report.post.type,
      },
    });

    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      res = resOk;
      return res;
    } else {
      print('Failed to create report. Status code: ${response.statusCode}');
      return res;
    }
  }


}
