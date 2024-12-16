import 'dart:convert';

GetAppointmentInfoModel getAppointmentInfoModelFromJson(String str) => GetAppointmentInfoModel.fromJson(json.decode(str));
String getAppointmentInfoModelToJson(GetAppointmentInfoModel data) => json.encode(data.toJson());

class GetAppointmentInfoModel {
  GetAppointmentInfoModel({
    bool? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetAppointmentInfoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
  GetAppointmentInfoModel copyWith({
    bool? status,
    String? message,
    Data? data,
  }) =>
      GetAppointmentInfoModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    num? status,
    String? appointmentId,
    String? time,
    String? date,
    num? taxAmount,
    num? discountAmount,
    num? serviceProviderFee,
    String? serviceId,
    String? serviceName,
    String? providerId,
    String? providerName,
    String? providerProfileImage,
    num? provideravgRating,
  }) {
    _id = id;
    _status = status;
    _appointmentId = appointmentId;
    _time = time;
    _date = date;
    _taxAmount = taxAmount;
    _discountAmount = discountAmount;
    _serviceProviderFee = serviceProviderFee;
    _serviceId = serviceId;
    _serviceName = serviceName;
    _providerId = providerId;
    _providerName = providerName;
    _providerProfileImage = providerProfileImage;
    _provideravgRating = provideravgRating;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _status = json['status'];
    _appointmentId = json['appointmentId'];
    _time = json['time'];
    _date = json['date'];
    _taxAmount = json['taxAmount'];
    _discountAmount = json['discountAmount'];
    _serviceProviderFee = json['serviceProviderFee'];
    _serviceId = json['serviceId'];
    _serviceName = json['serviceName'];
    _providerId = json['providerId'];
    _providerName = json['providerName'];
    _providerProfileImage = json['providerProfileImage'];
    _provideravgRating = json['provideravgRating'];
  }
  String? _id;
  num? _status;
  String? _appointmentId;
  String? _time;
  String? _date;
  num? _taxAmount;
  num? _discountAmount;
  num? _serviceProviderFee;
  String? _serviceId;
  String? _serviceName;
  String? _providerId;
  String? _providerName;
  String? _providerProfileImage;
  num? _provideravgRating;
  Data copyWith({
    String? id,
    num? status,
    String? appointmentId,
    String? time,
    String? date,
    num? taxAmount,
    num? discountAmount,
    num? serviceProviderFee,
    String? serviceId,
    String? serviceName,
    String? providerId,
    String? providerName,
    String? providerProfileImage,
    num? provideravgRating,
  }) =>
      Data(
        id: id ?? _id,
        status: status ?? _status,
        appointmentId: appointmentId ?? _appointmentId,
        time: time ?? _time,
        date: date ?? _date,
        taxAmount: taxAmount ?? _taxAmount,
        discountAmount: discountAmount ?? _discountAmount,
        serviceProviderFee: serviceProviderFee ?? _serviceProviderFee,
        serviceId: serviceId ?? _serviceId,
        serviceName: serviceName ?? _serviceName,
        providerId: providerId ?? _providerId,
        providerName: providerName ?? _providerName,
        providerProfileImage: providerProfileImage ?? _providerProfileImage,
        provideravgRating: provideravgRating ?? _provideravgRating,
      );
  String? get id => _id;
  num? get status => _status;
  String? get appointmentId => _appointmentId;
  String? get time => _time;
  String? get date => _date;
  num? get taxAmount => _taxAmount;
  num? get discountAmount => _discountAmount;
  num? get serviceProviderFee => _serviceProviderFee;
  String? get serviceId => _serviceId;
  String? get serviceName => _serviceName;
  String? get providerId => _providerId;
  String? get providerName => _providerName;
  String? get providerProfileImage => _providerProfileImage;
  num? get provideravgRating => _provideravgRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['status'] = _status;
    map['appointmentId'] = _appointmentId;
    map['time'] = _time;
    map['date'] = _date;
    map['taxAmount'] = _taxAmount;
    map['discountAmount'] = _discountAmount;
    map['serviceProviderFee'] = _serviceProviderFee;
    map['serviceId'] = _serviceId;
    map['serviceName'] = _serviceName;
    map['providerId'] = _providerId;
    map['providerName'] = _providerName;
    map['providerProfileImage'] = _providerProfileImage;
    map['provideravgRating'] = _provideravgRating;
    return map;
  }
}
