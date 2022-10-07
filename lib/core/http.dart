import 'dart:convert';
import 'dart:io';

import 'package:cnvsoft/core/app.dart';
import 'package:cnvsoft/core/dio_logger.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/core/storage.dart';
import 'package:cnvsoft/global.dart';
import 'package:cnvsoft/base_citenco/dialog/lock_app_dialog.dart';
import 'package:cnvsoft/base_citenco/dialog/message_dialog.dart';
import 'package:cnvsoft/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart';
import 'package:cnvsoft/base_citenco/package/scope.dart';
import 'package:cnvsoft/base_citenco/package/trans.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info/package_info.dart';

import 'base_core/base_model.dart';
import 'base_core/data_mix.dart';
import 'device.dart';
import 'log.dart';
import 'moor.dart';
import 'package.dart';

class ENV with DataMix {
  final String? env;
  final String? accountDomainName;

  ENV({
    this.env,
    this.accountDomainName,
  });
}

class Http with DataMix {
  final String? $logTag; //package name + version
  final State? state;
  final Map<Type, Function(dynamic reponse)>? factories;

  // final httpClient = ExtendedClient(
  //   // extensions: [
  //   //   LogExtension(LogOptions(
  //   //     isEnabled: true,
  //   //   )),
  //   // ],
  //   inner: http.Client as http.BaseClient,
  // );

  // final HttpWithMiddleware httpClient = HttpWithMiddleware.build(middlewares: [
  //   HttpLogger(logLevel: LogLevel.BODY),
  // ]);

  Http({this.$logTag, required this.state, required this.factories});

  String get logTag => stringOf(() => $logTag!);

  String? get accountDomainName => BaseScope().env?.accountDomainName;

  bool get isStaging => BaseScope().env?.env == "staging";

  bool get isProduction => BaseScope().env?.env == "production";

  Map<String, String> get baseHeader => _baseHeader();

  String get guestPref => "guest/$accountDomainName/";

  Map<String, String> _baseHeader({bool isNET = false}) {
    String? deviceId = Device().deviceId;
    String navigateName =
        stringOf(() => ModalRoute.of(state!.context)?.settings.name!);

    Map<String, String?> _headerNET = {
      "X-CLIENT-USER-ID":
          dataOf(() => MyProfile().customerId.toString(), null, ['null']),
      'X-Screen-Id': navigateName,
      "X-DOMAIN-NAME": stringOf(() => accountDomainName),
      "X-CNV-CLIENT-APPS": BaseScope().clientAppHeader.toString(),
      'X-Device-Id': deviceId,
      "Authorization": "Token " + (StorageCNV().getString("TOKEN") ?? "")
      // "Token 5f2a6f2cac27eb174cfd07c7" // temp token dot NET, waiting for dot NET improve api in order to remove
    };

    _headerNET.removeWhere((k, v) => (stringOf(() => v).isEmpty ||
        stringOf(() => v).toLowerCase() == 'null'));

    // return _headerNET;
    Map<String, String> _headerClean = {};
    _headerNET.forEach((key, value) {
      if (value != null) {
        _headerClean[key] = value;
      }
    });

    return _headerClean;
  }

  Duration get _timeoutDuration => Duration(seconds: 60);

  Map<String, String> _getHeaders(Map<String, String?>? header,
      {bool isNET = false}) {
    Map<String, String> _headers = {};
    _baseHeader(isNET: isNET).forEach((k, v) {
      _headers[k] = v;
    });
    (header ?? {}).forEach((k, v) {
      if (v != null) {
        _headers[k] = v;
      }
    });
    return _headers;
  }

  Map<String, dynamic> _getBodies(Map? body) {
    Map<String, dynamic> _bodies = {};
    (body ?? {}).forEach((k, v) {
      if (v != null) {
        _bodies[k] = v;
      }
    });
    return _bodies;
  }

