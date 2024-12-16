import 'dart:convert';

GetAllAppointmentModel getAllAppointmentModelFromJson(String str) => GetAllAppointmentModel.fromJson(json.decode(str));
String getAllAppointmentModelToJson(GetAllAppointmentModel data) => json.encode(data.toJson());

class GetAllAppointmentModel {
  GetAllAppointmentModel({
    bool? status,
    String? message,
    List<GetAllAppointmentData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAllAppointmentModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetAllAppointmentData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetAllAppointmentData>? _data;
  GetAllAppointmentModel copyWith({
    bool? status,
    String? message,
    List<GetAllAppointmentData>? data,
  }) =>
      GetAllAppointmentModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetAllAppointmentData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

GetAllAppointmentData dataFromJson(String str) => GetAllAppointmentData.fromJson(json.decode(str));
String dataToJson(GetAllAppointmentData data) => json.encode(data.toJson());

class GetAllAppointmentData {
  GetAllAppointmentData({
    String? id,
    num? status,
    String? appointmentId,
    String? time,
    String? date,
    num? serviceProviderFee,
    bool? isReviewed,
    String? serviceName,
    String? providerId,
    String? providerName,
    num? provideravgRating,
    String? providerProfileImage,
  }) {
    _id = id;
    _status = status;
    _appointmentId = appointmentId;
    _time = time;
    _date = date;
    _serviceProviderFee = serviceProviderFee;
    _isReviewed = isReviewed;
    _serviceName = serviceName;
    _providerId = providerId;
    _providerName = providerName;
    _provideravgRating = provideravgRating;
    _providerProfileImage = providerProfileImage;
  }

  GetAllAppointmentData.fromJson(dynamic json) {
    _id = json['_id'];
    _status = json['status'];
    _appointmentId = json['appointmentId'];
    _time = json['time'];
    _date = json['date'];
    _serviceProviderFee = json['serviceProviderFee'];
    _isReviewed = json['isReviewed'];
    _serviceName = json['serviceName'];
    _providerId = json['providerId'];
    _providerName = json['providerName'];
    _provideravgRating = json['provideravgRating'];
    _providerProfileImage = json['providerProfileImage'];
  }
  String? _id;
  num? _status;
  String? _appointmentId;
  String? _time;
  String? _date;
  num? _serviceProviderFee;
  bool? _isReviewed;
  String? _serviceName;
  String? _providerId;
  String? _providerName;
  num? _provideravgRating;
  String? _providerProfileImage;
  GetAllAppointmentData copyWith({
    String? id,
    num? status,
    String? appointmentId,
    String? time,
    String? date,
    num? serviceProviderFee,
    bool? isReviewed,
    String? serviceName,
    String? providerId,
    String? providerName,
    num? provideravgRating,
    String? providerProfileImage,
  }) =>
      GetAllAppointmentData(
        id: id ?? _id,
        status: status ?? _status,
        appointmentId: appointmentId ?? _appointmentId,
        time: time ?? _time,
        date: date ?? _date,
        serviceProviderFee: serviceProviderFee ?? _serviceProviderFee,
        isReviewed: isReviewed ?? _isReviewed,
        serviceName: serviceName ?? _serviceName,
        providerId: providerId ?? _providerId,
        providerName: providerName ?? _providerName,
        provideravgRating: provideravgRating ?? _provideravgRating,
        providerProfileImage: providerProfileImage ?? _providerProfileImage,
      );
  String? get id => _id;
  num? get status => _status;
  String? get appointmentId => _appointmentId;
  String? get time => _time;
  String? get date => _date;
  num? get serviceProviderFee => _serviceProviderFee;
  bool? get isReviewed => _isReviewed;
  String? get serviceName => _serviceName;
  String? get providerId => _providerId;
  String? get providerName => _providerName;
  num? get provideravgRating => _provideravgRating;
  String? get providerProfileImage => _providerProfileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['status'] = _status;
    map['appointmentId'] = _appointmentId;
    map['time'] = _time;
    map['date'] = _date;
    map['serviceProviderFee'] = _serviceProviderFee;
    map['isReviewed'] = _isReviewed;
    map['serviceName'] = _serviceName;
    map['providerId'] = _providerId;
    map['providerName'] = _providerName;
    map['provideravgRating'] = _provideravgRating;
    map['providerProfileImage'] = _providerProfileImage;
    return map;
  }
}
