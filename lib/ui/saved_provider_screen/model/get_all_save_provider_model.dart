import 'dart:convert';

GetAllSaveProviderModel getAllSaveProviderModelFromJson(String str) => GetAllSaveProviderModel.fromJson(json.decode(str));
String getAllSaveProviderModelToJson(GetAllSaveProviderModel data) => json.encode(data.toJson());

class GetAllSaveProviderModel {
  GetAllSaveProviderModel({
    bool? status,
    List<FavoriteProviderData>? data,
  }) {
    _status = status;
    _data = data;
  }

  GetAllSaveProviderModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(FavoriteProviderData.fromJson(v));
      });
    }
  }
  bool? _status;
  List<FavoriteProviderData>? _data;
  GetAllSaveProviderModel copyWith({
    bool? status,
    List<FavoriteProviderData>? data,
  }) =>
      GetAllSaveProviderModel(
        status: status ?? _status,
        data: data ?? _data,
      );
  bool? get status => _status;
  List<FavoriteProviderData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

FavoriteProviderData dataFromJson(String str) => FavoriteProviderData.fromJson(json.decode(str));
String dataToJson(FavoriteProviderData data) => json.encode(data.toJson());

class FavoriteProviderData {
  FavoriteProviderData({
    String? id,
    String? name,
    num? price,
    num? avgRating,
    String? profileImage,
    List<Services>? services,
  }) {
    _id = id;
    _name = name;
    _price = price;
    _avgRating = avgRating;
    _profileImage = profileImage;
    _services = services;
  }

  FavoriteProviderData.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _price = json['price'];
    _avgRating = json['avgRating'];
    _profileImage = json['profileImage'];
    if (json['services'] != null) {
      _services = [];
      json['services'].forEach((v) {
        _services?.add(Services.fromJson(v));
      });
    }
  }
  String? _id;
  String? _name;
  num? _price;
  num? _avgRating;
  String? _profileImage;
  List<Services>? _services;
  FavoriteProviderData copyWith({
    String? id,
    String? name,
    num? price,
    num? avgRating,
    String? profileImage,
    List<Services>? services,
  }) =>
      FavoriteProviderData(
        id: id ?? _id,
        name: name ?? _name,
        price: price ?? _price,
        avgRating: avgRating ?? _avgRating,
        profileImage: profileImage ?? _profileImage,
        services: services ?? _services,
      );
  String? get id => _id;
  String? get name => _name;
  num? get price => _price;
  num? get avgRating => _avgRating;
  String? get profileImage => _profileImage;
  List<Services>? get services => _services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['price'] = _price;
    map['avgRating'] = _avgRating;
    map['profileImage'] = _profileImage;
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
    String? name,
    String? image,
    num? price,
  }) {
    _serviceId = serviceId;
    _name = name;
    _image = image;
    _price = price;
  }

  Services.fromJson(dynamic json) {
    _serviceId = json['serviceId'];
    _name = json['name'];
    _image = json['image'];
    _price = json['price'];
  }
  String? _serviceId;
  String? _name;
  String? _image;
  num? _price;
  Services copyWith({
    String? serviceId,
    String? name,
    String? image,
    num? price,
  }) =>
      Services(
        serviceId: serviceId ?? _serviceId,
        name: name ?? _name,
        image: image ?? _image,
        price: price ?? _price,
      );
  String? get serviceId => _serviceId;
  String? get name => _name;
  String? get image => _image;
  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['serviceId'] = _serviceId;
    map['name'] = _name;
    map['image'] = _image;
    map['price'] = _price;
    return map;
  }
}
