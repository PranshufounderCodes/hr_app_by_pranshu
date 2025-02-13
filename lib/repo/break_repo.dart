
import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/helper/network/base_api_services.dart';
import 'package:founder_code_hr_app/helper/network/network_api_services.dart';
import 'package:founder_code_hr_app/model/break_history_model.dart';
import 'package:founder_code_hr_app/res/api_urls.dart';


class BreakRepo {
  final BaseApiServices _apiServices = NetworkApiServices();

// Break In Out Api

  Future<dynamic> breakApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.breakUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during breakApi: $e');
      }
      rethrow;
    }
  }



  // Break History Api

  Future<BreakHistoryModel> breakHistoryApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.breakHistoryUrl, data);
      return BreakHistoryModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during breakHistoryApi: $e');
      }
      rethrow;
    }
  }
}
