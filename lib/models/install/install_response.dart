import 'dart:convert';

import 'package:provider/models/install/advertisements_model.dart';
import 'package:provider/models/install/setting_model.dart';
import 'package:provider/models/install/status_root.dart';

import 'category_model.dart';
import 'country_model.dart';

class InstallResponse {
  InstallResponse({
    this.status,
    this.data,
    this.paging,
  });

  Status? status;
  Data? data;
  dynamic paging;

  InstallResponse copyWith({
    Status? status,
    Data? data,
    dynamic paging,
  }) =>
      InstallResponse(
        status: status ?? this.status,
        data: data ?? this.data,
        paging: paging ?? this.paging,
      );

  // factory InstallResponse.fromJson(String str) => InstallResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory InstallResponse.fromMap(Map<String, dynamic> json) => InstallResponse(
    status: json["status"] == null ? null : Status.fromMap(json["status"]),
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
    paging: json["paging"],
  );

  Map<String, dynamic> toMap() => {
    "status": status == null ? null : status!.toMap(),
    "data": data == null ? null : data!.toMap(),
    "paging": paging,
  };

  factory InstallResponse.fromJson(String str) => InstallResponse.fromMap(json.decode(str));
}


class Data {
  Data({
    this.settings,
    this.countries,
    this.categories,
    this.advertisements,
    this.splashScreens,
   });

  Settings? settings;
  List<Country>? countries;
  List<Category>? categories;
  List<Advertisement>? advertisements;
  List<SplashScreen>? splashScreens;


  Data copyWith({
    Settings? settings,
    List<Country>? countries,
    List<Category>? categories,
    List<Advertisement>? advertisements,
    List<SplashScreen>? splashScreens,


  }) =>
      Data(
        settings: settings ?? this.settings,
        countries: countries ?? this.countries,
        categories: categories ?? this.categories,
        advertisements: advertisements ?? this.advertisements,
        splashScreens: splashScreens ?? this.splashScreens,

      );
  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    settings: Settings.fromMap(json["Settings"]),
    countries: json["Countries"] == null ? null : List<Country>.from(json["Countries"].map((x) => Country.fromMap(x))),
    categories: json["Categories"] == null ? null : List<Category>.from(json["Categories"].map((x) => Category.fromMap(x))),
    advertisements: json["Advertisements"] == null ? null : List<Advertisement>.from(json["Advertisements"].map((x) => Advertisement.fromMap(x))),
    splashScreens: json["SplashScreens"] == null ? null : List<SplashScreen>.from(json["SplashScreens"].map((x) => SplashScreen.fromMap(x))),

  );

  Map<String, dynamic> toMap() => {
    "Settings": settings?.toMap(),
    "Countries": countries == null ? null :  List<dynamic>.from(countries!.map((x) => x.toMap())),
    "Categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toMap())),
    "Advertisements": advertisements == null ? null : List<dynamic>.from(advertisements!.map((x) => x.toMap())),
    "SplashScreens": splashScreens == null ? null : List<dynamic>.from(splashScreens!.map((x) => x.toMap())),

  };
}
class NotificationType {
  NotificationType({
    this.general,
    this.ticket,
    this.order,
  });

  int? general;
  int? ticket;
  int? order;

  NotificationType copyWith({
    int? general,
    int? ticket,
    int? order,
  }) =>
      NotificationType(
        general: general ?? this.general,
        ticket: ticket ?? this.ticket,
        order: order ?? this.order,
      );

  factory NotificationType.fromJson(String str) => NotificationType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NotificationType.fromMap(Map<String, dynamic> json) => NotificationType(
    general: json["General"],
    ticket: json["Ticket"],
    order: json["Order"],
  );

  Map<String, dynamic> toMap() => {
    "General": general,
    "Ticket": ticket,
    "Order": order,
  };
}

class OrderStatuses {
  OrderStatuses({
    this.orderStatusesNew,
    this.providerAccept,
    this.providerRejected,
    this.customerAccept,
    this.customerRejected,
    this.inProgress,
    this.finished,
  });

  int? orderStatusesNew;
  int? providerAccept;
  int? providerRejected;
  int? customerAccept;
  int? customerRejected;
  int? inProgress;
  int? finished;

  OrderStatuses copyWith({
    int? orderStatusesNew,
    int? providerAccept,
    int? providerRejected,
    int? customerAccept,
    int? customerRejected,
    int? inProgress,
    int? finished,
  }) =>
      OrderStatuses(
        orderStatusesNew: orderStatusesNew ?? this.orderStatusesNew,
        providerAccept: providerAccept ?? this.providerAccept,
        providerRejected: providerRejected ?? this.providerRejected,
        customerAccept: customerAccept ?? this.customerAccept,
        customerRejected: customerRejected ?? this.customerRejected,
        inProgress: inProgress ?? this.inProgress,
        finished: finished ?? this.finished,
      );

  factory OrderStatuses.fromJson(String str) => OrderStatuses.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderStatuses.fromMap(Map<String, dynamic> json) => OrderStatuses(
    orderStatusesNew: json["New"],
    providerAccept: json["Provider_Accept"],
    providerRejected: json["Provider_Rejected"],
    customerAccept: json["Customer_Accept"],
    customerRejected: json["Customer_Rejected"],
    inProgress: json["InProgress"],
    finished: json["Finished"],
  );

  Map<String, dynamic> toMap() => {
    "New": orderStatusesNew,
    "Provider_Accept": providerAccept,
    "Provider_Rejected": providerRejected,
    "Customer_Accept": customerAccept,
    "Customer_Rejected": customerRejected,
    "InProgress": inProgress,
    "Finished": finished,
  };
}

class PaymentMethods {
  PaymentMethods({
    this.bankTransfer,
    this.cash,
  });

