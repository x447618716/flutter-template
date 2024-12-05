import 'package:flutter/material.dart';
import 'package:flutter_template/src/data/json/alarm_param.dart';
import 'package:flutter_template/src/theme.dart';

class AlarmItem extends StatelessWidget {
  const AlarmItem({
    super.key,
    this.onChanged,
    required this.data,
  });

  final AlarmParam data;
  final Function(AlarmParam)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        data.name,
        style: context.titleMedium,
      ),
      trailing: Switch(
        onChanged: _onChanged,
        value: data.value,
      ),
    );
  }

  void _onChanged(bool value) {
    data.value = value;
    onChanged?.call(data);
  }
}
