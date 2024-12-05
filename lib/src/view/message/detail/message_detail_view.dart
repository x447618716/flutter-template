import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/data/json/message.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/location/location_controller.dart';
import 'package:flutter_template/src/view/message/address_row.dart';
import 'package:flutter_template/src/view/message/message_row.dart';

class MessageDetailView extends StatefulWidget {
  const MessageDetailView({super.key, required this.message});

  final Message message;

  @override
  State<MessageDetailView> createState() => _MessageDetailViewState();
}

class _MessageDetailViewState extends State<MessageDetailView> {
  LocationController? _locationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.messageDetailTitle,
      ),
      body: Stack(
        children: [
          MapWidget(
            center: widget.message.coordinate,
            onMapCreated: (controller) {
              _locationController =
                  LocationController(mapController: controller);
              _locationController!
                  .addOrUpdateDeviceMarker(widget.message.coordinate);
            },
          ),
          Positioned(
            bottom: 20.r,
            left: 20.r,
            right: 20.r,
            child: PhysicalModel(
              color: context.backgroundColor,
              elevation: 1.0,
              borderRadius: BorderRadius.circular(15.r),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.notifications,
                            color: context.errorColor,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              widget.message.eventType.name,
                              style: context.titleMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      MessageRow(
                        label: context.localization.deviceSN,
                        value: widget.message.deviceId,
                      ),
                      SizedBox(height: 10.h),
                      MessageRow(
                        label: context.localization.triggerTime,
                        value: widget.message.time,
                      ),
                      SizedBox(height: 10.h),
                      AddressRow(
                        message: widget.message,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