  // String _getParams(Map<String, dynamic> params) {
  //   String _params = "";
  //   params.removeWhere((k, v) => v == null);
  //   List<String> _items = List.generate(
  //       params.length,
  //       (index) =>
  //           "${params.keys.toList()[index]}=${params.values.toList()[index]}");
  //   if (_items.isNotEmpty) {
  //     _params = _items.join("&");
  //   }
  //   return _params;
  // }

  dynamic parse<T>(dynamic response) {
    if (factories!.containsKey(T)) {
      return factories![T]!(response);
    }
    return response;
  }

  // dynamic decode(String body) {
  //   try {
  //     return json.decode(body);
  //   } catch (e) {
  //     print(e);
  //   }
  //   return Map();
  // }

  // Future<Uint8List?> getImage(String url,
  //     {required String baseAPI, Map<String, String>? headers}) async {
  //   Map<String, String>? _headers = headers ?? Map<String, String>();
  //   _baseHeader().forEach((k, v) => headers![k] = v);
  //   var response = await httpClient
  //       .get(Uri.parse(baseAPI + url), headers: headers)
  //       .timeout(_timeoutDuration);
  //   if (response.statusCode < 200 && response.statusCode >= 300) {
  //     print("Has an error when get image");
  //     return null;
  //   }
  //   Uint8List image = response.bodyBytes.buffer.asUint8List();
  //   return image;
  // }

  Response? _catchError(dynamic error, String? path) {
    Response? response;
    if (error is DioError) {
      if (boolOf(() => error.error is SocketException)) return error.response!;
      response = error.response;
    } else if (error is TypeError) {
      response = Response(
          statusMessage: error.toString(),
          requestOptions: RequestOptions(path: stringOf(() => path!)));
    } else {
      response = Response(
          statusMessage: Error.safeToString(error),
          requestOptions: RequestOptions(path: stringOf(() => path!)));
    }
    _saveErrorLocal(error);

    // if (ProfileMix().enableLogging && state != null && state is BaseView) {
    //   var statusCode = stringOf(() => "[${response.statusCode}]");
    //   var statusMessage =
    //       stringOf(() => response.statusMessage.substring(0, 20));
    //   var parts = [statusCode, path, statusMessage].where((e) => e.isNotEmpty);
    //   if (parts.isNotEmpty)
    //     (state as BaseView)
    //         .provider
    //         .showSnackError(parts.join(" - "), arguments: {"error": error});
    // }
    return response;
  }

  Map<String, dynamic> _getErrorJson(dynamic error) {
    if (error is DioError) {
      return {
        "base Url": stringOf(() => error.requestOptions.baseUrl),
        "path": stringOf(() => error.requestOptions.uri.path),
        "message": stringOf(() => error.message),
        "method": stringOf(() => error.requestOptions.method),
        "query": dataOf(() => error.requestOptions.queryParameters),
        "data": stringOf(() => error.requestOptions.data.toString()),
        "status Message": stringOf(() => error.response!.statusMessage!)
      };
    } else if (error is TypeError) {
      return {
        "error": stringOf(() => error.toString()),
        "stack Trace": stringOf(() => error.stackTrace.toString())
      };
    } else if (error is SocketException) {
      return {
        "error": stringOf(() => error.toString()),
        "message": stringOf(() => error.message),
        "address": stringOf(() => error.address!.address),
        "port": intOf(() => error.port!),
      };
    } else if (error is NoSuchMethodError) {
      return {
        "error": stringOf(() => error.toString()),
        "stack Trace": stringOf(() => error.stackTrace.toString())
      };
    } else {
      return {"message": stringOf(() => error.toString())};
    }
  }

  Future<void> _saveErrorLocal(dynamic error) async {
    Map<String, dynamic> _err = _getErrorJson(error);
    var _errors = StorageCNV().getString("ERRORS");
    if (_errors != null) {
      var _items = _errors.split(" - ");
      if (_items.length < 50) {
        _items.add(jsonEncode(_err));
      } else {
        _items.removeAt(0);
        _items.add(jsonEncode(_err));
      }
      var _value = _items.join(" - ");
      StorageCNV().setString("ERRORS", _value);
    } else {
      StorageCNV().setString("ERRORS", jsonEncode(_err));
    }
  }

