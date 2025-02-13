class BreakHistoryModel {
  bool? status;
  String? message;
  List<BreakHistoryData>? breakHistoryData;

  BreakHistoryModel({this.status, this.message, this.breakHistoryData});

  BreakHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      breakHistoryData = <BreakHistoryData>[];
      json['data'].forEach((v) {
        breakHistoryData!.add(BreakHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (breakHistoryData != null) {
      data['data'] = breakHistoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BreakHistoryData {
  int? id;
  int? employeeId;
  String? breakPurpose;
  String? breakStartTime;
  String? breakEndTime;
  String? breakDuration;
  String? approvedBy;
  String? createdAt;
  String? updatedAt;

  BreakHistoryData(
      {this.id,
        this.employeeId,
        this.breakPurpose,
        this.breakStartTime,
        this.breakEndTime,
        this.breakDuration,
        this.approvedBy,
        this.createdAt,
        this.updatedAt});

  BreakHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    breakPurpose = json['break_purpose'];
    breakStartTime = json['break_start_time'];
    breakEndTime = json['break_end_time'];
    breakDuration = json['break_duration'];
    approvedBy = json['approved_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['break_purpose'] = breakPurpose;
    data['break_start_time'] = breakStartTime;
    data['break_end_time'] = breakEndTime;
    data['break_duration'] = breakDuration;
    data['approved_by'] = approvedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
