// To parse this JSON data, do
//
//     final faqsResponse = faqsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:provider/models/install/paging_model.dart';

import 'status_root.dart';


class FaqsResponse {
  FaqsResponse({
    this.status,
    this.faqs,
    this.paging,
  });

  Status? status;
  List<Faq>? faqs;
  Pagination? paging;

  FaqsResponse copyWith({
    Status? status,
    List<Faq>? faqs,
    Pagination? paging,
  }) =>
      FaqsResponse(
        status: status ?? this.status,
        faqs: faqs ?? this.faqs,
        paging: paging ?? this.paging,
      );

  factory FaqsResponse.fromJson(String str) => FaqsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FaqsResponse.fromMap(Map<String, dynamic> json) => FaqsResponse(
    status: json["status"] == null ? null : Status.fromMap(json["status"]),
    faqs: json["Faqs"] == null ? null : List<Faq>.from(json["Faqs"].map((x) => Faq.fromMap(x))),
    paging: json["paging"] == null ? null : Pagination.fromMap(json["paging"]),
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status!.toMap(),
    "Faqs": faqs == null ? null : List<dynamic>.from(faqs!.map((x) => x.toMap())),
    "paging": paging == null ? null : paging!.toMap(),
  };
}

class Faq {
  Faq({
    this.id,
    this.question,
    this.answer,
  });

  int? id;
  String? question;
  String? answer;

  Faq copyWith({
    int? id,
    String? question,
    String? answer,
  }) =>
      Faq(
        id: id ?? this.id,
        question: question ?? this.question,
        answer: answer ?? this.answer,
      );

  factory Faq.fromJson(String str) => Faq.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Faq.fromMap(Map<String, dynamic> json) => Faq(
    id: json["id"] == null ? null : json["id"],
    question: json["question"] == null ? null : json["question"],
    answer: json["answer"] == null ? null : json["answer"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "question": question == null ? null : question,
    "answer": answer == null ? null : answer,
  };
}


