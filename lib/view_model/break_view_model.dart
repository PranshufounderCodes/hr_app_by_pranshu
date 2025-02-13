import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:founder_code_hr_app/model/break_history_model.dart';
import 'package:founder_code_hr_app/utils/sneck_bar.dart';
import 'package:founder_code_hr_app/view_model/user_view_model.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repo/break_repo.dart';

class BreakProvider extends ChangeNotifier {
  List<String> approvers = ["HR MA'AM", "HARSH SIR ", "SAHIL SIR", "AJAY SIR"];

  final TextEditingController purposeController = TextEditingController();

  bool _isOnBreak = false;
  DateTime? _breakStartTime;
  DateTime? _breakEndTime;
  Duration _totalBreakDuration = Duration.zero;
  Duration _lastBreakDuration = Duration.zero;
  String _breakPurpose = "";

  bool get isOnBreak => _isOnBreak;
  String get breakStartTime => _breakStartTime != null
      ? DateFormat.jm().format(_breakStartTime!)
      : "--:--";
  String get breakEndTime =>
      _breakEndTime != null ? DateFormat.jm().format(_breakEndTime!) : "--:--";
  String get totalBreakDuration => "${_totalBreakDuration.inMinutes} min";
  String get breakPurpose =>
      _breakPurpose.isNotEmpty ? _breakPurpose : "No purpose given";

  String get lastBreakDuration {
    int minutes = _lastBreakDuration.inMinutes;
    int seconds = _lastBreakDuration.inSeconds % 60;
    return "$minutes min $seconds sec";
  }

  BreakProvider() {
    _loadBreakData();
  }

  void startBreak(String purpose) async {
    if (purpose.isEmpty) return;
    _isOnBreak = true;
    _breakStartTime = DateTime.now();
    _breakPurpose = purpose;
    await _saveBreakData();
    notifyListeners();
  }

  void endBreak() async {
    if (_isOnBreak) {
      _breakEndTime = DateTime.now();
      _lastBreakDuration = _breakEndTime!
          .difference(_breakStartTime!); // Store last break duration
      _totalBreakDuration += _lastBreakDuration; // Add to total duration
      _isOnBreak = false;
      _breakPurpose = "";

      await _saveBreakData();
      notifyListeners();
    }
  }

  Future<void> _saveBreakData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isOnBreak", _isOnBreak);
    await prefs.setString(
        "breakStartTime", _breakStartTime?.toIso8601String() ?? "");
    await prefs.setString(
        "breakEndTime", _breakEndTime?.toIso8601String() ?? "");
    await prefs.setInt("totalBreakDuration", _totalBreakDuration.inSeconds);
    await prefs.setInt("lastBreakDuration",
        _lastBreakDuration.inSeconds); // Save last break duration
    await prefs.setString("breakPurpose", _breakPurpose);
  }

  Future<void> _loadBreakData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isOnBreak = prefs.getBool("isOnBreak") ?? false;
    String? startTime = prefs.getString("breakStartTime");
    String? endTime = prefs.getString("breakEndTime");
    int? totalDuration = prefs.getInt("totalBreakDuration");
    int? lastDuration =
    prefs.getInt("lastBreakDuration"); // Load last break duration
    _breakPurpose = prefs.getString("breakPurpose") ?? "";

    _breakStartTime = startTime != null && startTime.isNotEmpty
        ? DateTime.parse(startTime)
        : null;
    _breakEndTime =
    endTime != null && endTime.isNotEmpty ? DateTime.parse(endTime) : null;
    _totalBreakDuration = Duration(seconds: totalDuration ?? 0);
    _lastBreakDuration =
        Duration(seconds: lastDuration ?? 0); // Restore last break duration

    notifyListeners();
  }

  void clearAllFields() {
    _isOnBreak = false;
    _breakStartTime = null;
    _breakEndTime = null;
    _breakPurpose = "";
    _lastBreakDuration = Duration.zero;
    _totalBreakDuration = Duration.zero;

    _saveBreakData();
    notifyListeners();
  }

  final _breakRepo = BreakRepo();

  // Break Add Api

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> breakApi(String approvedBy, context) async {
    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    setLoading(true);
    Map data = {
      "employee_id": userId,
      "break_purpose": breakPurpose,
      "break_start_time": breakStartTime,
      "break_end_time": breakEndTime,
      "break_duration": lastBreakDuration,
      "approved_by": approvedBy
    };

    print(data);
    _breakRepo.breakApi(data).then((value) {
      if (value['status'] == true) {
        setLoading(false);
        showCustomSnackBar(
          value['message'],
          context,
        );
      } else {
        showCustomSnackBar(
          value['message'],
          context,
        );
        setLoading(false);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

// Break History Model

  bool _loadingBH = false;

  bool get loadingBH => _loadingBH;

  setLoadingBH(bool value) {
    _loadingBH = value;
    notifyListeners();
  }

  BreakHistoryModel? _breakHistoryModelData;
  BreakHistoryModel? get breakHistoryModelData => _breakHistoryModelData;

  setBreakHistoryModelData(BreakHistoryModel value) {
    _breakHistoryModelData = value;
    notifyListeners();
  }

  Future<void> breakHistoryApi(context, dynamic searchCon) async {
    setLoadingBH(true);

    UserViewModel userViewModel = UserViewModel();
    String? userId = await userViewModel.getUser();
    Map data = {
      "employee_id": userId,
      "date": searchCon,
    };

    print("ramu $data");

    print(data);
    _breakRepo.breakHistoryApi(data).then((value) {
      if (value.status == true) {
        setLoadingBH(false);
        showCustomSnackBar(
          value.message.toString(),
          context,
        );
        setBreakHistoryModelData(value);
      } else {
        showCustomSnackBar(
          value.message.toString(),
          context,
        );
        setBreakHistoryModelData(value);
        setLoadingBH(false);
      }
    }).onError((error, stackTrace) {
      setLoadingBH(false);
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
