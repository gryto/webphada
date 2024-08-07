class ModelContent {
  bool? status;
  String? message;
  List<Data>? data;

  ModelContent({this.status, this.message, this.data});

  ModelContent.fromJson(Map<String, dynamic> json) {
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
  int? contentId;
  String? contentDate;
  String? contentTime;
  String? contentTextIn;
  String? contentTextEn;
  int? satkerId;
  String? satkerName;
  int? componentId;
  String? componentName;
  int? menuId;
  String? menuName;

  Data(
      {this.contentId,
      this.contentDate,
      this.contentTime,
      this.contentTextIn,
      this.contentTextEn,
      this.satkerId,
      this.satkerName,
      this.componentId,
      this.componentName,
      this.menuId,
      this.menuName});

  Data.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    contentDate = json['content_date'];
    contentTime = json['content_time'];
    contentTextIn = json['content_text_in'];
    contentTextEn = json['content_text_en'];
    satkerId = json['satker_id'];
    satkerName = json['satker_name'];
    componentId = json['component_id'];
    componentName = json['component_name'];
    menuId = json['menu_id'];
    menuName = json['menu_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content_id'] = contentId;
    data['content_date'] = contentDate;
    data['content_time'] = contentTime;
    data['content_text_in'] = contentTextIn;
    data['content_text_en'] = contentTextEn;
    data['satker_id'] = satkerId;
    data['satker_name'] = satkerName;
    data['component_id'] = componentId;
    data['component_name'] = componentName;
    data['menu_id'] = menuId;
    data['menu_name'] = menuName;
    return data;
  }
}

parseContent(rsp) {
  if (rsp == null) {
    return {};
  }

  final parsed = ModelContent.fromJson(rsp);
  return parsed;
}
