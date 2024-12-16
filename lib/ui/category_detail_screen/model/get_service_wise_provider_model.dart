import 'dart:convert';

GetServiceWiseProviderModel getServiceWiseProviderModelFromJson(String str) =>
    GetServiceWiseProviderModel.fromJson(json.decode(str));
String getServiceWiseProviderModelToJson(GetServiceWiseProviderModel data) => json.encode(data.toJson());

class GetServiceWiseProviderModel {
  GetServiceWiseProviderModel({
    bool? status,
    String? message,
    List<GetServiceWiseProviderData>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetServiceWiseProviderModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(GetServiceWiseProviderData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<GetServiceWiseProviderData>? _data;
  GetServiceWiseProviderModel copyWith({
    bool? status,
    String? message,
    List<GetServiceWiseProviderData>? data,
  }) =>
      GetServiceWiseProviderModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<GetServiceWiseProviderData>? get data => _data;

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

GetServiceWiseProviderData dataFromJson(String str) => GetServiceWiseProviderData.fromJson(json.decode(str));
String dataToJson(GetServiceWiseProviderData data) => json.encode(data.toJson());

class GetServiceWiseProviderData {
  GetServiceWiseProviderData({
    String? id,
    String? name,
    String? profileImage,
    num? price,
    num? avgRating,
    bool? isFavorite,
    List<Services>? services,
  }) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
    _price = price;
    _avgRating = avgRating;
    _isFavorite = isFavorite;
    _services = services;
  }

  GetServiceWiseProviderData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _price = json['price'];
    _avgRating = json['avgRating'];
    _isFavorite = json['isFavorite'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  String? _profileImage;
  num? _price;
  num? _avgRating;
  bool? _isFavorite;
  List<Services>? _services;
  GetServiceWiseProviderData copyWith({
    String? id,
    String? name,
    String? profileImage,
    num? price,
    num? avgRating,
    bool? isFavorite,
    List<Services>? services,
  }) =>
      GetServiceWiseProviderData(
        id: id ?? _id,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        price: price ?? _price,
        avgRating: avgRating ?? _avgRating,
        isFavorite: isFavorite ?? _isFavorite,
        services: services ?? _services,
      );
  String? get id => _id;
  String? get name => _name;
  String? get profileImage => _profileImage;
  num? get price => _price;
  num? get avgRating => _avgRating;
  bool? get isFavorite => _isFavorite;
  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['price'] = _price;
    map['avgRating'] = _avgRating;
    map['isFavorite'] = _isFavorite;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));
String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
  Services({
    String? serviceId,
    num? price,
    String? name,
    String? image,
  }) {
    _serviceId = serviceId;
    _price = price;
    _name = name;
    _image = image;
  }

  Services.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _price = json['price'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _serviceId;
  num? _price;
  String? _name;
  String? _image;
  Services copyWith({
    String? serviceId,
    num? price,
    String? name,
    String? image,
  }) =>
      Services(
        serviceId: serviceId ?? _serviceId,
        price: price ?? _price,
        name: name ?? _name,
        image: image ?? _image,
      );
  String? get serviceId => _serviceId;
  num? get price => _price;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['price'] = _price;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }
}