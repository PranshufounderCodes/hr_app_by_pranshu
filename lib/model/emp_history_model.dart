class EmpHistoryModel {
  dynamic success;
  dynamic message;
  List<EmpHistoryData>? empHistoryData;

  EmpHistoryModel({this.success, this.message, this.empHistoryData});

  EmpHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      empHistoryData = <EmpHistoryData>[];
      json['data'].forEach((v) {
        empHistoryData!.add(EmpHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (empHistoryData != null) {
      data['data'] = empHistoryData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmpHistoryData {
  dynamic id;
  dynamic employeeId;
  dynamic name;
  dynamic profileImage;

  EmpHistoryData({this.id, this.employeeId, this.name, this.profileImage});

  EmpHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    name = json['name'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['name'] = name;
    data['profileImage'] = profileImage;
    return data;
  }
}
