// To parse this JSON data, do
//
//     final offerResponse = offerResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/offer/offer_model.dart';

class OfferResponse {
  OfferResponse({
    this.data,
  });

  Offer? data;

  OfferResponse copyWith({
    Offer? data,
  }) =>
      OfferResponse(
        data: data ?? this.data,
      );

  factory OfferResponse.fromJson(String str) => OfferResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfferResponse.fromMap(Map<String, dynamic> json) => OfferResponse(
    data: json["data"] == null ? null : Offer.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data == null ? null : data!.toMap(),
  };
}


