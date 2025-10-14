import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:provider/core/connection_service/DioExceptions.dart';
import 'package:provider/models/address/map/map_street_model.dart';
import 'package:provider/models/auth/avatars_response.dart';
import 'package:provider/models/auth/card_response.dart';
import 'package:provider/models/auth/register_response.dart';
import 'package:provider/models/auth/user_response.dart';
import 'package:provider/models/auth/visitor_response.dart';
import 'package:provider/models/install/root_response.dart';
import 'package:provider/models/universitie/universities_response.dart';
import 'package:provider/utils/common.dart';
import 'package:provider/utils/config.dart';
import 'package:provider/utils/helper.dart';

import '../../../models/authentication/choose_services_response.dart';
import '../../../models/authentication/cities_response.dart';
import '../../../models/authentication/login_response.dart';
import '../../../models/authentication/provider.dart';
import '../../../models/authentication/show_services_response.dart';
import '../../../models/authentication/update_provider_response.dart';

int user_type = 1;

class AuthApi {
  final Dio dio;

  AuthApi({required this.dio});

  Future<Either<dynamic, LonginResponse>> LoginRegister({
    required String emailPhone,
    required String? country_id,
    required String token,
  }) async {
    try {
      var url = confing.UrlLogin;
      dio.options.headers = Common.headers();

      var data = {
        "mobile": emailPhone,
        "country_id": country_id,
      };
      print("data Login # " + data.toString());

      var formData = FormData.fromMap(data);

      if (Common.getDeviceToken() != null) {
        formData.fields.addAll([
          MapEntry(
            "device_token",
            Common.getDeviceToken().toString(),
          ),
        ]);
        formData.fields.addAll([
          MapEntry(
            "device_type",
            Platform.isIOS ? "1" : "0",
          ),
        ]);
      }

      final response = await dio.post(
        url,
        data: formData,
      );
      var responseData = response.data as Map<String, dynamic>;
      print("responseData ${responseData}");
      return Right(LonginResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<DioError, ProviderResponse>> UpdateProvider(
      {required File? file,
      fileName,
        required File? fileID,
        fileNameID,

      hourly_rate,
      latitude,
      longitude,
      type,
      locale_id,
      city_id,
      app_mode,
      tax_id,
      String? nameLocation}) async {
    try {
      var url = confing.UrlUpdate;
      dio.options.headers = Common.headersMultipartFile();
      var data = {};
      FormData formData = FormData.fromMap({
        '_method': 'PUT',
        'hourly_rate': hourly_rate,
        'latitude': latitude,
        'longitude': longitude,
        'type': type,
        'locale_id': locale_id,
        'city_id': city_id,
        'app_mode': app_mode,
      });
      if (nameLocation != null && nameLocation.toString().isNotEmpty) {
        formData.fields.addAll([
          MapEntry(
            "address",
            nameLocation.toString(),
          ),
        ]);
      }
      if (file != null &&
          file.path != null &&
          file.path.toString().isNotEmpty) {
        print("ressssp "+ file.path.toString());
        formData.files.addAll([
          MapEntry("avatar",
              await MultipartFile.fromFile(file.path, filename: fileName)),
        ]);
      }


      if (fileID != null &&
          fileID.path != null &&
          fileID.path.toString().isNotEmpty) {
        print("ressssp "+ fileID.path.toString());
        formData.files.addAll([
          MapEntry("identity",
              await MultipartFile.fromFile(fileID.path, filename: fileNameID)),
        ]);
      }

      if (tax_id.isNotEmpty && tax_id != null) {
        formData.fields.addAll([
          MapEntry(
            "tax_id",
            tax_id.toString(),
          ),
        ]);
      }

      if (Common.getDeviceToken() != null) {
        formData.fields.addAll([
          MapEntry(
            "device_token",
            Common.getDeviceToken().toString(),
          ),
        ]);
        formData.fields.addAll([
          MapEntry(
            "device_type",
            Platform.isIOS ? "1" : "0",
          ),
        ]);
      }
      print("ressssp "+formData.fields.toString());

      final response = await dio.post(
        url,
        data: formData,
      );

      print("ressssp "+response.data.toString());
      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
      // var errorMessage = DioExceptions.fromDioError(e);
      print("ressssp "+e.toString());

      return Left(e);
    }
  }

  Future<Either<DioError, ProviderResponse>> updateDeviceToken() async {
    try {
      var url = confing.UrlUpdate;
      dio.options.headers = Common.headersMultipartFile();
      var data = {};
      FormData formData = FormData.fromMap({
        '_method': 'PUT',
      });

      if (Common.getDeviceToken() != null) {
        print("device_token " + Common.getDeviceToken().toString());
        formData.fields.addAll([
          MapEntry(
            "device_token",
            Common.getDeviceToken().toString(),
          ),
        ]);
        formData.fields.addAll([
          MapEntry(
            "device_type",
            Platform.isIOS ? "1" : "0",
          ),
        ]);
      }

      final response = await dio.post(
        url,
        data: formData,
      );

      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
      // var errorMessage = DioExceptions.fromDioError(e);

      return Left(e);
    }
  }

  Future<Either<DioError, ProviderResponse>> updateProviderLocation({
    required double latitude,
    required double longitude,
    String? nameLocation,
  }) async {
    try {
      var url = confing.UrlUpdate;
      dio.options.headers = Common.headersMultipartFile();

      FormData formData = FormData.fromMap({
        '_method': 'PUT',
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
      });

      if (nameLocation != null && nameLocation.toString().isNotEmpty) {
        formData.fields.addAll([
          MapEntry(
            "address",
            nameLocation.toString(),
          ),
        ]);
      }

      print("url ##" + url.toString());
      print("url ##" + formData.fields.toString());

      final response = await dio.post(
        url,
        data: formData,
      );

      print("url ##" + response.data.toString());

      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
      return Left(e);
    }
  }

  Future<Either<dynamic, ProviderResponse>> UpdateUserData(
      {name,
      mobile,
      country_id,
      File? file,
      fileName,
      cityId,
        tax_id,
        avatar,
        required File? fileID,
        fileNameID,
      required Provider? user}) async {
    try {
      var url = confing.UrlUpdateUser;
      dio.options.headers = Common.headers();
      print(dio.options.headers);
      var data = {
        "_method": "PUT",
      };
      var formData = FormData.fromMap(data);

      if (user!.name!.isNotEmpty) {
        formData.fields.addAll([
          MapEntry(
            "name",
            user.name.toString(),
          ),
        ]);
      }

      if ( cityId !=null) {
        print("city id + "+cityId.toString());
        formData.fields.addAll([
          MapEntry(
            "city_id",
            cityId.toString(),
          ),
        ]);
      }
      if (tax_id.isNotEmpty && tax_id != null) {
        formData.fields.addAll([
          MapEntry(
            "tax_id",
            tax_id.toString(),
          ),
        ]);
      }
      if (user.hourlyRate!.isNotEmpty) {
        formData.fields.addAll([
          MapEntry(
            "hourly_rate",
            user.hourlyRate.toString(),
          ),
        ]);
      }


      if (fileID != null &&
          fileID.path != null &&
          fileID.path.toString().isNotEmpty) {
        print("ressssp "+ fileID.path.toString());
        formData.files.addAll([
          MapEntry("identity",
              await MultipartFile.fromFile(fileID.path, filename: fileNameID)),
        ]);
      }



      if (Common.getDeviceToken() != null) {
        formData.fields.addAll([
          MapEntry(
            "device_token",
            Common.getDeviceToken().toString(),
          ),
        ]);
        formData.fields.addAll([
          MapEntry(
            "device_type",
            Platform.isIOS ? "1" : "0",
          ),
        ]);
      }
      if (user.localeId != null) {
        print("localeId # " + user.localeId.toString());
        formData.fields.addAll([
          MapEntry(
            "locale_id",
            user.localeId.toString(),
          ),
        ]);
      }
      if (!user.avatar.toString().contains(confing.baseUrl)) {
        formData.files.addAll([
          MapEntry("avatar",
              await MultipartFile.fromFile(file!.path, filename: fileName)),
        ]);
      }

      print( "UPLODEIMAGE  1 "+formData.fields.toString()  );

      final response = await dio.post(
        url,
        data: formData,
      );
      print( "UPLODEIMAGE 2 "+response.data.toString()  );
      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
       print( "UPLODEIMAGE 3 "+e.toString()  );
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, ProviderResponse>> updateUserLanguage(
      {required int locale_id}) async {
    try {
      var url = confing.UrlUpdateUser;
      dio.options.headers = Common.headers();
      print(dio.options.headers);
      var data = {
        "_method": "PUT",
        "locale_id": locale_id,
      };
      var formData = FormData.fromMap(data);

      final response = await dio.post(
        url,
        data: formData,
      );
      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, CitiesResponse>> CitiesProvider() async {
    try {
      int? country_id = -1 ;
      if(Common.getUser()?.data!.provider!.country != null){
        country_id = Common.getUser()?.data!.provider!.country!.id! ;
      }else{
        if(Common.getSplash() != null && Common.getSplash()!.data != null &&
            Common.getSplash()!.data.countries != null)
        country_id = Common.getSplash()!.data.countries.first.id ;
      }

      var url = confing.UrlCities +
          "${country_id}" +
          "/cities";
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );
      return Right(CitiesResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage );
    }
  }

  Future<Either<dynamic, LonginResponse>> SignUp(
      {String? full_name,
      String? mobile,
      String? country_id,
      String? token}) async {
    try {
      var url = confing.UrlRegister;

      dio.options.headers = Common.headers();
      var data = {
        "name": full_name,
        "mobile": mobile,
        "country_id": country_id,
        'type': '0'
      };

      var formData = FormData.fromMap(data);

      if (Common.getDeviceToken() != null) {
        formData.fields.addAll([
          MapEntry(
            "device_token",
            Common.getDeviceToken().toString(),
          ),
        ]);
        formData.fields.addAll([
          MapEntry(
            "device_type",
            Platform.isIOS ? "1" : "0",
          ),
        ]);
      }

      final response = await dio.post(
        url,
        data: formData,
      );

      return Right(LonginResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, ProviderResponse>> Verify({
    required String mobile,
    required String? country_id,
    required String code,
  }) async {
    try {
      var url = confing.UrlVerify;
      dio.options.headers = Common.headers();

      var data = {
        "mobile": mobile,
        "country_id": country_id.toString(),
        "code": code.toString(),
      };

      var formData = FormData.fromMap(data);

      if (Common.getDeviceToken() != null) {
        formData.fields.addAll([
          MapEntry(
            "device_token",
            Common.getDeviceToken().toString(),
          ),
        ]);
        formData.fields.addAll([
          MapEntry(
            "device_type",
            Platform.isIOS ? "1" : "0",
          ),
        ]);
      }

      final response = await dio.post(
        url,
        data: formData,
      );

      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, ProviderResponse>> myUser() async {
    try {
      var url = confing.UrlMe;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(ProviderResponse.fromMap(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  // Future<Either<dynamic, RootResponse>> UpdateUser({required User user}) async {
  //   try {
  //     var url = confing.UrlUpdateUser;
  //     dio.options.headers = Common.headers();
  //
  //     print(dio.options.headers);
  //     var data = {
  //       "x": 1,
  //     };
  //
  //     var formData = FormData.fromMap(data);
  //
  //
  //     if(user.regionCode != null && user.regionCode.toString().isNotEmpty  ){
  //
  //       formData.fields.addAll([
  //         MapEntry(
  //           "region_code",
  //           user.regionCode.toString(),
  //         ),
  //       ]);
  //     }
  //
  //     if (user.gpaScaleType != null  ) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "gpa_scale_type",
  //           user.gpaScaleType.toString(),
  //         ),
  //       ]);
  //     }
  //
  //
  //     if (user.name != null && user.name!.isNotEmpty) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "name",
  //           user.name.toString(),
  //         ),
  //       ]);
  //     }
  //     if (user.email != null && user.email!.isNotEmpty) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "email",
  //           user.email.toString(),
  //         ),
  //       ]);
  //     }
  //
  //     if (user.mobile != null && user.mobile!.isNotEmpty) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "mobile",
  //           user.mobile.toString(),
  //         ),
  //       ]);
  //     }
  //
  //     if (user.image != null && user.image!.isNotEmpty) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "avatar_id",
  //           user.image.toString(),
  //         ),
  //       ]);
  //     }
  //
  //
  //
  //
  //     if (user.university != null && user.university!.id.toString() != null) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "university_id",
  //           user.university!.id.toString(),
  //         ),
  //       ]);
  //     }
  //
  //     if (user.university != null && user.university!.id.toString() != null) {
  //       formData.fields.addAll([
  //         MapEntry(
  //           "university_id",
  //           user.university!.id.toString(),
  //         ),
  //       ]);
  //     }
  //
  //
  //     print("update user "+ formData.fields.toString());
  //     final response = await dio.post(
  //       url,
  //       data: formData,
  //     );
  //
  //     return Right(RootResponse.fromJson(jsonEncode(response.data)));
  //   } on DioError catch (e) {
  //     var errorMessage = DioExceptions.fromDioError(e);
  //     return Left(errorMessage);
  //   }
  // }

  Future<Either<dynamic, MapStreetModel>> GetNameStreet(
      double lat, double lng) async {
    try {
      var url =
          "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lng&format=json&accept-language=" +
              Common.getLang();

      print(url + " GetAdsById");

      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );
      return Right(MapStreetModel.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, AvatarsResponse>> getAvatars() async {
    try {
      var url = confing.UrlAvatars;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(AvatarsResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, ShowServicesResponse>> getServices() async {
    try {
      var url = confing.UrlServices;
      dio.options.headers = Common.headers();
      final response = await dio.get(
        url,
      );

      return Right(ShowServicesResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, ChooseServicesResponse>> ChooseServices({list}) async {
    try {
      var url = confing.UrlServicesUpdate;
      dio.options.headers = Common.headers();
      var data = {"services": list};
      final response = await dio.post(url, data: data);

      return Right(ChooseServicesResponse.fromJson(response.data));
    } on DioError catch (e) {
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }

  Future<Either<dynamic, RootResponse>> logout() async {
    try {
      var url = confing.UrlLogout;
      dio.options.headers = Common.headers();
      final response = await dio.post(
        url,
      );
      return Right(RootResponse.fromJson(jsonEncode(response.data)));
    } on DioError catch (e) {
      //  print('${e.message} ::: $e');
      var errorMessage = DioExceptions.fromDioError(e);
      return Left(errorMessage);
    }
  }
}
