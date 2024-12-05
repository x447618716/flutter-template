// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_route.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeShellRoute,
      $loginRoute,
      $devicesRoute,
    ];

RouteBase get $homeShellRoute => ShellRouteData.$route(
      navigatorKey: HomeShellRoute.$navigatorKey,
      factory: $HomeShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/loaction',
          name: 'loaction',
          factory: $LoactionRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/control',
          name: 'control',
          factory: $ControlRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'more',
              name: 'more',
              parentNavigatorKey: ControlMoreRoute.$parentNavigatorKey,
              factory: $ControlMoreRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'help-and-feedback',
                  name: 'help-and-feedback',
                  parentNavigatorKey: HelpAndFeedbackRoute.$parentNavigatorKey,
                  factory: $HelpAndFeedbackRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'add_feedback_view',
                      name: 'add_feedback_view',
                      parentNavigatorKey: AddFeedbackRoute.$parentNavigatorKey,
                      factory: $AddFeedbackRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'travel-report',
                  name: 'travel-report',
                  parentNavigatorKey: TravelReportRoute.$parentNavigatorKey,
                  factory: $TravelReportRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'alarm-settings',
                  name: 'alarm-settings',
                  parentNavigatorKey: AlarmSettingsRoute.$parentNavigatorKey,
                  factory: $AlarmSettingsRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'instruction-recording',
                  name: 'instruction-recording',
                  parentNavigatorKey:
                      InstructionRecordingRoute.$parentNavigatorKey,
                  factory: $InstructionRecordingRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: 'device_details',
                  name: 'device_details',
                  parentNavigatorKey: DeviceDetailsRoute.$parentNavigatorKey,
                  factory: $DeviceDetailsRouteExtension._fromState,
                  routes: [
                    GoRouteData.$route(
                      path: 'device_details_edit',
                      name: 'device_details_edit',
                      parentNavigatorKey:
                          DeviceDetailsEditRoute.$parentNavigatorKey,
                      factory: $DeviceDetailsEditRouteExtension._fromState,
                    ),
                  ],
                ),
                GoRouteData.$route(
                  path: 'voice_controlled_anti_theft_view',
                  name: 'voice_controlled_anti_theft_view',
                  parentNavigatorKey:
                      VoiceControlledAntiTheftRoute.$parentNavigatorKey,
                  factory: $VoiceControlledAntiTheftRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'trace_mode',
              name: 'trace_mode',
              parentNavigatorKey: TraceModeRoute.$parentNavigatorKey,
              factory: $TraceModeRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'history_trace',
              name: 'history_trace',
              parentNavigatorKey: HistoryTraceRoute.$parentNavigatorKey,
              factory: $HistoryTraceRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'history_trace_next',
                  name: 'history_trace_next',
                  parentNavigatorKey: HistoryTraceNextRoute.$parentNavigatorKey,
                  factory: $HistoryTraceNextRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'on_off',
              name: 'on_off',
              parentNavigatorKey: OnOffRoute.$parentNavigatorKey,
              factory: $OnOffRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'electronic_fence_view',
              name: 'electronic_fence_view',
              parentNavigatorKey: ElectronicFenceRoute.$parentNavigatorKey,
              factory: $ElectronicFenceRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'electronic_fence_edit_view',
                  name: 'electronic_fence_edit_view',
                  parentNavigatorKey:
                      ElectronicFenceEditRoute.$parentNavigatorKey,
                  factory: $ElectronicFenceEditRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'troubleshooting',
              name: 'troubleshooting',
              parentNavigatorKey: TroubleshootingRoute.$parentNavigatorKey,
              factory: $TroubleshootingRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/message',
          name: 'message',
          factory: $MessageRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'detail',
              name: 'detail',
              parentNavigatorKey: MessageDetailRoute.$parentNavigatorKey,
              factory: $MessageDetailRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/settings',
          name: 'settings',
          factory: $SettingsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'mdview',
              name: 'mdview',
              parentNavigatorKey: MdViewRoute.$parentNavigatorKey,
              factory: $MdViewRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'alarmset',
              name: 'alarmset',
              parentNavigatorKey: AlarmSetRoute.$parentNavigatorKey,
              factory: $AlarmSetRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: 'share',
              name: 'share',
              parentNavigatorKey: ShareRoute.$parentNavigatorKey,
              factory: $ShareRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'share_edit',
                  name: 'share_edit',
                  parentNavigatorKey: ShareEditRoute.$parentNavigatorKey,
                  factory: $ShareEditRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) => HomeShellRoute();
}

extension $LoactionRouteExtension on LoactionRoute {
  static LoactionRoute _fromState(GoRouterState state) => LoactionRoute();

