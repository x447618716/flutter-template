import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/data/json/message.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/message/address_row.dart';
import 'package:flutter_template/src/view/message/message_row.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: context.backgroundColor,
      shape: BoxShape.rectangle,
      elevation: 1.0,
      borderRadius: BorderRadius.circular(15.r),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Column(
          children: [
            Material(
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.r),
                    color: context.primaryColor.withOpacity(0.1),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.r, vertical: 3.r),
                  child: Text(
                    context.localization.isRead(message.isRead.toString()),
                    style: context.labelSmall.copyWith(
                      color: context.primaryColor,
                    ),
                  ),
                ),
                title: Text(
                  message.eventType.name,
                  style: context.titleMedium,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 20.r),
                trailing: Icon(
                  Icons.chevron_right_outlined,
                  color: context.dividerColor,
                ),
                onTap: () async {
                  MessageDetailRoute(message).go(context);
                  await context.deviceControllerRead.readMessage(message.id);
                  message.setRead(true);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.r, left: 20.r, right: 20.r),
              child: Column(
                children: [
                  MessageRow(
                    label: context.localization.deviceSN,
                    value: message.deviceId,
                  ),
                  SizedBox(height: 10.h),
                  MessageRow(
                    label: context.localization.triggerTime,
                    value: message.time,
                  ),
                  SizedBox(height: 10.h),
                  AddressRow(
                    message: message,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