  int? bankTransfer;
  int? cash;

  PaymentMethods copyWith({
    int? bankTransfer,
    int? cash,
  }) =>
      PaymentMethods(
        bankTransfer: bankTransfer ?? this.bankTransfer,
        cash: cash ?? this.cash,
      );

  factory PaymentMethods.fromJson(String str) => PaymentMethods.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethods.fromMap(Map<String, dynamic> json) => PaymentMethods(
    bankTransfer: json["BankTransfer"],
    cash: json["Cash"],
  );

  Map<String, dynamic> toMap() => {
    "BankTransfer": bankTransfer,
    "Cash": cash,
  };
}

class ProviderTypes {
  ProviderTypes({
    this.side,
    this.specialist,
    this.expert,
  });

  int? side;
  int? specialist;
  int? expert;

  ProviderTypes copyWith({
    int? side,
    int? specialist,
    int? expert,
  }) =>
      ProviderTypes(
        side: side ?? this.side,
        specialist: specialist ?? this.specialist,
        expert: expert ?? this.expert,
      );

  factory ProviderTypes.fromJson(String str) => ProviderTypes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProviderTypes.fromMap(Map<String, dynamic> json) => ProviderTypes(
    side: json["Side"],
    specialist: json["Specialist"],
    expert: json["Expert"],
  );

  Map<String, dynamic> toMap() => {
    "Side": side,
    "Specialist": specialist,
    "Expert": expert,
  };
}


class TransactionStatus {
  TransactionStatus({
    this.pending,
    this.paid,
  });

  int? pending;
  int? paid;

  TransactionStatus copyWith({
    int? pending,
    int? paid,
  }) =>
      TransactionStatus(
        pending: pending ?? this.pending,
        paid: paid ?? this.paid,
      );

  factory TransactionStatus.fromJson(String str) => TransactionStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionStatus.fromMap(Map<String, dynamic> json) => TransactionStatus(
    pending: json["Pending"],
    paid: json["Paid"],
  );

  Map<String, dynamic> toMap() => {
    "Pending": pending,
    "Paid": paid,
  };
}

class TransactionTypes {
  TransactionTypes({
    this.deposit,
    this.withdraw,
    this.holding,
  });

  int? deposit;
  int? withdraw;
  int? holding;

  TransactionTypes copyWith({
    int? deposit,
    int? withdraw,
    int? holding,
  }) =>
      TransactionTypes(
        deposit: deposit ?? this.deposit,
        withdraw: withdraw ?? this.withdraw,
        holding: holding ?? this.holding,
      );

  factory TransactionTypes.fromJson(String str) => TransactionTypes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransactionTypes.fromMap(Map<String, dynamic> json) => TransactionTypes(
    deposit: json["Deposit"],
    withdraw: json["Withdraw"],
    holding: json["Holding"],
  );

  Map<String, dynamic> toMap() => {
    "Deposit": deposit,
    "Withdraw": withdraw,
    "Holding": holding,
  };
}

class UserStatus {
  UserStatus({
    this.active,
    this.notComplete,
    this.deactivate,
    this.underReview,
  });

  int? active;
  int? notComplete;
  int? deactivate;
  int? underReview;

  UserStatus copyWith({
    int? active,
    int? notComplete,
    int? deactivate,
    int? underReview,
  }) =>
      UserStatus(
        active: active ?? this.active,
        notComplete: notComplete ?? this.notComplete,
        deactivate: deactivate ?? this.deactivate,
        underReview: underReview ?? this.underReview,
      );

  factory UserStatus.fromJson(String str) => UserStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserStatus.fromMap(Map<String, dynamic> json) => UserStatus(
    active: json["Active"],
    notComplete: json["Not_Complete"],
    deactivate: json["Deactivate"],
    underReview: json["Under_Review"],
  );

  Map<String, dynamic> toMap() => {
    "Active": active,
    "Not_Complete": notComplete,
    "Deactivate": deactivate,
    "Under_Review": underReview,
  };
}
class UserTypes {
  UserTypes({
    this.customer,
    this.provider,
  });

  int? customer;
  int? provider;

  UserTypes copyWith({
    int? customer,
    int? provider,
  }) =>
      UserTypes(
        customer: customer ?? this.customer,
        provider: provider ?? this.provider,
      );

  factory UserTypes.fromJson(String str) => UserTypes.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserTypes.fromMap(Map<String, dynamic> json) => UserTypes(
    customer: json["Customer"],
    provider: json["Provider"],
  );

  Map<String, dynamic> toMap() => {
    "Customer": customer,
    "Provider": provider,
  };
}

class VerificationType {
  VerificationType({
    this.email,
    this.mobile,
  });

  int? email;
  int? mobile;

  VerificationType copyWith({
    int? email,
    int? mobile,
  }) =>
      VerificationType(
        email: email ?? this.email,
        mobile: mobile ?? this.mobile,
      );

  factory VerificationType.fromJson(String str) => VerificationType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VerificationType.fromMap(Map<String, dynamic> json) => VerificationType(
    email: json["Email"],
    mobile: json["Mobile"],
  );

  Map<String, dynamic> toMap() => {
    "Email": email,
    "Mobile": mobile,
  };
}

class SplashScreen {
  SplashScreen({
    this.id,
    this.title,
    this.description,
    this.image,
  });

  int? id;
  String? title;
  String? description;
  String? image;

  SplashScreen copyWith({
    int? id,
    String? title,
    String? description,
    String? image,
  }) =>
      SplashScreen(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
      );

  factory SplashScreen.fromJson(String str) => SplashScreen.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SplashScreen.fromMap(Map<String, dynamic> json) => SplashScreen(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "image": image == null ? null : image,
  };
}




