import 'dart:convert';

GetAppointmentTimeModel getAppointmentTimeModelFromJson(String str) => GetAppointmentTimeModel.fromJson(json.decode(str));

String getAppointmentTimeModelToJson(GetAppointmentTimeModel data) => json.encode(data.toJson());

class GetAppointmentTimeModel {
  GetAppointmentTimeModel({
    bool? status,
    String? message,
    bool? isOpen,
    bool? isBreak,
    AllSlots? allSlots,
    List<String>? busySlots,}) {
    _status = status;
    _message = message;
    _isOpen = isOpen;
    _isBreak = isBreak;
    _allSlots = allSlots;
    _busySlots = busySlots;
  }

  GetAppointmentTimeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isOpen = json['isOpen'];
    _isBreak = json['isBreak'];
    _allSlots = json['allSlots'] != null ? AllSlots.fromJson(json['allSlots']) : null;
    _busySlots = json['busySlots'] != null ? json['busySlots'].cast<String>() : [];
  }

  bool? _status;
  String? _message;
  bool? _isOpen;
  bool? _isBreak;
  AllSlots? _allSlots;
  List<String>? _busySlots;

  GetAppointmentTimeModel copyWith({ bool? status,
    String? message,
    bool? isOpen,
    bool? isBreak,
    AllSlots? allSlots,
    List<String>? busySlots,
  }) =>
      GetAppointmentTimeModel(
        status: status ?? _status,
        message: message ?? _message,
        isOpen: isOpen ?? _isOpen,
        isBreak: isBreak ?? _isBreak,
        allSlots: allSlots ?? _allSlots,
        busySlots: busySlots ?? _busySlots,
      );

  bool? get status => _status;

  String? get message => _message;

  bool? get isOpen => _isOpen;

  bool? get isBreak => _isBreak;

  AllSlots? get allSlots => _allSlots;

  List<String>? get busySlots => _busySlots;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['isOpen'] = _isOpen;
    map['isBreak'] = _isBreak;
    if (_allSlots != null) {
      map['allSlots'] = _allSlots?.toJson();
    }
    map['busySlots'] = _busySlots;
    return map;
  }

}

AllSlots allSlotsFromJson(String str) => AllSlots.fromJson(json.decode(str));

String allSlotsToJson(AllSlots data) => json.encode(data.toJson());

class AllSlots {
  AllSlots({
    List<String>? morning,
    List<String>? evening,}) {
    _morning = morning;
    _evening = evening;
  }

  AllSlots.fromJson(dynamic json) {
    _morning = json['morning'] != null ? json['morning'].cast<String>() : [];
    _evening = json['evening'] != null ? json['evening'].cast<String>() : [];
  }

  List<String>? _morning;
  List<String>? _evening;

  AllSlots copyWith({ List<String>? morning,
    List<String>? evening,
  }) =>
      AllSlots(morning: morning ?? _morning,
        evening: evening ?? _evening,
      );

  List<String>? get morning => _morning;

  List<String>? get evening => _evening;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['morning'] = _morning;
    map['evening'] = _evening;
    return map;
  }

}