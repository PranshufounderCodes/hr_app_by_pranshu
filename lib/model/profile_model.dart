class ProfileModel {
  bool? success;
  String? message;
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
  int? id;
  String? employeeId;
  String? name;
  String? email;
  String? country;
  String? phone;
  String? designation;
  String? department;
  String? shift;
  String? address;
  String? profileImage;
  String? password;
  int? status;
  int? role;

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
        this.role});

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
    return data;
  }
}
