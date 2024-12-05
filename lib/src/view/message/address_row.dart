import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/loading.dart';
import 'package:flutter_template/src/components/map_widget.dart';
import 'package:flutter_template/src/data/json/message.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class AddressRow extends StatefulWidget {
  const AddressRow({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  State<AddressRow> createState() => _AddressRowState();
}

class _AddressRowState extends State<AddressRow> {
  late bool _showAddress;

  @override
  void initState() {
    super.initState();
    _showAddress = widget.message.address.isNotEmpty;
  }

  @override
  void didUpdateWidget(covariant AddressRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    _showAddress = widget.message.address.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!_showAddress)
          Loading(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 7.h,
            ),
            expanded: false,
            future: _getAddress,
            child: Text(
              context.localization.viewAddress,
              style: context.labelSmall.copyWith(
                color: context.onPrimaryColor,
              ),
            ),
          ),
        if (!_showAddress) const SizedBox.shrink(),
        if (_showAddress)
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: context.titleSmall.color!.withOpacity(0.1),
              ),
              child: Text(
                widget.message.address,
                style: context.bodySmall,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _getAddress() async {
    String address = await MapWidgetController.getAddress(context, widget.message.coordinate);
    widget.message.setAddress(address);
    setState(() {
      _showAddress = true;
    });
  }
}
