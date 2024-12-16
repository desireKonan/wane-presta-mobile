import 'dart:convert';

SaveProviderByCustomerModel saveProviderByCustomerModelFromJson(String str) =>
    SaveProviderByCustomerModel.fromJson(json.decode(str));
String saveProviderByCustomerModelToJson(SaveProviderByCustomerModel data) => json.encode(data.toJson());

class SaveProviderByCustomerModel {
  SaveProviderByCustomerModel({
    bool? status,
    String? message,
    bool? providerIsFavorite,
  }) {
    _status = status;
    _message = message;
    _providerIsFavorite = providerIsFavorite;
  }

  SaveProviderByCustomerModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _providerIsFavorite = json['providerIsFavorite'];
  }
  bool? _status;
  String? _message;
  bool? _providerIsFavorite;
  SaveProviderByCustomerModel copyWith({
    bool? status,
    String? message,
    bool? providerIsFavorite,
  }) =>
      SaveProviderByCustomerModel(
        status: status ?? _status,
        message: message ?? _message,
        providerIsFavorite: providerIsFavorite ?? _providerIsFavorite,
      );
  bool? get status => _status;
  String? get message => _message;
  bool? get providerIsFavorite => _providerIsFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['providerIsFavorite'] = _providerIsFavorite;
    return map;
  }
}
