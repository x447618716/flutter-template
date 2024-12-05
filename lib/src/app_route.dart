import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_template/src/application.dart';
import 'package:flutter_template/src/data/api.dart';
import 'package:flutter_template/src/data/json/message.dart';
import 'package:flutter_template/src/view/control/alarm-settings/alarm_settings_view.dart';
import 'package:flutter_template/src/view/control/control_view.dart';
import 'package:flutter_template/src/view/control/device-details/device_details_edit_view.dart';
import 'package:flutter_template/src/view/control/device-details/device_details_view.dart';
import 'package:flutter_template/src/view/control/electronic-fence/electronic_fence_edit_view.dart';
import 'package:flutter_template/src/view/control/electronic-fence/electronic_fence_view.dart';
import 'package:flutter_template/src/view/control/help-and-feedback/add_feedback_view.dart';
import 'package:flutter_template/src/view/control/help-and-feedback/help_and_feedback_view.dart';
import 'package:flutter_template/src/view/control/history/history_trace_next_view.dart';
import 'package:flutter_template/src/view/control/history/history_trace_view.dart';
import 'package:flutter_template/src/view/control/instruction-recording/instruction_recording_view.dart';
import 'package:flutter_template/src/view/control/more/control_more_view.dart';
import 'package:flutter_template/src/view/control/on-off/on_off_view.dart';
import 'package:flutter_template/src/view/control/trace/trace_mode_view.dart';
import 'package:flutter_template/src/view/control/travel-report/travel_report_view.dart';
import 'package:flutter_template/src/view/control/troubleshooting/troubleshooting_view.dart';
import 'package:flutter_template/src/view/control/voice-controlled-anti-theft/voice_controlled_anti_theft_view.dart';
import 'package:flutter_template/src/view/devices/add/device_add_view.dart';
import 'package:flutter_template/src/view/devices/devices_view.dart';
import 'package:flutter_template/src/view/home/home_view.dart';
import 'package:flutter_template/src/view/location/location_view.dart';
import 'package:flutter_template/src/view/login/login_view.dart';
import 'package:flutter_template/src/view/mdview/md_view.dart';
import 'package:flutter_template/src/view/message/detail/message_detail_view.dart';
import 'package:flutter_template/src/view/message/message_view.dart';
import 'package:flutter_template/src/view/settings/alarm/alarm_set_view.dart';
import 'package:flutter_template/src/view/settings/settings_view.dart';
import 'package:flutter_template/src/view/settings/share/share_edit_view.dart';
import 'package:flutter_template/src/view/settings/share/share_view.dart';

part 'app_route.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

BuildContext currentContext() => rootNavigatorKey.currentState!.context;

final routerConfig = GoRouter(
  routes: $appRoutes,
  initialLocation: "/loaction",
  navigatorKey: rootNavigatorKey,
  redirect: (context, state) {
    return Api.instance.isTokenExpired().then((value) {
      if (value) {
        return LoginRoute().location;
      } else {
        if (state.matchedLocation != DevicesRoute().location &&
            state.matchedLocation != DeviceAddRoute().location &&
            !context.deviceControllerRead.hasDevices) {
          return DevicesRoute().location;
        }
      }
      return null;
    });
  },
);

@TypedShellRoute<HomeShellRoute>(
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<LoactionRoute>(
      path: '/loaction',
      name: 'loaction',
    ),
    TypedGoRoute<ControlRoute>(
      path: '/control',
      name: 'control',
      routes: [
        TypedGoRoute<ControlMoreRoute>(path: 'more', name: 'more', routes: [
          TypedGoRoute<HelpAndFeedbackRoute>(
              path: 'help-and-feedback',
              name: 'help-and-feedback',
              routes: [
                TypedGoRoute<AddFeedbackRoute>(
                  path: 'add_feedback_view',
                  name: 'add_feedback_view',
                ),
              ]),
          TypedGoRoute<TravelReportRoute>(
            path: 'travel-report',
            name: 'travel-report',
          ),
          TypedGoRoute<AlarmSettingsRoute>(
            path: 'alarm-settings',
            name: 'alarm-settings',
          ),
          TypedGoRoute<InstructionRecordingRoute>(
            path: 'instruction-recording',
            name: 'instruction-recording',
          ),
          TypedGoRoute<DeviceDetailsRoute>(
              path: 'device_details',
              name: 'device_details',
              routes: [
                TypedGoRoute<DeviceDetailsEditRoute>(
                  path: 'device_details_edit',
                  name: 'device_details_edit',
                ),
              ]),
          TypedGoRoute<VoiceControlledAntiTheftRoute>(
            path: 'voice_controlled_anti_theft_view',
            name: 'voice_controlled_anti_theft_view',
          ),
        ]),
        TypedGoRoute<TraceModeRoute>(
          path: 'trace_mode',
          name: 'trace_mode',
        ),
        TypedGoRoute<HistoryTraceRoute>(
            path: 'history_trace',
            name: 'history_trace',
            routes: [
              TypedGoRoute<HistoryTraceNextRoute>(
                path: 'history_trace_next',
                name: 'history_trace_next',
              ),
            ]),
        TypedGoRoute<OnOffRoute>(
          path: 'on_off',
          name: 'on_off',
        ),
        TypedGoRoute<ElectronicFenceRoute>(
            path: 'electronic_fence_view',
            name: 'electronic_fence_view',
            routes: [
              TypedGoRoute<ElectronicFenceEditRoute>(
                path: 'electronic_fence_edit_view',
                name: 'electronic_fence_edit_view',
              ),
            ]),
        TypedGoRoute<TroubleshootingRoute>(
          path: 'troubleshooting',
          name: 'troubleshooting',
        ),
      ],
    ),
    TypedGoRoute<MessageRoute>(
      path: '/message',
      name: 'message',
      routes: [
        TypedGoRoute<MessageDetailRoute>(
          path: 'detail',
          name: 'detail',
        ),
      ],
    ),
    TypedGoRoute<SettingsRoute>(
      path: '/settings',
      name: 'settings',
      routes: [
        TypedGoRoute<MdViewRoute>(
          path: 'mdview',
          name: 'mdview',
        ),
        TypedGoRoute<AlarmSetRoute>(
          path: 'alarmset',
          name: 'alarmset',
        ),
        TypedGoRoute<ShareRoute>(path: 'share', name: 'share', routes: [
          TypedGoRoute<ShareEditRoute>(
            path: 'share_edit',
            name: 'share_edit',
          )
        ]),
      ],
    ),
  ],
)
class HomeShellRoute extends ShellRouteData {
  HomeShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) =>
      HomeView(child: navigator);
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

