import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../Constants/custom_string.dart';
import '../../globals.dart';
import '../../locator.dart';
import '../api/api_response.dart';
import '../api/error_response.dart';
import '../api/generic_response.dart';
import 'app_logger.dart';
import 'connection_status.dart';
import 'local_cache.dart';

abstract class ApiService {
  late final Dio dio;

  ApiService({String? baseUrl}) {
    final options = BaseOptions(
      baseUrl: baseUrl ?? Global.environmentVariables.apiBaseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(
        seconds: Global.environmentVariables.apiTimeoutInSeconds * 1000,
      ),
      receiveTimeout: Duration(
        seconds: Global.environmentVariables.apiTimeoutInSeconds * 1000,
      ),
    );
    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          //no internet? reject request
          if (!await ConnectionStatus.isConnected()) {
            handler.reject(
              DioError(
                requestOptions: options,
                error:
                    "Oops! Looks like you're not connected to the internet. Check your internet connection and try again.",
              ),
            );
          }

          handler.next(options);
        },
        onResponse: (response, handler) async {
          if (response.statusCode == 403) {
            //dio.interceptors.requestLock.lock();
            //QueuedInterceptor;

            AppLogger.log("LAUCH REFRESH TOKEN");

            //REFRESH TOKEN
            // await _regenerateAccessToken(baseApi);

            //dio.interceptors.requestLock.unlock();

            var token = locator<LocalCache>()
                .getFromLocalCache(ConstantString.refreshTokenPref);

            options.headers["Authorization"] = "Bearer $token";

            handler.resolve(
              Response(
                  requestOptions: response.requestOptions,
                  statusCode: 403,
                  data: {
                    'message':
                        "Forbidden: You do not have access to this resource.",
                  }),
            );
          } else if (response.statusCode == 401) {
            //InactivityRedirect().redirectToLogin(logOutReason: "Error 401",);
          } else {
            handler.next(response);
          }
        },
        onError: (error, handler) async {
          AppLogger.log(error.response);
          if (error.response?.statusCode == 403) {
            //dio.interceptors.requestLock.lock();

            AppLogger.log("LAUNCH REFRESH TOKEN");

            //REFRESH TOKEN
            // await _regenerateAccessToken(baseApi);

            //dio.interceptors.requestLock.unlock();

            var token = await locator<LocalCache>().getToken();

            options.headers["Authorization"] = "Bearer $token";

            handler.resolve(
              Response(
                  requestOptions: error.requestOptions,
                  statusCode: 403,
                  data: {
                    "message":
                        "Forbidden: You do not have access to this resource",
                  }),
            );
          } else if (error.response?.statusCode == 401) {
            //InactivityRedirect().redirectToLogin(logOutReason: "Error 401");
          } else {
            handler.next(error);
          }
        },
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }
  Future<Map<String, dynamic>> getAuthorizedHeader(
      {bool useRefreshToken = false}) async {
    final accessToken = await locator<LocalCache>().getToken();
    final refreshToken = locator<LocalCache>()
        .getFromLocalCache(ConstantString.refreshTokenPref);

    var accessData = {
      "Authorization": "Bearer $accessToken",
    };

    var refreshData = {
      "Authorization": "Bearer $refreshToken",
    };

    if (useRefreshToken) {
      return refreshData;
    } else {
      return accessData;
    }
  }

  Future<Either<Failure, Success>> get(
    path, {
    bool useToken = true,
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader = await getAuthorizedHeader();
    }
    print("/$path");
    print("/$dio");
    return makeRequest(
      dio.request(
        "/$path",
        data: data,
        options: Options(
          method: "GET",
          headers: {
            ...headers,
            ...authorizedHeader,
          },
        ),
      ),
    );
  }

  Future<GenericResponse<T>> getGeneric<T>(
    path, {
    bool useToken = true,
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
    Function? converter,
  }) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader = await getAuthorizedHeader();
    }
    return makeGenericRequest<T>(
        dio.request("/$path",
            data: data,
            options: Options(
              method: "GET",
              headers: {
                ...headers,
                ...authorizedHeader,
              },
            )),
        converter: converter);
  }

  Future<Either<Failure, Success>> post(
    path, {
    bool useToken = true,
    bool useRefreshToken = false,
    dynamic data,
    Map<String, dynamic> headers = const {},
  }) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader =
          await getAuthorizedHeader(useRefreshToken: useRefreshToken);
    }
    return makeRequest(dio
        .post(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers,
              ...authorizedHeader,
            },
          ),
        )
        .whenComplete(() => null));
  }

  Future<GenericResponse<T>> postGeneric<T>(
    path, {
    bool useToken = true,
    dynamic data,
    Map<String, dynamic> headers = const {},
    Function? converter,
  }) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader = await getAuthorizedHeader();
    }
    return makeGenericRequest<T>(
        dio.post(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers,
              ...authorizedHeader,
            },
          ),
        ),
        converter: converter);
  }

  Future<Either<Failure, Success>> put(
    path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
    bool useToken = true,
    bool useRefreshToken = false,
  }) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader =
          await getAuthorizedHeader(useRefreshToken: useRefreshToken);
    }
    return makeRequest(
      dio.put(
        "/$path",
        data: data,
        options: Options(
          headers: {
            ...headers,
            ...authorizedHeader,
          },
        ),
      ),
    );
  }

  Future<Either<Failure, Success>> patch(
    path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
    bool useToken = true,
    bool useRefreshToken = false,
  }) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader =
          await getAuthorizedHeader(useRefreshToken: useRefreshToken);
    }
    return makeRequest(
      dio.patch(
        "/$path",
        data: data,
        options: Options(
          headers: {
            ...headers,
            ...authorizedHeader,
          },
        ),
      ),
    );
  }

  Future<GenericResponse<T>> patchGeneric<T>(path,
      {Map<String, dynamic>? data,
      Map<String, dynamic> headers = const {},
      bool useToken = true,
      Function? converter}) async {
    var authorizedHeader = {};
    if (useToken) {
      authorizedHeader = await getAuthorizedHeader();
    }
    return makeGenericRequest<T>(
        dio.patch(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers,
              ...authorizedHeader,
            },
          ),
        ),
        converter: converter);
  }

  Future<Either<Failure, Success>> delete(
    path, {
    Map<String, dynamic>? data,
    Map<String, dynamic> headers = const {},
  }) async {
    var authorizedHeader = await getAuthorizedHeader();

    return makeRequest(
      dio.delete(
        "/$path",
        data: data,
        options: Options(
          headers: {
            ...headers,
            ...authorizedHeader,
          },
        ),
      ),
    );
  }

  Future<GenericResponse<T>> deleteGeneric<T>(path,
      {Map<String, dynamic>? data,
      Map<String, dynamic> headers = const {},
      Function? converter}) async {
    var authorizedHeader = await getAuthorizedHeader();

    return makeGenericRequest<T>(
        dio.delete(
          "/$path",
          data: data,
          options: Options(
            headers: {
              ...headers,
              ...authorizedHeader,
            },
          ),
        ),
        converter: converter);
  }

  Future<Either<Failure, Success>> makeRequest(Future<Response> future) async {
    try {
      var req = await future;
      var data = req.data;

      AppLogger.log(data);
      if (req.statusCode.toString().startsWith('2')) {
        //CHECK THAT STATUS IS NOT FALSE
        print(data);
        if (data["success"] == true) {
          return Right(Success(data));
        } else {
          return Left(
            Failure(
              ApiErrorResponse(
                message: data["message"],
                errors: data["errors"],
                data: data,
              ),
            ),
          );
        }
      }

      return Left(Failure.fromMap(data));
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.unknown) {
        return Left(
          Failure(
            ApiErrorResponse(
              message:
                  "Oops. Check your internet connection and try again.${e.message}, ${e.error}",
            ),
          ),
        );
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          return Left(
            Failure(
              const ApiErrorResponse(
                message: "Resource not found",
              ),
            ),
          );
        }

        if (e.response?.data != null && e.response!.data is Map) {
          return Left(Failure.fromMap(e.response!.data));
        }

        return Left(
          Failure(
            ApiErrorResponse(errors: [e.message!]),
          ),
        );
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return Left(Failure(
          ApiErrorResponse(errors: [e.message!]),
        ));
      }
    }
  }

  Future<GenericResponse<T>> makeGenericRequest<T>(Future<Response> future,
      {Function? converter}) async {
    try {
      var req = await future;
      var data = req.data;

      AppLogger.log(data);

      if (req.statusCode.toString().startsWith('2')) {
        T? data0;
        if (data["data"] != null && converter != null) {
          data0 = converter(data["data"]);
        }

        return GenericResponse<T>(
            success: data["success"], message: data["message"], data: data0);
      }

      return GenericResponse(
          success: data["success"], message: data["message"]);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout ||
          e.type == DioErrorType.unknown) {
        return GenericResponse(
          message: "Oh dear! Check your internet connection and try again.",
        );
      }

      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (e.response?.statusCode == 404) {
          return GenericResponse(message: "Resource not found.");
        }

        if (e.response?.data != null && e.response!.data is Map) {
          // var m = GenericResponse.getErrorMessage(e.response!.data);
          // return GenericResponse(
          //     message: "Oops. Check your internet connection and try again.");
          // return Left(Failure.fromMap(e.response!.data));
        }

        return GenericResponse(
            message: e.response!.data['message'], errors: [e.message!]);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        return GenericResponse(errors: [e.message!]);
      }
    }
  }
}