  String get location => GoRouteData.$location(
        '/loaction',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ControlRouteExtension on ControlRoute {
  static ControlRoute _fromState(GoRouterState state) => ControlRoute();

  String get location => GoRouteData.$location(
        '/control',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ControlMoreRouteExtension on ControlMoreRoute {
  static ControlMoreRoute _fromState(GoRouterState state) => ControlMoreRoute();

  String get location => GoRouteData.$location(
        '/control/more',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HelpAndFeedbackRouteExtension on HelpAndFeedbackRoute {
  static HelpAndFeedbackRoute _fromState(GoRouterState state) =>
      HelpAndFeedbackRoute();

  String get location => GoRouteData.$location(
        '/control/more/help-and-feedback',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AddFeedbackRouteExtension on AddFeedbackRoute {
  static AddFeedbackRoute _fromState(GoRouterState state) => AddFeedbackRoute();

  String get location => GoRouteData.$location(
        '/control/more/help-and-feedback/add_feedback_view',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TravelReportRouteExtension on TravelReportRoute {
  static TravelReportRoute _fromState(GoRouterState state) =>
      TravelReportRoute();

  String get location => GoRouteData.$location(
        '/control/more/travel-report',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AlarmSettingsRouteExtension on AlarmSettingsRoute {
  static AlarmSettingsRoute _fromState(GoRouterState state) =>
      AlarmSettingsRoute();

  String get location => GoRouteData.$location(
        '/control/more/alarm-settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InstructionRecordingRouteExtension on InstructionRecordingRoute {
  static InstructionRecordingRoute _fromState(GoRouterState state) =>
      InstructionRecordingRoute();

  String get location => GoRouteData.$location(
        '/control/more/instruction-recording',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeviceDetailsRouteExtension on DeviceDetailsRoute {
  static DeviceDetailsRoute _fromState(GoRouterState state) =>
      DeviceDetailsRoute();

  String get location => GoRouteData.$location(
        '/control/more/device_details',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeviceDetailsEditRouteExtension on DeviceDetailsEditRoute {
  static DeviceDetailsEditRoute _fromState(GoRouterState state) =>
      DeviceDetailsEditRoute();

  String get location => GoRouteData.$location(
        '/control/more/device_details/device_details_edit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $VoiceControlledAntiTheftRouteExtension
    on VoiceControlledAntiTheftRoute {
  static VoiceControlledAntiTheftRoute _fromState(GoRouterState state) =>
      VoiceControlledAntiTheftRoute();

  String get location => GoRouteData.$location(
        '/control/more/voice_controlled_anti_theft_view',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TraceModeRouteExtension on TraceModeRoute {
  static TraceModeRoute _fromState(GoRouterState state) => TraceModeRoute();

  String get location => GoRouteData.$location(
        '/control/trace_mode',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HistoryTraceRouteExtension on HistoryTraceRoute {
  static HistoryTraceRoute _fromState(GoRouterState state) =>
      HistoryTraceRoute();

  String get location => GoRouteData.$location(
        '/control/history_trace',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $HistoryTraceNextRouteExtension on HistoryTraceNextRoute {
  static HistoryTraceNextRoute _fromState(GoRouterState state) =>
      HistoryTraceNextRoute();

  String get location => GoRouteData.$location(
        '/control/history_trace/history_trace_next',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OnOffRouteExtension on OnOffRoute {
  static OnOffRoute _fromState(GoRouterState state) => OnOffRoute();

  String get location => GoRouteData.$location(
        '/control/on_off',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ElectronicFenceRouteExtension on ElectronicFenceRoute {
  static ElectronicFenceRoute _fromState(GoRouterState state) =>
      ElectronicFenceRoute();

  String get location => GoRouteData.$location(
        '/control/electronic_fence_view',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ElectronicFenceEditRouteExtension on ElectronicFenceEditRoute {
  static ElectronicFenceEditRoute _fromState(GoRouterState state) =>
      ElectronicFenceEditRoute();

  String get location => GoRouteData.$location(
        '/control/electronic_fence_view/electronic_fence_edit_view',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $TroubleshootingRouteExtension on TroubleshootingRoute {
  static TroubleshootingRoute _fromState(GoRouterState state) =>
      TroubleshootingRoute();

  String get location => GoRouteData.$location(
        '/control/troubleshooting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MessageRouteExtension on MessageRoute {
  static MessageRoute _fromState(GoRouterState state) => MessageRoute();

  String get location => GoRouteData.$location(
        '/message',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MessageDetailRouteExtension on MessageDetailRoute {
  static MessageDetailRoute _fromState(GoRouterState state) =>
      MessageDetailRoute(
        state.extra as Message,
      );

  String get location => GoRouteData.$location(
        '/message/detail',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

extension $SettingsRouteExtension on SettingsRoute {
  static SettingsRoute _fromState(GoRouterState state) => SettingsRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $MdViewRouteExtension on MdViewRoute {
  static MdViewRoute _fromState(GoRouterState state) => MdViewRoute(
        state.uri.queryParameters['file']!,
      );

  String get location => GoRouteData.$location(
        '/settings/mdview',
        queryParams: {
          'file': file,
        },
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AlarmSetRouteExtension on AlarmSetRoute {
  static AlarmSetRoute _fromState(GoRouterState state) => AlarmSetRoute();

  String get location => GoRouteData.$location(
        '/settings/alarmset',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ShareRouteExtension on ShareRoute {
  static ShareRoute _fromState(GoRouterState state) => ShareRoute();

  String get location => GoRouteData.$location(
        '/settings/share',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ShareEditRouteExtension on ShareEditRoute {
  static ShareEditRoute _fromState(GoRouterState state) => ShareEditRoute();

  String get location => GoRouteData.$location(
        '/settings/share/share_edit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $devicesRoute => GoRouteData.$route(
      path: '/devices',
      name: 'devices',
      parentNavigatorKey: DevicesRoute.$parentNavigatorKey,
      factory: $DevicesRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'add',
          name: 'add',
          parentNavigatorKey: DeviceAddRoute.$parentNavigatorKey,
          factory: $DeviceAddRouteExtension._fromState,
        ),
      ],
    );

extension $DevicesRouteExtension on DevicesRoute {
  static DevicesRoute _fromState(GoRouterState state) => DevicesRoute();

  String get location => GoRouteData.$location(
        '/devices',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DeviceAddRouteExtension on DeviceAddRoute {
  static DeviceAddRoute _fromState(GoRouterState state) => DeviceAddRoute();

  String get location => GoRouteData.$location(
        '/devices/add',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
