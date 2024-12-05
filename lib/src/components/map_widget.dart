import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_search/flutter_baidu_mapapi_search.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import 'package:flutter_bmflocation/flutter_bmflocation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:location/location.dart';
import 'package:screenshot/screenshot.dart';

const bool _showZoomControl = false;

class MapWidget extends StatelessWidget {
  const MapWidget(
      {super.key,
      this.onMapCreated,
      this.zoomLevel,
      this.center,
      this.zoomEnabled,
      this.scrollEnabled});

  final Function(MapWidgetController controller)? onMapCreated;
  final int? zoomLevel;
  final BMFCoordinate? center;
  final bool? zoomEnabled;
  final bool? scrollEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final BMFMapOptions mapOptions = BMFMapOptions(
        center: center,
        zoomLevel: zoomLevel ?? 16,
        showMapScaleBar: false,
        zoomEnabled: zoomEnabled ?? true,
        zoomEnabledWithTap: zoomEnabled ?? true,
        scrollEnabled: scrollEnabled ?? true,
        showZoomControl: _showZoomControl);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: BMFMapWidget(
            onBMFMapCreated: (controller) {
              if (theme.brightness == Brightness.dark) {
                BMFCustomMapStyleOption customMapStyleOption =
                    BMFCustomMapStyleOption(
                  customMapStyleID: "2b79aa5d8d09cbc854dca3dbd93a3197",
                );

                controller.setCustomMapStyleWithOptionPath(
                  customMapStyleOption: customMapStyleOption,
                  preload: (path) {},
                  success: (path) {},
                  error: (errorCode, path) {},
                );
              }
              //设置地图加载完成回调
              controller.setMapDidLoadCallback(callback: () {
                if (onMapCreated != null) {
                  onMapCreated!(
                    MapWidgetController(
                      context,
                      mapController: controller,
                    ),
                  );
                }
              });
            },
            mapOptions: mapOptions,
          ),
        );
      },
    );
  }
}

/// 申请定位权限
/// 授予定位权限返回true， 否则返回false
Future<bool> requestPermission(BuildContext context) async {
  String grantText = context.localization.locationPermission;
  String serviceText = context.localization.openLocationService;
  Location location = Location();
  //获取当前的权限
  PermissionStatus status = await location.hasPermission();
  if (status != PermissionStatus.granted) {
    status = await location.requestPermission();
    if (status != PermissionStatus.granted) {
      EasyLoading.showToast(grantText);
      return false;
    }
  }

  bool serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      EasyLoading.showToast(serviceText);
      return false;
    }
  }

  return true;
}

enum MapType {
  normal,
  satellite,
}

class MapWidgetController {
  final BMFMapController mapController;
  final BuildContext context;
  BMFMarker? marker;
  BMFMarker? markerInfoWindow;
  BMFPolyline? _polyline;
  BMFTraceOverlay? _traceOverlay;
  ScreenshotController screenshotController = ScreenshotController();

  MapWidgetController(this.context, {required this.mapController});

