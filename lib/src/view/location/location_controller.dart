import 'package:flutter/widgets.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_template/src/components/map_widget.dart';

class LocationController {
  final MapWidgetController mapController;
  bool _showUserLocation = false;

  LocationController({required this.mapController});

  Future<void> locateUser() {
    if (!_showUserLocation) {
      _showUserLocation = true;
      return mapController.showUserLocation(true);
    }
    return mapController.locateUser();
  }

  Future<MapType?> setMapType(MapType type) async {
    final res = await mapController.setMapType(type);
    if (res) {
      return type;
    }
    return null;
  }

  Future<void> drawUserToDeviceLine(BMFCoordinate devicePosition) {
    return mapController.drawUserToDeviceLine(devicePosition);
  }

  Future<void> addOrUpdateDeviceMarker(BMFCoordinate target) async {
    await mapController.addMarker(target);
    await mapController.setCenterIfOutofBounds(target);
  }

  Future<void> addMarkerInfoWindow(BMFCoordinate target, Widget widget) async {
    await mapController.addMarkerInfoWindow(target,widget);
  }

  Future<BMFTraceOverlay?> drawDynamicTrajectories(List<BMFCoordinate> position,double duration) async {
    return await mapController.drawDynamicTrajectories(position,duration);
  }

  Future<bool> setCenter(BMFCoordinate position) async {
    return await mapController.setCenter(position);
  }

  Future<void> onOpenBaiduNaviNative(BMFCoordinate devicePosition){
    return mapController.onOpenBaiduNaviNative(devicePosition);
  }
}
