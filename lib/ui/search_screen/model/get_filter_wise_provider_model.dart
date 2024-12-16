import 'dart:convert';

GetFilterWiseProviderModel getFilterWiseProviderModelFromJson(String str) =>
    GetFilterWiseProviderModel.fromJson(json.decode(str));
String getFilterWiseProviderModelToJson(GetFilterWiseProviderModel data) => json.encode(data.toJson());

class GetFilterWiseProviderModel {
  GetFilterWiseProviderModel({
    bool? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetFilterWiseProviderModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
  GetFilterWiseProviderModel copyWith({
    bool? status,
    String? message,
    List<Data>? data,
  }) =>
      GetFilterWiseProviderModel(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? id,
    String? name,
    String? profileImage,
    num? price,
    num? avgRating,
    String? latitude,
    String? longitude,
    bool? isFavorite,
    List<Services>? services,
    num? distance,
  }) {
    _id = id;
    _name = name;
    _profileImage = profileImage;
    _price = price;
    _avgRating = avgRating;
    _latitude = latitude;
    _longitude = longitude;
    _isFavorite = isFavorite;
    _services = services;
    _distance = distance;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _profileImage = json['profileImage'];
    _price = json['price'];
    _avgRating = json['avgRating'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _isFavorite = json['isFavorite'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
    _distance = json['distance'];
  }
  String? _id;
  String? _name;
  String? _profileImage;
  num? _price;
  num? _avgRating;
  String? _latitude;
  String? _longitude;
  bool? _isFavorite;
  List<Services>? _services;
  num? _distance;
  Data copyWith({
    String? id,
    String? name,
    String? profileImage,
    num? price,
    num? avgRating,
    String? latitude,
    String? longitude,
    bool? isFavorite,
    List<Services>? services,
    num? distance,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        profileImage: profileImage ?? _profileImage,
        price: price ?? _price,
        avgRating: avgRating ?? _avgRating,
        latitude: latitude ?? _latitude,
        longitude: longitude ?? _longitude,
        isFavorite: isFavorite ?? _isFavorite,
        services: services ?? _services,
        distance: distance ?? _distance,
      );
  String? get id => _id;
  String? get name => _name;
  String? get profileImage => _profileImage;
  num? get price => _price;
  num? get avgRating => _avgRating;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  bool? get isFavorite => _isFavorite;
  List<Services>? get services => _services;
  num? get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['profileImage'] = _profileImage;
    map['price'] = _price;
    map['avgRating'] = _avgRating;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['isFavorite'] = _isFavorite;
    if (_services != null) {
      map['services'] = _services?.map((v) => v.toJson()).toList();
    }
    map['distance'] = _distance;
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
    bool? isActive,
  }) {
    _serviceId = serviceId;
    _price = price;
    _name = name;
    _image = image;
    _isActive = isActive;
  }

  Services.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _price = json['price'];
    _name = json['name'];
    _image = json['image'];
    _isActive = json['isActive'];
  }
  String? _serviceId;
  num? _price;
  String? _name;
  String? _image;
  bool? _isActive;
  Services copyWith({
    String? serviceId,
    num? price,
    String? name,
    String? image,
    bool? isActive,
  }) =>
      Services(
        serviceId: serviceId ?? _serviceId,
        price: price ?? _price,
        name: name ?? _name,
        image: image ?? _image,
        isActive: isActive ?? _isActive,
      );
  String? get serviceId => _serviceId;
  num? get price => _price;
  String? get name => _name;
  String? get image => _image;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['price'] = _price;
    map['name'] = _name;
    map['image'] = _image;
    map['isActive'] = _isActive;
    return map;
  }
}
