
import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/helper/network/base_api_services.dart';
import 'package:founder_code_hr_app/helper/network/network_api_services.dart';
import 'package:founder_code_hr_app/model/profile_model.dart';
import 'package:founder_code_hr_app/res/api_urls.dart';

class ProfileRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

// Profile Api

  Future<ProfileModel> profileApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(ApiUrl.profileUrl + data);
      return ProfileModel.fromJson(response);
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during profileApi: $e');
      }
      rethrow;
    }
  }

}
