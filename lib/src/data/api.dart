import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/data/json/alarm_param.dart';
import 'package:flutter_template/src/data/json/device.dart';
import 'package:flutter_template/src/data/json/historical_traces_all.dart';
import 'package:flutter_template/src/data/json/last_data.dart';
import 'package:flutter_template/src/data/json/message.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_template/src/data/json/login_result.dart';

const _baseUrl = "https://openapi.yi-ll.com";
const _devPath = "/gps-app";
const _ssoPath = "/test/sso";
const _tenant = '6';
const _scope = 'openid iThings.Authentication.Base offline_access';
const _clientId = 'flutter_template';
const _moduleName = 'gps';
const tokenStoreKey = 'token';

class Api {
  static Api? _instance;
  static Api get instance => _instance ??= Api._();
  static final Map<String, CancelToken> _queue = <String, CancelToken>{};

  LoginResult? _loginResult;
  final SharedPreferencesWithCache prefs = Application.prefsWithCache;
  late final Dio dio;

  //基础配置
  final options = BaseOptions(
      baseUrl: "http://test.gps.saas.yi-ll.com:8066", //http://test.gps.saas.yi-ll.com:8066 //https://openapi.yi-ll.com
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      contentType: Headers.jsonContentType,
      headers: {"language": 0},
      extra: {"needToken": true, "queue": true});

