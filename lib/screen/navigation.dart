import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../src/constant.dart';
import 'account/page.dart';
import 'dashboard/page.dart';
import 'member/page.dart';

class Navigation extends StatefulWidget {
  final String userId;
  const Navigation({Key? key, required this.userId}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  Widget? _child;

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = DashboardPage(userId: widget.userId);
          break;
        case 1:
          _child = const MemberPage();
          break;
        case 2:
          _child = AccountPage(userId: widget.userId);
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

  @override
  void initState() {
    _child = DashboardPage(userId: widget.userId);
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        icons: [
          FluidNavBarIcon(
              icon: Icons.home,
              backgroundColor: Colors.white,
              extras: {"label": "Home"}),
          FluidNavBarIcon(
              icon: Icons.account_circle,
              backgroundColor: Colors.white,
              extras: {"label": "Satker"}),
          FluidNavBarIcon(
              icon: Icons.settings,
              backgroundColor: Colors.white,
              extras: {"label": "Account"}),
        ],
        onChange: _handleNavigationChange,
        style: const FluidNavBarStyle(
            iconSelectedForegroundColor: clrPrimary,
            iconUnselectedForegroundColor: Colors.black54),
        scaleFactor: 1.5,
        defaultIndex: 0,
        itemBuilder: (icon, item) => Semantics(
          label: icon.extras!["label"],
          child: item,
        ),
      ),
    );
  }
}
