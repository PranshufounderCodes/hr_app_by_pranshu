import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BreakProvider extends ChangeNotifier {
  bool _isOnBreak = false;
  DateTime? _breakStartTime;
  DateTime? _breakEndTime;
  Duration _totalBreakDuration = Duration.zero;
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

  void startBreak(String purpose) {
    if (purpose.isEmpty) return; // Prevent start without a purpose
    _isOnBreak = true;
    _breakStartTime = DateTime.now();
    _breakPurpose = purpose;
    notifyListeners();
  }

  void endBreak() {
    if (_isOnBreak) {
      _breakEndTime = DateTime.now();
      _totalBreakDuration += _breakEndTime!.difference(_breakStartTime!);
      _isOnBreak = false;
      _breakPurpose = ""; // Reset purpose after ending break
      notifyListeners();
    }
  }
}
