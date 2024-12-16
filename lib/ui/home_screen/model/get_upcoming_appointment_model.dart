// To parse this JSON data, do
//
//     final getUpcomingAppointmentModel = getUpcomingAppointmentModelFromJson(jsonString);

import 'dart:convert';

GetUpcomingAppointmentModel getUpcomingAppointmentModelFromJson(String str) =>
    GetUpcomingAppointmentModel.fromJson(json.decode(str));

String getUpcomingAppointmentModelToJson(GetUpcomingAppointmentModel data) => json.encode(data.toJson());

class GetUpcomingAppointmentModel {
  bool? status;
  String? message;
  List<Datum>? data;

  GetUpcomingAppointmentModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetUpcomingAppointmentModel.fromJson(Map<String, dynamic> json) => GetUpcomingAppointmentModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Coupon? coupon;
  String? id;
  Customer? customer;
  Customer? provider;
  Service? service;
  int? status;
  String? appointmentId;
  String? serviceDetails;
  List<dynamic>? image;
  String? time;
  int? duration;
  String? date;
  int? taxRate;
  int? taxAmount;
  int? discountAmount;
  int? serviceProviderFee;
  int? amountAfterTax;
  int? netPayableAmount;
  int? adminCommissionRate;
  int? adminCommissionAmount;
  int? providerNetEarnings;
  String? checkInTime;
  String? checkOutTime;
  bool? isReviewed;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.coupon,
    this.id,
    this.customer,
    this.provider,
    this.service,
    this.status,
    this.appointmentId,
    this.serviceDetails,
    this.image,
    this.time,
    this.duration,
    this.date,
    this.taxRate,
    this.taxAmount,
    this.discountAmount,
    this.serviceProviderFee,
    this.amountAfterTax,
    this.netPayableAmount,
    this.adminCommissionRate,
    this.adminCommissionAmount,
    this.providerNetEarnings,
    this.checkInTime,
    this.checkOutTime,
    this.isReviewed,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
        id: json["_id"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        provider: json["provider"] == null ? null : Customer.fromJson(json["provider"]),
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
        status: json["status"],
        appointmentId: json["appointmentId"],
        serviceDetails: json["serviceDetails"],
        image: json["image"] == null ? [] : List<dynamic>.from(json["image"]!.map((x) => x)),
        time: json["time"],
        duration: json["duration"],
        date: json["date"],
        taxRate: json["taxRate"],
        taxAmount: json["taxAmount"],
        discountAmount: json["discountAmount"],
        serviceProviderFee: json["serviceProviderFee"],
        amountAfterTax: json["amountAfterTax"],
        netPayableAmount: json["netPayableAmount"],
        adminCommissionRate: json["adminCommissionRate"],
        adminCommissionAmount: json["adminCommissionAmount"],
        providerNetEarnings: json["providerNetEarnings"],
        checkInTime: json["checkInTime"],
        checkOutTime: json["checkOutTime"],
        isReviewed: json["isReviewed"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "coupon": coupon?.toJson(),
        "_id": id,
        "customer": customer?.toJson(),
        "provider": provider?.toJson(),
        "service": service?.toJson(),
        "status": status,
        "appointmentId": appointmentId,
        "serviceDetails": serviceDetails,
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "time": time,
        "duration": duration,
        "date": date,
        "taxRate": taxRate,
        "taxAmount": taxAmount,
        "discountAmount": discountAmount,
        "serviceProviderFee": serviceProviderFee,
        "amountAfterTax": amountAfterTax,
        "netPayableAmount": netPayableAmount,
        "adminCommissionRate": adminCommissionRate,
        "adminCommissionAmount": adminCommissionAmount,
        "providerNetEarnings": providerNetEarnings,
        "checkInTime": checkInTime,
        "checkOutTime": checkOutTime,
        "isReviewed": isReviewed,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Coupon {
  String? title;
  String? description;
  dynamic code;
  dynamic discountType;
  dynamic maxDiscount;
  int? minAmountToApply;

  Coupon({
    this.title,
    this.description,
    this.code,
    this.discountType,
    this.maxDiscount,
    this.minAmountToApply,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
        title: json["title"],
        description: json["description"],
        code: json["code"],
        discountType: json["discountType"],
        maxDiscount: json["maxDiscount"],
        minAmountToApply: json["minAmountToApply"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "code": code,
        "discountType": discountType,
        "maxDiscount": maxDiscount,
        "minAmountToApply": minAmountToApply,
      };
}

class Customer {
  String? id;
  String? name;
  String? profileImage;
  int? avgRating;

  Customer({
    this.id,
    this.name,
    this.profileImage,
    this.avgRating,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        name: json["name"],
        profileImage: json["profileImage"],
        avgRating: json["avgRating"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profileImage": profileImage,
        "avgRating": avgRating,
      };
}

class Service {
  String? id;
  String? name;
  String? image;

  Service({
    this.id,
    this.name,
    this.image,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "image": image,
      };
}
