class ProfileModel {
  dynamic success;
  dynamic message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic employeeId;
  dynamic name;
  dynamic email;
  dynamic country;
  dynamic phone;
  dynamic designation;
  dynamic department;
  dynamic shift;
  dynamic address;
  dynamic profileImage;
  dynamic password;
  dynamic status;
  dynamic role;
  dynamic totalComingDays;
  dynamic totalAbsentDays;
  dynamic totalHalfDays;
  dynamic punchInStatus;

  Data(
      {this.id,
        this.employeeId,
        this.name,
        this.email,
        this.country,
        this.phone,
        this.designation,
        this.department,
        this.shift,
        this.address,
        this.profileImage,
        this.password,
        this.status,
        this.role,
        this.totalComingDays,
        this.totalAbsentDays,
        this.totalHalfDays,
        this.punchInStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    name = json['name'];
    email = json['email'];
    country = json['country'];
    phone = json['phone'];
    designation = json['designation'];
    department = json['department'];
    shift = json['shift'];
    address = json['address'];
    profileImage = json['profileImage'];
    password = json['password'];
    status = json['status'];
    role = json['role'];
    totalComingDays = json['total_coming_days'];
    totalAbsentDays = json['total_absent_days'];
    totalHalfDays = json['total_half_days'];
    punchInStatus = json['punch_in_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['employee_id'] = employeeId;
    data['name'] = name;
    data['email'] = email;
    data['country'] = country;
    data['phone'] = phone;
    data['designation'] = designation;
    data['department'] = department;
    data['shift'] = shift;
    data['address'] = address;
    data['profileImage'] = profileImage;
    data['password'] = password;
    data['status'] = status;
    data['role'] = role;
    data['total_coming_days'] = totalComingDays;
    data['total_absent_days'] = totalAbsentDays;
    data['total_half_days'] = totalHalfDays;
    data['punch_in_status'] = punchInStatus;
    return data;
  }
}
