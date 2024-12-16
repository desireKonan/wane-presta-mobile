import 'dart:convert';

GetCallEnableOrNotModel getCallEnableOrNotModelFromJson(String str) => GetCallEnableOrNotModel.fromJson(json.decode(str));
String getCallEnableOrNotModelToJson(GetCallEnableOrNotModel data) => json.encode(data.toJson());

class GetCallEnableOrNotModel {
  GetCallEnableOrNotModel({
    bool? status,
    String? message,
    bool? isCallEnable,
  }) {
    _status = status;
    _message = message;
    _isCallEnable = isCallEnable;
  }

  GetCallEnableOrNotModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isCallEnable = json['isCallEnable'];
  }
  bool? _status;
  String? _message;
  bool? _isCallEnable;
  GetCallEnableOrNotModel copyWith({
    bool? status,
    String? message,
    bool? isCallEnable,
  }) =>
      GetCallEnableOrNotModel(
        status: status ?? _status,
        message: message ?? _message,
        isCallEnable: isCallEnable ?? _isCallEnable,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get isCallEnable => _isCallEnable;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isCallEnable'] = _isCallEnable;
    return map;
  }
}
