import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/refresh_builder.dart';
import 'package:flutter_template/src/data/json/message.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';
import 'package:flutter_template/src/view/message/message_filter.dart';
import 'package:flutter_template/src/view/message/message_item.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});


  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  bool sort = true;
  late RefreshController<Message> controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.localization.navMessage,
        leading: MessageFilter(
          onSelected: (filter) {
            sort = filter.index == 0;
            controller.refresh();
          },
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.cleaning_services,
              color: context.secondaryColor,
              size: 18.r,
            ),
            label: Text(
              context.localization.clear,
              style: context.labelLarge.copyWith(
                color: context.secondaryColor,
              ),
            ),
          ),
        ],
      ),
      body: RefreshBuilder<Message>(
        loadMore: false,
        backgroundColor: Colors.transparent,
        refreshController: (control)=>{
          controller = control
        },
        future: (offset, limit) => context.deviceControllerRead.getMessages(sort),
        builder: (context, data) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: MessageItem(
              message: data,
            )
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 20.h);
        },
      ),
    );
  }
}
