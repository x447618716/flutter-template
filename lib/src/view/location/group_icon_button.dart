import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/theme.dart';

class GroupIconButtonItem {
  const GroupIconButtonItem({
    required this.onPressed,
    required this.icon,
    this.text,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final String? text;
}

class GroupIconButton extends StatelessWidget {
  const GroupIconButton({
    super.key,
    required this.items,
  });
  final List<GroupIconButtonItem> items;

  Widget _buildItem(GroupIconButtonItem item, BuildContext context) {
    return TextButton(
      onPressed: item.onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(10.w),
        minimumSize: Size(49.w, 49.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15).w,
        ),
      ),
      child: Column(
        children: [
          Icon(
            item.icon,
            color: context.primaryColor,
            size: 29.w,
          ),
          if (item.text != null)
            Text(
              item.text!,
              style: context.labelSmall,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final maps = items.map((item) => _buildItem(item, context));
    final itemWidgets = <Widget>[];
    for (var i = 0; i < maps.length; i++) {
      if (i != 0) {
        itemWidgets.add(
          SizedBox(
            width: 49.w,
            child: Divider(
              height: 4.h,
              thickness: 1,
              indent: 15.w,
              endIndent: 15.w,
            ),
          ),
        );
      }
      itemWidgets.add(maps.elementAt(i));
    }

    return PhysicalModel(
      color: context.backgroundColor,
      borderRadius: BorderRadius.circular(15).r,
      elevation: 1.0,
      child: Column(
        children: itemWidgets,
      ),
    );
  }
}
