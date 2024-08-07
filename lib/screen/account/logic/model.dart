class ModelUser {
  bool? status;
  String? message;
  Data? data;

  ModelUser({this.status, this.message, this.data});

  ModelUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  int? userType;
  String? userAccount;
  String? userCode;
  String? userFullname;
  String? userPhone;
  String? userEmail;
  String? userAddress;
  int? userStatus;
  String? userLogin;
  String? userToken;
  String? userImage;
  String? userPath;
  String? satkerId;
  String? satkerName;
  String? roleId;
  String? roleName;
  String? createdAt;
  String? updatedAt;
  String? lastUser;

  Data(
      {this.userId,
      this.userType,
      this.userAccount,
      this.userCode,
      this.userFullname,
      this.userPhone,
      this.userEmail,
      this.userAddress,
      this.userStatus,
      this.userLogin,
      this.userToken,
      this.userImage,
      this.userPath,
      this.satkerId,
      this.satkerName,
      this.roleId,
      this.roleName,
      this.createdAt,
      this.updatedAt,
      this.lastUser});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userType = json['user_type'];
    userAccount = json['user_account'];
    userCode = json['user_code'];
    userFullname = json['user_fullname'];
    userPhone = json['user_phone'];
    userEmail = json['user_email'];
    userAddress = json['user_address'];
    userStatus = json['user_status'];
    userLogin = json['user_login'];
    userToken = json['user_token'];
    userImage = json['user_image'];
    userPath = json['user_path'];
    satkerId = json['satker_id'];
    satkerName = json['satker_name'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastUser = json['last_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_type'] = userType;
    data['user_account'] = userAccount;
    data['user_code'] = userCode;
    data['user_fullname'] = userFullname;
    data['user_phone'] = userPhone;
    data['user_email'] = userEmail;
    data['user_address'] = userAddress;
    data['user_status'] = userStatus;
    data['user_login'] = userLogin;
    data['user_token'] = userToken;
    data['user_image'] = userImage;
    data['user_path'] = userPath;
    data['satker_id'] = satkerId;
    data['satker_name'] = satkerName;
    data['role_id'] = roleId;
    data['role_name'] = roleName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_user'] = lastUser;
    return data;
  }
}

parseUser(rsp) {
  if (rsp == null) {
    return {};
  }

  final parsed = ModelUser.fromJson(rsp);
  return parsed;
}
