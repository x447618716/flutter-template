import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/components/empty.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';

class InstructionRecordingView extends StatefulWidget{
  const InstructionRecordingView({super.key});

  @override
  State<StatefulWidget> createState() =>_InstructionRecordingViewState();

}

class _InstructionRecordingViewState extends State<InstructionRecordingView>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: context.localization.commandHistory,
     ),
     body: const Empty(),
   );
  }
}