import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/view/location/bottom_draggable_sheet.dart';
import 'package:flutter_template/src/view/location/group_icon_button.dart';
import 'package:flutter_template/src/view/location/location_controller.dart';
import 'package:flutter_template/src/view/location/refresh_timer.dart';

import 'info_window_marker.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  final GlobalKey _globalPanelKey = GlobalKey();
  double _maxChildSize = 0.35;
  MapType _mapType = MapType.normal;

  LocationController? _locationController;

  late bool hasLastData;

  @override
  void initState() {
    super.initState();
    context.deviceControllerRead.lastData?.getAddressAsync(context);
    hasLastData = context.deviceControllerRead.hasLastData;
  }

  @override
  Widget build(BuildContext context) {
    final showNavButton =
        MediaQuery.of(context).size.height > 500 ? true : false;

    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, constraints) {
          Future.delayed(const Duration(milliseconds: 500), () {
            final size = _globalPanelKey.currentContext
                ?.findRenderObject()
                ?.paintBounds
                .size;
            if (size != null) {
              final currentHeight =
                  (size.height + 10.h) / constraints.biggest.height;
              if (_maxChildSize != currentHeight) {
                setState(() {
                  _maxChildSize = currentHeight;
                });
              }
            }
          });

          if(!hasLastData && context.deviceControllerRead.hasLastData){
            hasLastData = true;
            _locationController?.addOrUpdateDeviceMarker(
                context.deviceControllerRead.lastData!.coordinate);

            _locationController?.addMarkerInfoWindow(
                context.deviceControllerRead.lastData!.coordinate,
                InfoWindowMarker(
                    deviceController: context.deviceControllerRead,
                    context2: context));
          }

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              MapWidget(
                center: context.deviceControllerWatch.lastData?.coordinate,
                onMapCreated: (controller) async {
                  _locationController =
                      LocationController(mapController: controller);
                  if (context.deviceControllerRead.hasLastData) {
                    _locationController?.addOrUpdateDeviceMarker(
                        context.deviceControllerRead.lastData!.coordinate);

                    _locationController?.addMarkerInfoWindow(
                        context.deviceControllerRead.lastData!.coordinate,
                        InfoWindowMarker(
                            deviceController: context.deviceControllerRead,
                            context2: context));
                  }
                  //设置marker点击回调
                  controller.mapController.setMapClickedMarkerCallback(
                      callback: (BMFMarker marker) {
                    if (controller.markerInfoWindow?.id == marker.id) {
                      controller.mapController.removeMarker(marker);
                      controller.markerInfoWindow = null;
                    }
                    if (controller.marker?.id == marker.id) {
                      if (controller.markerInfoWindow == null) {
                        _locationController?.addMarkerInfoWindow(
                            context.deviceControllerRead.lastData!.coordinate,
                            InfoWindowMarker(
                                deviceController: context.deviceControllerRead,
                                context2: context));
                      }
                    }
                  });
                },
              ),
              // 顶部计算
              Positioned(
                  top: 60.h,
                  child: RefreshTimer(
                    onRefresh: context.deviceControllerRead.getLast,
                  ),
                ),
              // 顶部List
              Positioned(
                top: 60.h,
                left: 20.w,
                child: GroupIconButton(
                  items: [
                    GroupIconButtonItem(
                      onPressed: () {
                        DevicesRoute().go(context);
                      },
                      icon: Icons.format_list_bulleted_rounded,
                    )
                  ],
                ),
              ),
              // 顶部layer
              if (showNavButton)
                Positioned(
                  top: 60.h,
                  right: 20.w,
                  child: GroupIconButton(
                    items: [
                      GroupIconButtonItem(
                        onPressed: () async {
                          if (_locationController != null) {
                            final res = await _locationController!.setMapType(
                              _mapType == MapType.normal
                                  ? MapType.satellite
                                  : MapType.normal,
                            );
                            if (res != null) {
                              setState(() {
                                _mapType = res;
                              });
                            }
                          }
                        },
                        icon: Icons.layers_outlined,
                        text: _mapType == MapType.normal
                            ? context.localization.satellite
                            : context.localization.normal,
                      )
                    ],
                  ),
                ),
              // 顶部导航
              if (showNavButton && context.deviceControllerWatch.hasLastData)
                Positioned(
                  top: 140.h,
                  right: 20.w,
                  child: GroupIconButton(
                    items: [
                      GroupIconButtonItem(
                        onPressed: () async {
                          if (context.deviceControllerRead.hasLastData &&
                              _locationController != null) {
                            await _locationController!.onOpenBaiduNaviNative(
                              context.deviceControllerRead.lastData!.coordinate,
                            );
                          }
                        },
                        icon: Icons.near_me_outlined,
                        text: context.localization.navigation,
                      )
                    ],
                  ),
                ),
              // 中部按钮
              if (context.deviceControllerWatch.hasLastData)
                Positioned(
                  bottom: showNavButton ? 230.h : null,
                  top: showNavButton ? null : 60.h,
                  right: 20.w,
                  child: GroupIconButton(
                    items: [
                      GroupIconButtonItem(
                        onPressed: () async {
                          if (_locationController != null) {
                            await _locationController!.drawUserToDeviceLine(
                                context
                                    .deviceControllerRead.lastData!.coordinate);
                          }
                        },
                        icon: Icons.route_outlined,
                      ),
                      GroupIconButtonItem(
                        onPressed: () async {
                          if (_locationController != null) {
                            await _locationController!.locateUser();
                          }
                        },
                        icon: Icons.location_searching_outlined,
                      ),
                    ],
                  ),
                ),
              // 底部
              if (context.deviceControllerWatch.hasLastData)
                BottomDraggableSheet(
                  panelKey: _globalPanelKey,
                  maxChildSize: _maxChildSize,
                  onRefresh: () {
                    _locationController?.setCenter(
                        context.deviceControllerRead.lastData!.coordinate);
                    context.deviceControllerRead.getLast();
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
