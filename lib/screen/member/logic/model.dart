class ModelSatker {
  bool? status;
  String? message;
  List<Data>? data;

  ModelSatker({this.status, this.message, this.data});

  ModelSatker.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? satkerId;
  int? satkerType;
  String? satkerName;
  String? satkerPhone;
  String? satkerEmail;
  String? satkerAddress;
  String? satkerLatitude;
  String? satkerLongitude;
  String? satkerDescription;
  String? satkerUrl;
  int? satkerStatus;
  String? createdAt;
  String? updatedAt;
  String? lastUser;

  Data(
      {this.satkerId,
      this.satkerType,
      this.satkerName,
      this.satkerPhone,
      this.satkerEmail,
      this.satkerAddress,
      this.satkerLatitude,
      this.satkerLongitude,
      this.satkerDescription,
      this.satkerUrl,
      this.satkerStatus,
      this.createdAt,
      this.updatedAt,
      this.lastUser});

  Data.fromJson(Map<String, dynamic> json) {
    satkerId = json['satker_id'];
    satkerType = json['satker_type'];
    satkerName = json['satker_name'];
    satkerPhone = json['satker_phone'];
    satkerEmail = json['satker_email'];
    satkerAddress = json['satker_address'];
    satkerLatitude = json['satker_latitude'];
    satkerLongitude = json['satker_longitude'];
    satkerDescription = json['satker_description'];
    satkerUrl = json['satker_url'];
    satkerStatus = json['satker_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastUser = json['last_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['satker_id'] = satkerId;
    data['satker_type'] = satkerType;
    data['satker_name'] = satkerName;
    data['satker_phone'] = satkerPhone;
    data['satker_email'] = satkerEmail;
    data['satker_address'] = satkerAddress;
    data['satker_latitude'] = satkerLatitude;
    data['satker_longitude'] = satkerLongitude;
    data['satker_description'] = satkerDescription;
    data['satker_url'] = satkerUrl;
    data['satker_status'] = satkerStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_user'] = lastUser;
    return data;
  }
}

parseSatker(rsp) {
  if (rsp == null) {
    return {};
  }

  final parsed = ModelSatker.fromJson(rsp);
  return parsed;
}
