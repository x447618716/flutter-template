import 'package:flutter/material.dart' as base;
import 'package:flutter_template/src/theme.dart';

class AppBar extends base.StatelessWidget implements base.PreferredSizeWidget {
  const AppBar({
    super.key,
    required this.title,
    this.actions,
    this.toolbarHeight,
    this.bottom,
    this.leading,
  });
  final String title;
  final List<base.Widget>? actions;
  final double? toolbarHeight;
  final base.PreferredSizeWidget? bottom;
  final base.Widget? leading;

  @override
  base.Widget build(base.BuildContext context) {
    return base.AppBar(
      centerTitle: true,
      backgroundColor: context.backgroundColor,
      leading: leading,
      title: base.Text(
        title,
        style: context.titleLarge,
      ),
      actions: actions,
    );
  }

  @override
  base.Size get preferredSize =>
      _PreferredAppBarSize(toolbarHeight, bottom?.preferredSize.height);
}

const double kToolbarHeight = 56.0;

class _PreferredAppBarSize extends base.Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