  Api._() {
    //获取保存在内存中的用户token
    if (prefs.containsKey(tokenStoreKey)) {
      String? token = prefs.getString(tokenStoreKey);
      if (token != null && token.isNotEmpty) {
        _loginResult = LoginResult.fromJson(jsonDecode(token));
      }
    }

    dio = Dio(options)
      ..interceptors.add(InterceptorsWrapper(onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        //请求是否需要加入队列(加入队列的请求在出现重复请求时始终以最新请求为准取消之前的相同请求)=>防抖请求
        if (options.extra["queue"]) {
          CancelToken? cancelToken = _queue[options.path];
          //当前请求是否已在队列中
          if (cancelToken != null) {
            //取消之前请求
            cancelToken.cancel();
            //移除之前请求
            _queue.remove(options.path);
          }
          //将当前请求追加到队列中并返回取消token
          options.cancelToken =
              _queue.putIfAbsent(options.path, () => CancelToken());
        }
        //是否需要添加请求认证头
        if (options.extra["needToken"]) {
          if (_isTokenExpired) {
            if(await isTokenExpired()){
              //如果再次返回true说明用户为首次使用或为用户已手动退出
              Response response = Response(requestOptions: options);
              return handler.resolve(response);
            }
          }
          options.headers = {
            ...options.headers,
            ...{
              'Authorization': 'Bearer ${_loginResult?.accessToken}',
              'moduleName': _moduleName,
            }
          };
        }
        return handler.next(options);
      }, onResponse: (Response response, ResponseInterceptorHandler handler) {
        //请求完成移出队列
        _queue.remove(response.requestOptions.path);
        return handler.next(response);
      }, onError: (DioException error, ErrorInterceptorHandler handler) {
        if (CancelToken.isCancel(error)) {
          if (kDebugMode) {
            print(error.message);
          }
          Response response = Response(requestOptions: error.requestOptions);
          return handler.resolve(response);
        } else {
          //请求完成移出队列
          _queue.remove(error.requestOptions.path);
          if (kDebugMode) {
            print("当前请求地址：${error.requestOptions.path}");
            print(error.response);
          }
          handleError(error, handler);
        }
      }))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }

  //统一错误处理
  handleError(DioException e, ErrorInterceptorHandler handler) {
    Response? response = e.response;
    if (response != null) {
      switch (response.statusCode) {
        case 500:
          if(EasyLoading.instance.overlayEntry != null){
            EasyLoading.showToast("服务器异常请稍后重试！");
          }
          break;
        default:
          if (response.data is Map) {
            if(EasyLoading.instance.overlayEntry != null){
              EasyLoading.showToast(response.data["error_description"]);
            }
          } else {
            if(EasyLoading.instance.overlayEntry != null){
              EasyLoading.showToast(response.data);
            }
          }
      }
    } else {
      response = Response(requestOptions: e.requestOptions);
      if(EasyLoading.instance.overlayEntry != null){
        EasyLoading.showToast("未知异常");
      }
    }

    return handler.resolve(response);
  }

  ///将用户token保存至内存中
  void _saveLoginResult(LoginResult loginResult) {
    _loginResult = loginResult;
    prefs.setString(tokenStoreKey, jsonEncode(loginResult.toJson()));
  }

  ///根据登录结果的过期时间字段判断token是否过期(true:token过期 false:token正常)
  bool get _isTokenExpired =>
      _loginResult?.expireDate == null ||
      DateTime.now().isAfter(_loginResult!.expireDate!);

  ///判断是否用户token过期并刷新用户token 并返回过期bool值(true:token过期 false:token正常)
  Future<bool> isTokenExpired() async {
    if (_isTokenExpired && _loginResult != null) {
      await refreshToken();
    }
    return _isTokenExpired;
  }

  ///刷新用户token
  Future<void> refreshToken() async {
    Response response = await dio.post("$_baseUrl$_ssoPath/connect/token",
        data: {
          "grant_type": "refresh_token",
          "refresh_token": _loginResult!.refreshToken,
          "scope": _scope,
          "client_id": _clientId
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          extra: {"needToken": false},
        ));
    if (response.statusCode == 200) {
      final result = LoginResult.fromJson(response.data);
      _saveLoginResult(result);
    }
  }

  ///用户登录
  Future<bool> login(String phone, String code) async {
    Response response = await dio.post('$_baseUrl$_ssoPath/connect/token',
        data: {
          "grant_type": "sms_code",
          "phone": phone,
          "scope": _scope,
          "client_id": _clientId,
          "code": code,
          "tenant_id": _tenant
        },
        options: Options(
            contentType: Headers.formUrlEncodedContentType,
            extra: {"needToken": false}));
    if (response.statusCode == 200) {
      if (response.data != null) {
        final result = LoginResult.fromJson(response.data);
        _saveLoginResult(result);
        return true;
      }
    }
    return false;
  }

  ///用户退出
  Future<void> logout() async {
    _loginResult = null;
    prefs.remove(tokenStoreKey);
  }

  ///发送验证码
  Future<bool> sendCode(String phone) async {
    Response response =
        await dio.post("$_baseUrl$_ssoPath/api/account/$phone?check=false",options: Options(
            contentType: Headers.formUrlEncodedContentType,
            extra: {"needToken": false}));
    if (response.statusCode == 200) {
      if (response.data != null) {
        return true;
      }
    }
    return false;
  }

  ///获取Markdown文档
  Future<String> getMarkdown(String file) async {
    Response response = await dio.get(
        'https://yill-res.obs.cidc-rp-2006.joint.cmecloud.cn/$file.md',
        options: Options(extra: {"needToken": false}));
    if (response.statusCode == 200) {
      return response.toString();
    }
    return '';
  }

  ///获取设备列表
  Future<List<Device>?> getDevices() async {
    Response response = await dio.get("/v1/device/list");
    if (response.statusCode == 200) {
      List<Device> list = [];
      response.data.forEach((e) {
        list.add(Device.fromJson(e));
      });
      return list;
    }
    return null;
  }

  ///设置默认设备
  Future<List<Device>?> setDefault(String deviceId) async {
    Response response = await dio.put("/v1/device/default/$deviceId");
    if (response.statusCode == 200) {
      List<Device> list = [];
      response.data.forEach((e) {
        list.add(Device.fromJson(e));
      });
      return list;
    }
    return null;
  }

  ///添加设备
  Future<List<Device>?> addDevice(String deviceId, String name) async {
    Response response = await dio
        .put("/v1/device/bind/$deviceId", queryParameters: {"name": name});
    if (response.statusCode == 200) {
      List<Device> list = [];
      response.data.forEach((e) {
        list.add(Device.fromJson(e));
      });
      return list;
    }
    return null;
  }

  ///解绑设备
  Future<List<Device>?> unbindDevice(String deviceId) async {
    Response response = await dio.put("/v1/device/unbind/$deviceId");
    if (response.statusCode == 200) {
      List<Device> list = [];
      response.data.forEach((e) {
        list.add(Device.fromJson(e));
      });
      return list;
    }
    return null;
  }

  ///更新设备
  Future<List<Device>?> updateDevice(String deviceId, String name, String icon,int traceMode,{String remark = ""}) async {
    Response response = await dio.put("/v1/device/update", data: {
      "deviceId": deviceId,
      "name": name,
      "icon": icon,
      "remark": remark,
      "traceMode": traceMode
    });
    if (response.statusCode == 200) {
      List<Device> list = [];
      response.data.forEach((e) {
        list.add(Device.fromJson(e));
      });
      return list;
    }
    return null;
  }

  ///获取设备告警参数
  Future<List<AlarmParam>?> getAlarmParams(String sn) async {
    Response response =
        await dio.get("$_baseUrl$_devPath/v1/device/alarm/list/params/$sn");

    if (response.statusCode == 200) {
      return (jsonDecode(response.data) as List)
          .map((e) => AlarmParam.fromJson(e))
          .toList();
    }
    return null;
  }

  ///更新设备告警参数
  Future<List<AlarmParam>?> updateAlarmParams(
      String sn, List<AlarmParam> params) async {
    Response response = await dio.post(
        "$_baseUrl$_devPath/v1/device/alarm/set/params/$sn",
        data: jsonEncode(params.map((e) => e.toJson()).toList()));

    if (response.statusCode == 200) {
      return (jsonDecode(response.data) as List)
          .map((e) => AlarmParam.fromJson(e))
          .toList();
    }
    return null;
  }

  ///获取消息列表
  Future<List<Message>?> getMessages(String deviceId, bool desc) async {
    Response response = await dio
        .get("/v1/device/eventmsg/history/$deviceId", queryParameters: {
      "beginDate": Jiffy.parse("2024-7-24")
          .startOf(Unit.day)
          .format(pattern: 'yyyy-MM-dd HH:mm'),
      "endDate": Jiffy.parse("2024-7-24")
          .endOf(Unit.day)
          .format(pattern: 'yyyy-MM-dd HH:mm'),
      "desc": desc
    });

    if (response.statusCode == 200) {
      List<Message> list = [];
      response.data.forEach((e) {
        list.add(Message.fromJson(e));
      });
      return list;
    }
    return null;
  }

  ///读消息
  Future<void> readMessage(String deviceId, int messageId) async {
    await dio.put("/v1/device/eventmsg/read/$deviceId/$messageId");
  }

  ///获取设备最后数据
  Future<LastData?> getLast(String deviceId) async {
    Response response = await dio.post("/v1/device/last", data: [deviceId]);
    if (response.statusCode == 200) {
      if(response.data.length != 0){
        return LastData.fromJson(response.data[0]);
      }
    }
    return null;
  }

  ///查询设备历史轨迹
  Future<HistoricalTracesAll?> queryTrajectory(
      String deviceId,
      String beginDate,
      String endDate,
      List<int> locateModes,
      int stopTime) async {

    final data = [];
    for (var e in locateModes) {
      data.add(e);
    }

    Response response = await dio
        .get("/v1/device/location/history/$deviceId", data: {
      "beginDate": beginDate,
      "endDate": endDate,
      "locateModes": data,
      "stopTime": stopTime
    });

    if (response.statusCode == 200) {
      return HistoricalTracesAll.fromJson(response.data);
    }
    return null;
  }
}
