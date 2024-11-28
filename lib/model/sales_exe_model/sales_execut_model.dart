

// Model class for SalesPerson
class SalesPerson {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String? profilePic;
  final String? companyName;
  final String? dob;
  final String? frequentFlyerNo;
  final String? additionalDetails;
  final String? emailVerifiedAt;
  final String? referral;
  final String? source;
  final String? specify;
  final int status;
  final String? otp;
  final DateTime? otpCreatedAt;
  final int target;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int activeStatus;
  final String avatar;
  final int darkMode;
  final String? messengerColor;

  SalesPerson({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePic,
    this.companyName,
    this.dob,
    this.frequentFlyerNo,
    this.additionalDetails,
    this.emailVerifiedAt,
    this.referral,
    this.source,
    this.specify,
    required this.status,
    this.otp,
    this.otpCreatedAt,
    required this.target,
    required this.createdAt,
    required this.updatedAt,
    required this.activeStatus,
    required this.avatar,
    required this.darkMode,
    this.messengerColor,
  });

  factory SalesPerson.fromJson(Map<String, dynamic> json) {
    return SalesPerson(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePic: json['profile_pic'],
      companyName: json['company_name'],
      dob: json['dob'],
      frequentFlyerNo: json['frequent_flyer_no'],
      additionalDetails: json['additional_details'],
      emailVerifiedAt: json['email_verified_at'],
      referral: json['referral'],
      source: json['source'],
      specify: json['specify'],
      status: json['status'],
      otp: json['otp'],
      otpCreatedAt: json['otp_created_at'] != null ? DateTime.parse(json['otp_created_at']) : null,
      target: json['target'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      activeStatus: json['active_status'],
      avatar: json['avatar'],
      darkMode: json['dark_mode'],
      messengerColor: json['messenger_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_pic': profilePic,
      'company_name': companyName,
      'dob': dob,
      'frequent_flyer_no': frequentFlyerNo,
      'additional_details': additionalDetails,
      'email_verified_at': emailVerifiedAt,
      'referral': referral,
      'source': source,
      'specify': specify,
      'status': status,
      'otp': otp,
      'otp_created_at': otpCreatedAt?.toIso8601String(),
      'target': target,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'active_status': activeStatus,
      'avatar': avatar,
      'dark_mode': darkMode,
      'messenger_color': messengerColor,
    };
  }
}

// Model class for the response
class SalesPersonResponse {
  final bool status;
  final String message;
  final SalesPerson data;

  SalesPersonResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SalesPersonResponse.fromJson(Map<String, dynamic> json) {
    return SalesPersonResponse(
      status: json['status'],
      message: json['message'],
      data: SalesPerson.fromJson(json['data']['sales_person']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'sales_person': data.toJson(),
      },
    };
  }
}
