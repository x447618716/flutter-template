import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

enum Menu { asc, desc }

class MessageFilter extends StatelessWidget {
  const MessageFilter({super.key, required this.onSelected});

  final void Function(Menu) onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Menu>(
      child: Row(
        children: [
          SizedBox(width: 5.w),
          Icon(
            Icons.filter_alt,
            color: context.secondaryColor,
            size: 18.r,
          ),
          Text(context.localization.screen,style: context.labelLarge.copyWith(
              color: context.secondaryColor,
          ),)
        ],
      ),
      onSelected: (Menu item) {
        onSelected(item);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        PopupMenuItem<Menu>(
          value: Menu.asc,
          child: ListTile(
            title: Text(
              context.localization.sortSelect(Menu.asc.index),
              style: context.labelMedium,
            ),
          ),
        ),
        PopupMenuItem<Menu>(
          value: Menu.desc,
          child: ListTile(
            title: Text(
              context.localization.sortSelect(Menu.desc.index),
              style: context.labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}