  Future<T> _clockRequest<T>(
      {required BaseOptions options,
      Map<String, dynamic>? bodies,
      required String path,
      required Future<Response> Function(String path, Dio dio)? action,
      Duration? timeout}) async {
    DateTime from = DateTime.now();

    var dio = Dio(options);
    dio.interceptors.addAll([
      PrettyDioLogger(
          responseBody: kDebugMode,
          requestBody: kDebugMode,
          requestHeader: kDebugMode,
          request: kDebugMode,
          error: kDebugMode),
    ]);


    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    var response = await action!(path, dio)
        .timeout(timeout ?? _timeoutDuration,
            onTimeout: () => Response(
                statusCode: HttpStatus.requestTimeout,
                statusMessage: "timeout",
                requestOptions: RequestOptions(path: path)))
        .catchError((error) {
      _catchError(error, path);
      if (error is DioError) {
        return Response(
            data: error.response?.data,
            statusCode: error.response?.statusCode,
            statusMessage: error.response?.statusMessage,
            requestOptions: RequestOptions(path: path));
      } else {
        return Response(
            data: error,
            statusCode: HttpStatus.notFound,
            statusMessage: "Not Found",
            requestOptions: RequestOptions(path: path));
      }
    });

    return _completed<T>(
        path, options.queryParameters, bodies ?? {}, response, from, dio.options.baseUrl);
  }

  Interceptor get _getInterceptor => LogInterceptor(
      responseBody: kDebugMode,
      requestBody: kDebugMode,
      requestHeader: kDebugMode,
      request: kDebugMode,
      responseHeader: kDebugMode,
      error: kDebugMode);

  // Interceptor get _getInterceptor => LogInterceptor(
  //     responseBody: true,
  //     requestBody: true,
  //     requestHeader: true,
  //     request: true,
  //     responseHeader: true,
  //     error: true);