  ///地图初始化
  static Future<void> init() async {
    /// 设置用户是否同意SDK隐私协议
    LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();
    BMFMapSDK.setAgreePrivacy(true);
    myLocPlugin.setAgreePrivacy(true);
    // 百度地图sdk初始化鉴权
    if (Platform.isIOS) {
      myLocPlugin.authAK('V9WQa7tYiGiXV67wO9uKnkAUTK2g8OJZ');
      BMFMapSDK.setApiKeyAndCoordType(
          'V9WQa7tYiGiXV67wO9uKnkAUTK2g8OJZ', BMF_COORD_TYPE.COMMON);
    } else if (Platform.isAndroid) {
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.COMMON);
      await BMFAndroidVersion.initAndroidVersion();
    }
  }

  ///根据经纬度检索地址
  static Future<String> getAddress(
      BuildContext context, BMFCoordinate devicePosition) async {
    Completer<String> completer = Completer<String>();
    // 构造检索参数
    BMFReverseGeoCodeSearchOption reverseGeoCodeSearchOption =
        BMFReverseGeoCodeSearchOption(
      location: devicePosition,
    );
    // 检索实例
    BMFReverseGeoCodeSearch reverseGeoCodeSearch = BMFReverseGeoCodeSearch();
    // 逆地理编码回调
    reverseGeoCodeSearch.onGetReverseGeoCodeSearchResult(callback:
        (BMFReverseGeoCodeSearchResult result, BMFSearchErrorCode errorCode) {
      if (errorCode != BMFSearchErrorCode.NO_ERROR) {
        completer.complete(context.localization.showAddressTip);
        return;
      }
      String address = (result.address == null || result.address!.isEmpty)
          ? context.localization.unknownAddress
          : result.address!;
      completer.complete(address);
    });
    //发起检索
    await reverseGeoCodeSearch.reverseGeoCodeSearch(reverseGeoCodeSearchOption);
    return completer.future;
  }

  ///设置地图中心点
  Future<bool> setCenter(BMFCoordinate position) {
    return mapController.setCenterCoordinate(position, true);
  }

  ///定位用户当前位置
  Future<BMFCoordinate?> startLocation() async {
    Completer<BMFCoordinate?> completer = Completer<BMFCoordinate?>();

    //定位权限判定
    final granted = await requestPermission(context);
    if (!granted) {
      completer.complete(null);
      return completer.future;
    }

    //定位实例
    final LocationFlutterPlugin myLocPlugin = LocationFlutterPlugin();

    //设置定位参数
    final iosOptions = BaiduLocationIOSOption(
      // 坐标系
      coordType: BMFLocationCoordType.gcj02,
      // 位置获取超时时间
      locationTimeout: 10,
      // 获取地址信息超时时间
      reGeocodeTimeout: 10,
      // 应用位置类型 默认为automotiveNavigation
      activityType: BMFActivityType.automotiveNavigation,
      // 设置预期精度参数 默认为best
      desiredAccuracy: BMFDesiredAccuracy.best,
      // 是否需要最新版本rgc数据
      isNeedNewVersionRgc: true,
      // 指定定位是否会被系统自动暂停
      pausesLocationUpdatesAutomatically: false,
      // 指定是否允许后台定位,
      // 允许的话是可以进行后台定位的，但需要项目
      //配置允许后台定位，否则会报错，具体参考开发文档
      allowsBackgroundLocationUpdates: true,
      // 设定定位的最小更新距离
      distanceFilter: 10,
    );
    final androidOptions = BaiduLocationAndroidOption(
      // 定位模式，可选的模式有高精度、仅设备、仅网络。默
      //认为高精度模式
      locationMode: BMFLocationMode.hightAccuracy,
      openGps: true,
      coordType: BMFLocationCoordType.gcj02,
    );
    await myLocPlugin.prepareLoc(androidOptions.getMap(), iosOptions.getMap());

    if (Platform.isIOS) {
      //定位回调
      myLocPlugin.singleLocationCallback(callback: (BaiduLocation result) {
        if (result.latitude == null || result.longitude == null) {
          completer.complete(null);
        } else {
          completer
              .complete(BMFCoordinate(result.latitude!, result.longitude!));
        }
      });
      //开启定位
      await myLocPlugin
          .singleLocation({'isReGeocode': true, 'isNetworkState': true});
    } else if (Platform.isAndroid) {
      //定位回调
      myLocPlugin.seriesLocationCallback(
          callback: (BaiduLocation result) async {
        if (result.latitude == null || result.longitude == null) {
          completer.complete(null);
        } else {
          completer
              .complete(BMFCoordinate(result.latitude!, result.longitude!));
        }
        await myLocPlugin.stopLocation();
      });
      //开启定位
      await myLocPlugin.startLocation();
    }

    return completer.future;
  }

  ///更新用户定位
  Future<void> locateUser() async {
    BMFCoordinate? position = await startLocation();
    if (position != null) {
      setCenter(position);
      BMFLocation location = BMFLocation(coordinate: position);
      BMFUserLocation userLocation = BMFUserLocation(location: location);
      await mapController.updateLocationData(userLocation);
    }
  }

  ///显示用户定位
  Future<void> showUserLocation(bool show) async {
    //开启定位图层
    await mapController.showUserLocation(show);

    BMFUserLocationDisplayParam displayParam = BMFUserLocationDisplayParam(
      locationViewOffsetX: 0,
      locationViewOffsetY: 0,
      enableDirection: false,
      isAccuracyCircleShow: false,
      locationViewImage: 'assets/images/animation_red.png',
      locationViewHierarchy:
          BMFLocationViewHierarchy.LOCATION_VIEW_HIERARCHY_BOTTOM,
    );
    await mapController.updateLocationViewWithParam(displayParam);
    locateUser();
  }

  ///设置地图类型
  Future<bool> setMapType(MapType type) {
    return mapController.updateMapOptions(
      BMFMapOptions(
        showZoomControl: _showZoomControl,
        mapType:
            type == MapType.normal ? BMFMapType.Standard : BMFMapType.Satellite,
      ),
    );
  }

  ///绘制用户所在位置到设备的直线
  Future<void> drawUserToDeviceLine(BMFCoordinate devicePosition) async {
    BMFCoordinate? position = await startLocation();
    if (position != null) {
      if (_polyline != null) {
        mapController.removeOverlay(_polyline!.id);
      }

      List<BMFCoordinate> coordinates = [];
      coordinates.add(position);
      coordinates.add(devicePosition);

      _polyline = BMFPolyline(
          coordinates: coordinates,
          indexs: [0],
          colors: [Colors.blue],
          width: 16,
          dottedLine: false,
          lineDashType: BMFLineDashType.LineDashTypeNone,
          lineCapType: BMFLineCapType.LineCapButt,
          lineJoinType: BMFLineJoinType.LineJoinRound);

      mapController.addPolyline(_polyline!);
    }
  }

  ///添加与更新Marker
  Future<bool> addMarker(BMFCoordinate position,
      [String icon = "assets/images/icon-512-1.png"]) async {
    if (marker != null) {
      return await marker!.updatePosition(position);
    } else {
      marker = BMFMarker.icon(
          position: position,
          identifier: 'gps',
          icon: icon,
          scaleX: 2,
          scaleY: 2);
      return await mapController.addMarker(marker!);
    }
  }

  ///添加与更新Marker信息窗
  Future<bool> addMarkerInfoWindow(
      BMFCoordinate position, Widget widget) async {
    Uint8List imageBytes = await screenshotController.captureFromWidget(widget);
    if (markerInfoWindow != null) {
      mapController.removeMarker(markerInfoWindow!);
    }

    markerInfoWindow = BMFMarker.iconData(
        position: position,
        identifier: 'gpsInfo',
        canShowCallout: false,
        centerOffset: BMFPoint(0, -200), // 设置marker偏移量可以作为弹窗
        iconData: imageBytes);
    return mapController.addMarker(markerInfoWindow!);
  }

  ///设备位置不在地图范围内重新设置中心点为设备坐标
  Future<void> setCenterIfOutofBounds(BMFCoordinate position) async {
    BMFCoordinateBounds? bounds = await mapController.getVisibleMapBounds();

    if (bounds == null) {
      return;
    }
    final target = position;
    final northeast = bounds.northeast;
    final southwest = bounds.southwest;
    final northwest = BMFCoordinate(northeast.latitude, southwest.longitude);
    final southeast = BMFCoordinate(southwest.latitude, northeast.longitude);

    final res = await BMFCalculateUtils.polygonContainsCoordinate(
      target,
      [northeast, northwest, southwest, southeast],
    );
    if (res == true) {
      return;
    }
    await setCenter(position);
  }

  ///绘制动态轨迹
  Future<BMFTraceOverlay?> drawDynamicTrajectories(
      List<BMFCoordinate> coords, double duration) async {
    /// 渐变色
    List<Color> colors = [];
    for (var i = 0; i < coords.length; i++) {
      colors.add(const Color.fromARGB(255, 255, 0, 0));
    }

    /// 构造动态轨迹动画参数
    BMFTraceOverlayAnimateOption traceOverlayAnimateOption =
        BMFTraceOverlayAnimateOption(
      animate: true,
      delay: 0.0,
      duration: duration,
      fromValue: 0.0,
      toValue: 1.0,
      easingCurve: BMFTraceOverlayAnimationEasingCurve.Linear,
      trackMove: true,
      isPointMove: true,
      isRotateWhenTrack: false,
      icon: "assets/images/driving.png",
    );

    /// 构造动态轨迹
    _traceOverlay = BMFTraceOverlay(
        width: 10,
        coordinates: coords,
        traceOverlayAnimateOption: traceOverlayAnimateOption,
        isThined: true,
        isTrackBloom: true,
        isGradientColor: true,
        bloomSpeed: 5.0,
        isCornerSmooth: false,
        strokeColors: colors);
    final temp = await mapController.addTraceOverlay(_traceOverlay!);
    if (temp) {
      return _traceOverlay;
    }
    return null;
  }

  ///地理围栏
  Future<void> geographicFence(BMFCoordinate position, double radius) async {
    //添加圆形覆盖物
    BMFHollowShape hollowShapeCircle =
        BMFHollowShape.circle(center: position, radius: radius);
    BMFCircle circle0 = BMFCircle(
        center: position,
        radius: radius,
        width: 1,
        strokeColor: Colors.blue,
        lineDashType: BMFLineDashType.LineDashTypeNone,
        hollowShapes: [hollowShapeCircle]);
    await mapController.addCircle(circle0);

    LocationCircleGeofenceOption op = LocationCircleGeofenceOption(
        radius: radius.toString(),
        centerCoordinate:
            BMFLocCoordinate(position.latitude, position.longitude),
        coordType: BMFLocationCoordType.gcj02,
        activateAction: GeofenceActivateAction.geofenceAll,
        customId: 'circleGeofence_id$radius',
        allowsBackgroundLocationUpdates: true);

    final GeofenceFlutterPlugin myGeofencePlugin = GeofenceFlutterPlugin();

    ///添加地理围栏
    myGeofencePlugin.addCircleRegion(op.toMap());

    ///地理围栏创建回调
    myGeofencePlugin.geofenceFinishCallback(callback: (BMFGeofence? geofence) {
      if (geofence != null) {
        if (kDebugMode) {
          print('创建完成${geofence.geofenceId!}${geofence.geofenceStyle}');
        }
      }
    });
  }

  ///打开百度地图客户端启动驾车导航模式
  Future<void> onOpenBaiduNaviNative(BMFCoordinate devicePosition) async {
    BMFCoordinate? position = await startLocation();
    if (position != null) {
      BMFOpenNaviOption naviOption = BMFOpenNaviOption(
          startCoord: position,
          endCoord: devicePosition,
          startName: "我的位置",
          endName: "设备位置",
          naviType: BMFNaviType.DriveNavi, //驾车导航
          appScheme: 'baidumapsdk://mapsdk.baidu.com', // 指定返回自定义scheme
          appName: 'baidumap', // 应用名称
          isSupportWeb:
              true); // 调起百度地图客户端驾车导航失败后（步行、骑行导航设置该参数无效），是否支持调起web地图，默认：true

      BMFOpenErrorCode? flag =
          await BMFOpenMapUtils.openBaiduMapNavi(naviOption);
      if (kDebugMode) {
        print('打开百度地图客户端-errorCode = $flag');
      }
    }
  }
}
