//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class BreakProvider extends ChangeNotifier {
//   bool _isOnBreak = false;
//   DateTime? _breakStartTime;
//   DateTime? _breakEndTime;
//   Duration _totalBreakDuration = Duration.zero;
//   String _breakPurpose = "";
//
//   bool get isOnBreak => _isOnBreak;
//   String get breakStartTime => _breakStartTime != null
//       ? DateFormat.jm().format(_breakStartTime!)
//       : "--:--";
//   String get breakEndTime =>
//       _breakEndTime != null ? DateFormat.jm().format(_breakEndTime!) : "--:--";
//   String get totalBreakDuration => "${_totalBreakDuration.inMinutes} min";
//   String get breakPurpose =>
//       _breakPurpose.isNotEmpty ? _breakPurpose : "No purpose given";
//
//   BreakProvider() {
//     _loadBreakData();
//   }
//
//   void startBreak(String purpose) async {
//     if (purpose.isEmpty) return;
//     _isOnBreak = true;
//     _breakStartTime = DateTime.now();
//     _breakPurpose = purpose;
//     await _saveBreakData();
//     notifyListeners();
//   }
//
//
//   Duration _lastBreakDuration = Duration.zero;
//
//   void endBreak() async {
//     if (_isOnBreak) {
//       _breakEndTime = DateTime.now();
//       _lastBreakDuration = _breakEndTime!.difference(_breakStartTime!);
//       _totalBreakDuration += _lastBreakDuration;
//       _isOnBreak = false;
//       _breakPurpose = "";
//
//       await _saveBreakData();
//       notifyListeners();
//     }
//   }
//
//   String get lastBreakDuration {
//     int minutes = _lastBreakDuration.inMinutes;
//     int seconds = _lastBreakDuration.inSeconds % 60;
//     return "$minutes min $seconds sec";
//   }
//
//
//   Future<void> _saveBreakData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setBool("isOnBreak", _isOnBreak);
//     await prefs.setString("breakStartTime", _breakStartTime?.toIso8601String() ?? "");
//     await prefs.setString("breakEndTime", _breakEndTime?.toIso8601String() ?? "");
//     await prefs.setInt("totalBreakDuration", _totalBreakDuration.inSeconds);
//     await prefs.setString("breakPurpose", _breakPurpose);
//   }
//
//   Future<void> _loadBreakData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     _isOnBreak = prefs.getBool("isOnBreak") ?? false;
//     String? startTime = prefs.getString("breakStartTime");
//     String? endTime = prefs.getString("breakEndTime");
//     int? duration = prefs.getInt("totalBreakDuration");
//     _breakPurpose = prefs.getString("breakPurpose") ?? "";
//
//     _breakStartTime =
//     startTime != null && startTime.isNotEmpty ? DateTime.parse(startTime) : null;
//     _breakEndTime =
//     endTime != null && endTime.isNotEmpty ? DateTime.parse(endTime) : null;
//     _totalBreakDuration = Duration(seconds: duration ?? 0);
//
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BreakProvider extends ChangeNotifier {
  bool _isOnBreak = false;
  DateTime? _breakStartTime;
  DateTime? _breakEndTime;
  Duration _totalBreakDuration = Duration.zero;
  Duration _lastBreakDuration = Duration.zero; // Added last break duration
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
      _lastBreakDuration = _breakEndTime!.difference(_breakStartTime!); // Store last break duration
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
    await prefs.setString("breakStartTime", _breakStartTime?.toIso8601String() ?? "");
    await prefs.setString("breakEndTime", _breakEndTime?.toIso8601String() ?? "");
    await prefs.setInt("totalBreakDuration", _totalBreakDuration.inSeconds);
    await prefs.setInt("lastBreakDuration", _lastBreakDuration.inSeconds); // Save last break duration
    await prefs.setString("breakPurpose", _breakPurpose);
  }

  Future<void> _loadBreakData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isOnBreak = prefs.getBool("isOnBreak") ?? false;
    String? startTime = prefs.getString("breakStartTime");
    String? endTime = prefs.getString("breakEndTime");
    int? totalDuration = prefs.getInt("totalBreakDuration");
    int? lastDuration = prefs.getInt("lastBreakDuration"); // Load last break duration
    _breakPurpose = prefs.getString("breakPurpose") ?? "";

    _breakStartTime =
    startTime != null && startTime.isNotEmpty ? DateTime.parse(startTime) : null;
    _breakEndTime =
    endTime != null && endTime.isNotEmpty ? DateTime.parse(endTime) : null;
    _totalBreakDuration = Duration(seconds: totalDuration ?? 0);
    _lastBreakDuration = Duration(seconds: lastDuration ?? 0); // Restore last break duration

    notifyListeners();
  }
}
