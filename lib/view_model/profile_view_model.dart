import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:founder_code_hr_app/model/profile_model.dart';
import 'package:founder_code_hr_app/repo/profile_repo.dart';
import 'package:founder_code_hr_app/utils/routes/routes_name.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';

class ProfileViewModel with ChangeNotifier {
  final _profileRepo = ProfileRepository();

  ProfileModel? _modelData;
  ProfileModel? get modelData => _modelData;

  void setModelData(ProfileModel name) {
    _modelData = name;
    notifyListeners();
  }

  Future<void> profileApi(context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    print("ramu$userId");
    _profileRepo.profileApi(userId).then((value) {
      if (value.success == true) {
        setModelData(value);
      } else {
        if (value.success == false) {
          UserViewModel userViewModel = UserViewModel();
          userViewModel.remove();
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.loginScreen,
            (Route<dynamic> route) => false,
          );
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
