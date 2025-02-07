
import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/helper/network/base_api_services.dart';
import 'package:founder_code_hr_app/helper/network/network_api_services.dart';
import 'package:founder_code_hr_app/res/api_urls.dart';


class AuthRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
// Login Api

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(ApiUrl.loginUrl, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during loginApi: $e');
      }
      rethrow;
    }
  }
}
