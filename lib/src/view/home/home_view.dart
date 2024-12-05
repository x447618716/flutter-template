import 'package:flutter/material.dart';
import 'package:flutter_template/src/app_route.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.child});
  final Widget child;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: [
          NavigationDestination(
            icon: const Icon(
              Icons.location_on_outlined,
            ),
            selectedIcon: Icon(
              Icons.location_on_outlined,
              color: context.primaryColor,
            ),
            label: context.localization.navLocation,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.widgets_outlined,
            ),
            selectedIcon: Icon(
              Icons.ballot_outlined,
              color: context.primaryColor,
            ),
            label: context.localization.navControl,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.message_outlined,
            ),
            selectedIcon: Icon(
              Icons.message_outlined,
              color: context.primaryColor,
            ),
            label: context.localization.navMessage,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.person_outline_rounded,
            ),
            selectedIcon: Icon(
              Icons.person_outline_rounded,
              color: context.primaryColor,
            ),
            label: context.localization.navSettings,
          ),
        ],
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
          switch (value) {
            case 0:
              LoactionRoute().go(context);
              break;
            case 1:
              ControlRoute().go(context);
              break;
            case 2:
              MessageRoute().go(context);
              break;
            case 3:
              SettingsRoute().go(context);
              break;
          }
        },
      ),
    );
  }
}
