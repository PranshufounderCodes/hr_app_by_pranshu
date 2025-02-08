import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/helper/network/base_api_services.dart';
import 'package:founder_code_hr_app/helper/network/network_api_services.dart';
import 'package:founder_code_hr_app/model/emp_history_model.dart';
import 'package:founder_code_hr_app/res/api_urls.dart';

class AdminEmpRepo {
  final BaseApiServices _apiServices = NetworkApiServices();
// Add Emp By Admin

  Future<dynamic> addEmpApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.addEmpUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during addEmpApi: $e');
      }
      rethrow;
    }
  }

  Future<EmpHistoryModel> empHistoryApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(ApiUrl.empHistoryUrl, data);
      return EmpHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during empHistoryApi: $e');
      }
      rethrow;
    }
  }
}