  Future<T> get<T>(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? params,
      Duration? timeout,
      required String baseAPI,
      String? clientId,
      String? secretKey,
      String? token,
      bool isNET = false}) async {
    Map<String, String> _headers = _getHeaders(headers, isNET: isNET);
    Map<String, dynamic> _params = clearParam(params);

    if (clientId != null) _headers['X-Client-Id'] = clientId;
    if (secretKey != null) _headers['X-Client-Secret'] = secretKey;
    if (token != null) _headers["Authorization"] = token;

    return _clockRequest(
        path: url,
        timeout: timeout,
        bodies: {},
        options: BaseOptions(
            contentType: "application/json",
            baseUrl: baseAPI,
            queryParameters: _params,
            followRedirects: true,
            headers: _headers),
        action: (path, dio) async {
          return await dio.get(path);
        });
  }

  Future<T> post<T>(String url,
      {Map? body,
      Map<String, String>? headers,
      required String baseAPI,
      String? token,
      Duration? timeout,
      bool isNET = false,
      Function(int, int)? onSendProgress,
      Function(int, int)? onReceiveProgress,
      CancelToken? cancelToken}) async {
    Map<String, String> _headers = _getHeaders(headers, isNET: isNET);
    Map<String, dynamic> _bodies = _getBodies(body);
    if (token != null) _headers["Authorization"] = token;

    return _clockRequest(
        path: url,
        bodies: _bodies,
        timeout: timeout,
        options: BaseOptions(
            contentType: "application/json",
            baseUrl: baseAPI,
            followRedirects: true,
            headers: _headers),
        action: (path, dio) async {
          return await dio.post(path,
              data: _bodies,
              onSendProgress: onSendProgress,
              onReceiveProgress: onReceiveProgress,
              cancelToken: cancelToken);
        });
  }

  Future<T> postFiles<T>(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      required String baseAPI,
      String? clientId,
      String? secretKey,
      Duration? timeout,
      String? token,
      bool isNET = false}) async {
    Map<String, String> _headers = _getHeaders(headers, isNET: isNET);
    Map<String, dynamic> _bodies = _getBodies(body);

    if (clientId != null) _headers['X-Client-Id'] = clientId;
    if (secretKey != null) _headers['X-Client-Secret'] = secretKey;
    if (token != null) _headers["Authorization"] = token;

    return _clockRequest(
        path: url,
        bodies: _bodies,
        timeout: timeout,
        options: BaseOptions(
            contentType: "application/json",
            baseUrl: baseAPI,
            followRedirects: true,
            headers: _headers),
        action: (path, dio) async {
          FormData formData = new FormData.fromMap(_bodies);
          return await dio.post(path, data: formData);
        });
  }

  Future<T> put<T>(String url,
      {Map? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params,
      Duration? timeout,
      required String baseAPI,
      bool isNET = false}) async {
    Map<String, String> _headers = _getHeaders(headers, isNET: isNET);
    Map<String, dynamic> _params = params ?? {};
    Map<String, dynamic> _bodies = _getBodies(body);

    return _clockRequest(
        path: url,
        bodies: _bodies,
        timeout: timeout,
        options: BaseOptions(
            contentType: "application/json",
            baseUrl: baseAPI,
            queryParameters: _params,
            followRedirects: true,
            headers: _headers),
        action: (path, dio) async {
          return await dio.put(path, data: _bodies);
        });
  }

  Future<T> putFile<T>(String url,
      {Map? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params,
      Duration? timeout,
      required String baseAPI,
      bool isNET = false}) async {
    Map<String, String> _headers = _getHeaders(headers, isNET: isNET);
    Map<String, dynamic> _params = params ?? {};
    Map<String, dynamic> _bodies = _getBodies(body);

    return _clockRequest(
        path: url,
        bodies: _bodies,
        timeout: timeout,
        options: BaseOptions(
            contentType: "application/json",
            baseUrl: baseAPI,
            queryParameters: _params,
            followRedirects: true,
            headers: _headers),
        action: (path, dio) async {
          FormData formData = new FormData.fromMap(_bodies);
          return await dio.put(path, data: formData);
        });
  }

  Future<T> delete<T>(String url,
      {Map<String, String>? headers,
      required String baseAPI,
      Map? body,
      String? token,
      Duration? timeout,
      bool isNET = false}) async {
    Map<String, String> _headers = _getHeaders(headers, isNET: isNET);
    Map<String, dynamic> _bodies = _getBodies(body);
    if (token != null) _headers["Authorization"] = token;

    return _clockRequest(
        path: url,
        bodies: _bodies,
        timeout: timeout,
        options: BaseOptions(
            contentType: "application/json",
            baseUrl: baseAPI,
            followRedirects: true,
            headers: _headers),
        action: (path, dio) async {
          return await dio.delete(path, data: _bodies);
        });
  }

  Future<T> _completed<T>(String subUrl, Map<String, dynamic>? params,
      Map<String, dynamic> bodies, dynamic response, DateTime from,String baseUrl) async {
    String path = "";

    if (subUrl.isNotEmpty && !(params ?? {}).containsKey("q")) {
      String _path = stringOf(() => subUrl);
      String _query = stringOf(() => jsonEncode(params));
      String _bodies = stringOf(() => jsonEncode(bodies));
      path = [_path, _query, _bodies]
          .where((e) => e.isNotEmpty)
          .toList()
          .join("_");
    }

    String reasonPhrase = "";
    String body = "";
    String url = "";
    String redirectLink = "";
    int statusCode = 0;
    if (boolOf(() => response == null && path.isNotEmpty)) {
      var _body = Moor().load(path);
      statusCode = intOf(() => HttpStatus.ok);
      body = stringOf(() => _body);
      url = stringOf(() => path);
    }

    if (response is http.Response) {
      reasonPhrase =
          stringOf(() => response.reasonPhrase!, BaseTrans().$hasError);
      body = stringOf(() => response.body);
      url = stringOf(() => response.request?.url.toString());
      statusCode = intOf(() => response.statusCode);
    } else if (response is Response) {
      reasonPhrase =
          stringOf(() => response.statusMessage!, BaseTrans().$hasError);
      body = stringOf(() => json.encode(response.data));
      url = stringOf(() => response.requestOptions.uri.path,
          stringOf(() => response.requestOptions.path), [""]);
      statusCode = intOf(() => response.statusCode!);
      if (boolOf(() => response.isRedirect!)) {
        redirectLink = stringOf(() =>
            response.realUri.origin +
            response.realUri.path +
            response.realUri.query);
      }
      if (boolOf(() => statusCode == HttpStatus.ok && path.isNotEmpty)) {
        if (body.isNotEmpty) {
          Moor().save(path, body);
        }
      }
    }

    // _analytics(path, from, DateTime.now(), {
    //   "body": bodies,
    //   "query": params,
    // }, {
    //   "body": body,
    //   "status": statusCode,
    //   "reason": reasonPhrase,
    // });

    T? result;
    Map<String, dynamic> _json = {"message": reasonPhrase};
    try {
      _json = dataOf(() => json.decode(body), _json)!;
      result = parse<T>(_json);

      if (statusCode == HttpStatus.forbidden) {
        
      } else if (result is BaseModel) {
        result.statusCode = statusCode;
        result.redirectLink = redirectLink;
        result.error = dataOf(() => json.decode(body)["error"]);
        // if (!result.isSuccess) {
        //   var info = await PackageInfo.fromPlatform();
        //   var currentVersion = "${info.version}_${info.buildNumber}";
        //   Log().bot(state!,
        //       content: "Log API Error ${Config.title}:",
        //       title: "Error: ${result.statusCode}",
        //       data: {
        //         "api": baseUrl+url,
        //         "header": _baseHeader(),
        //         "params": params,
        //         "body": bodies,
        //         "error": result.error,
        //         "reason": reasonPhrase,
        //         "app_version": currentVersion,
        //         "env": BasePKG().env?.env
        //       });
        // }

        if (statusCode != HttpStatus.ok) {
          result.error = _json;
          var info = await PackageInfo.fromPlatform();
          var currentVersion = "${info.version}_${info.buildNumber}";
          Log().bot(state!,
              content: "Log API Error ${Config.title}:",
              title: "Error: ${result.statusCode}",
              isError: true,
              data: {
                "api": baseUrl+url,
                "header": _baseHeader(),
                "params": params,
                "body": bodies,
                "error": result.error,
                "reason": reasonPhrase,
                "app_version": currentVersion,
                "env": BasePKG().env?.env
              });
        }
        if (statusCode == HttpStatus.unauthorized) {
          if (!PackageManager().requiredLogout &&
              !MyProfile().isGuest  ) {
            PackageManager().requiredLogout = true;
            if(statusCode != 401)
            await MessageDialog.showErrors(state!, result.error);
            await MyProfile().logOut(state!, false);
            PackageManager().requiredLogout = false;
            App.restart();
          }
        }
      }
    } catch (e) {
      Log().shout(e);
      _catchError(e, url);
    } finally {
      print("Duration [${DateTime.now().difference(from).inMilliseconds}ms]");
    }
    return result!;
  }

  Map<String, dynamic> clearParam(Map<String, dynamic>? param) {
    if (param == null) return {};
    param.removeWhere((key, value) => value == null);
    if (param.isNotEmpty) {
      Log().info(param);
    }
    return param;
  }

  String canGuest(String path) {
    String _temp = (MyProfile().isGuest ? guestPref : "") + path;
    return _temp;
  }
}

class DataWithStatusCode<T> {
  final T data;
  final int statusCode;
  final String reason;

  DataWithStatusCode(this.data, this.statusCode, this.reason);
}