class SettingsRoute extends GoRouteData {
  SettingsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: const SettingsView(),
        key: state.pageKey,
      );
}

class MdViewRoute extends GoRouteData {
  MdViewRoute(this.file);

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  final String file;

  @override
  Widget build(BuildContext context, GoRouterState state) => MdView(file: file);
}

class AlarmSetRoute extends GoRouteData {
  AlarmSetRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AlarmSetView();
}

class LoactionRoute extends GoRouteData {
  LoactionRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: const LocationView(),
        key: state.pageKey,
      );
}

class ControlRoute extends GoRouteData {
  ControlRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: const ControlView(),
        key: state.pageKey,
      );
}

class MessageRoute extends GoRouteData {
  MessageRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(
        child: const MessageView(),
        key: state.pageKey,
      );
}

@TypedGoRoute<DevicesRoute>(
    path: '/devices',
    name: 'devices',
    routes: <TypedGoRoute<GoRouteData>>[
      TypedGoRoute<DeviceAddRoute>(
        path: 'add',
        name: 'add',
      )
    ]
)
class DevicesRoute extends GoRouteData {
  DevicesRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DevicesView();
}

class DeviceAddRoute extends GoRouteData {
  DeviceAddRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeviceAddView();
}

class ControlMoreRoute extends GoRouteData {
  ControlMoreRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ControlMoreView();
}

class MessageDetailRoute extends GoRouteData {
  MessageDetailRoute(this.$extra);

  final Message $extra;

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      MessageDetailView(message: $extra);
}

class TraceModeRoute extends GoRouteData {
  TraceModeRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TraceModeView();
}

class HistoryTraceRoute extends GoRouteData {
  HistoryTraceRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HistoryTraceView();
}

class HistoryTraceNextRoute extends GoRouteData {
  HistoryTraceNextRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HistoryTraceNextView();
}

class OnOffRoute extends GoRouteData {
  OnOffRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const OnOffView();
}

class TroubleshootingRoute extends GoRouteData {
  TroubleshootingRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TroubleshootingView();
}

class DeviceDetailsRoute extends GoRouteData {
  DeviceDetailsRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeviceDetailsView();
}

class DeviceDetailsEditRoute extends GoRouteData {
  DeviceDetailsEditRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const DeviceDetailsEditView();
}

class VoiceControlledAntiTheftRoute extends GoRouteData {
  VoiceControlledAntiTheftRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const VoiceControlledAntiTheftView();
}

class InstructionRecordingRoute extends GoRouteData {
  InstructionRecordingRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InstructionRecordingView();
}

class AlarmSettingsRoute extends GoRouteData {
  AlarmSettingsRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AlarmSettingsView();
}

class TravelReportRoute extends GoRouteData {
  TravelReportRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TravelReportView();
}

class HelpAndFeedbackRoute extends GoRouteData {
  HelpAndFeedbackRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const HelpAndFeedbackView();
}

class AddFeedbackRoute extends GoRouteData {
  AddFeedbackRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AddFeedbackView();
}

class ElectronicFenceRoute extends GoRouteData {
  ElectronicFenceRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ElectronicFenceView();
}

class ElectronicFenceEditRoute extends GoRouteData {
  ElectronicFenceEditRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ElectronicFenceEditView();
}

class ShareRoute extends GoRouteData {
  ShareRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) => const ShareView();
}

class ShareEditRoute extends GoRouteData {
  ShareEditRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ShareEditView();
}
