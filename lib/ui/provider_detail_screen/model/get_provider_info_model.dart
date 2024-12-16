import 'dart:convert';

GetProviderInfoModel getProviderInfoModelFromJson(String str) => GetProviderInfoModel.fromJson(json.decode(str));
String getProviderInfoModelToJson(GetProviderInfoModel data) => json.encode(data.toJson());

class GetProviderInfoModel {
  GetProviderInfoModel({
    bool? status,
    String? message,
    ProviderInfo? providerInfo,
  }) {
    _status = status;
    _message = message;
    _providerInfo = providerInfo;
  }

  GetProviderInfoModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _providerInfo = json['providerInfo'] != null ? ProviderInfo.fromJson(json['providerInfo']) : null;
  }
  bool? _status;
  String? _message;
  ProviderInfo? _providerInfo;
  GetProviderInfoModel copyWith({
    bool? status,
    String? message,
    ProviderInfo? providerInfo,
  }) =>
      GetProviderInfoModel(
        status: status ?? _status,
        message: message ?? _message,
        providerInfo: providerInfo ?? _providerInfo,
      );
  bool? get status => _status;
  String? get message => _message;
  ProviderInfo? get providerInfo => _providerInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_providerInfo != null) {
      map['providerInfo'] = _providerInfo?.toJson();
    }
    return map;
  }
}

ProviderInfo providerInfoFromJson(String str) => ProviderInfo.fromJson(json.decode(str));
String providerInfoToJson(ProviderInfo data) => json.encode(data.toJson());

class ProviderInfo {
  ProviderInfo({
    String? id,
    String? name,
    String? mobileNumber,
    String? profileImage,
    List<String>? photoAlbum,
    String? yourSelf,
    String? serviceSummary,
    num? experience,
    List<String>? workHistory,
    String? country,
    num? reviewCount,
    num? avgRating,
    bool? isFavorite,
    num? totalCustomers,
    num? taxRate,
  }) {
    _id = id;
    _name = name;
    _mobileNumber = mobileNumber;
    _profileImage = profileImage;
    _photoAlbum = photoAlbum;
    _yourSelf = yourSelf;
    _serviceSummary = serviceSummary;
    _experience = experience;
    _workHistory = workHistory;
    _country = country;
    _reviewCount = reviewCount;
    _avgRating = avgRating;
    _isFavorite = isFavorite;
    _totalCustomers = totalCustomers;
    _taxRate = taxRate;
  }

  ProviderInfo.fromJson(dynamic json) {
    _id = json['_id'];
    _name = json['name'];
    _mobileNumber = json['mobileNumber'];
    _profileImage = json['profileImage'];
    _photoAlbum = json['photoAlbum'] != null ? json['photoAlbum'].cast<String>() : [];
    _yourSelf = json['yourSelf'];
    _serviceSummary = json['serviceSummary'];
    _experience = json['experience'];
    _workHistory = json['workHistory'] != null ? json['workHistory'].cast<String>() : [];
    _country = json['country'];
    _reviewCount = json['reviewCount'];
    _avgRating = json['avgRating'];
    _isFavorite = json['isFavorite'];
    _totalCustomers = json['totalCustomers'];
    _taxRate = json['taxRate'];
  }
  String? _id;
  String? _name;
  String? _mobileNumber;
  String? _profileImage;
  List<String>? _photoAlbum;
  String? _yourSelf;
  String? _serviceSummary;
  num? _experience;
  List<String>? _workHistory;
  String? _country;
  num? _reviewCount;
  num? _avgRating;
  bool? _isFavorite;
  num? _totalCustomers;
  num? _taxRate;
  ProviderInfo copyWith({
    String? id,
    String? name,
    String? mobileNumber,
    String? profileImage,
    List<String>? photoAlbum,
    String? yourSelf,
    String? serviceSummary,
    num? experience,
    List<String>? workHistory,
    String? country,
    num? reviewCount,
    num? avgRating,
    bool? isFavorite,
    num? totalCustomers,
    num? taxRate,
  }) =>
      ProviderInfo(
        id: id ?? _id,
        name: name ?? _name,
        mobileNumber: mobileNumber ?? _mobileNumber,
        profileImage: profileImage ?? _profileImage,
        photoAlbum: photoAlbum ?? _photoAlbum,
        yourSelf: yourSelf ?? _yourSelf,
        serviceSummary: serviceSummary ?? _serviceSummary,
        experience: experience ?? _experience,
        workHistory: workHistory ?? _workHistory,
        country: country ?? _country,
        reviewCount: reviewCount ?? _reviewCount,
        avgRating: avgRating ?? _avgRating,
        isFavorite: isFavorite ?? _isFavorite,
        totalCustomers: totalCustomers ?? _totalCustomers,
        taxRate: taxRate ?? _taxRate,
      );
  String? get id => _id;
  String? get name => _name;
  String? get mobileNumber => _mobileNumber;
  String? get profileImage => _profileImage;
  List<String>? get photoAlbum => _photoAlbum;
  String? get yourSelf => _yourSelf;
  String? get serviceSummary => _serviceSummary;
  num? get experience => _experience;
  List<String>? get workHistory => _workHistory;
  String? get country => _country;
  num? get reviewCount => _reviewCount;
  num? get avgRating => _avgRating;
  bool? get isFavorite => _isFavorite;
  num? get totalCustomers => _totalCustomers;
  num? get taxRate => _taxRate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['mobileNumber'] = _mobileNumber;
    map['profileImage'] = _profileImage;
    map['photoAlbum'] = _photoAlbum;
    map['yourSelf'] = _yourSelf;
    map['serviceSummary'] = _serviceSummary;
    map['experience'] = _experience;
    map['workHistory'] = _workHistory;
    map['country'] = _country;
    map['reviewCount'] = _reviewCount;
    map['avgRating'] = _avgRating;
    map['isFavorite'] = _isFavorite;
    map['totalCustomers'] = _totalCustomers;
    map['taxRate'] = _taxRate;
    return map;
  }
}
