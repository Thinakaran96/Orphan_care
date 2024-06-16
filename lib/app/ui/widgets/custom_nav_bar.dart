import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:orphan_care/app/theme/app_colors.dart';
import 'package:orphan_care/app/theme/icon_images.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CustomNavBar extends StatefulWidget {
  final List<Widget>? screens;
  final bool isTrust;

  const CustomNavBar({super.key, this.screens, required this.isTrust});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      decoration: const NavBarDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, appBarTopColor],
          // You can change these colors
          stops: [0.1, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      handleAndroidBackButtonPress: true,
      // Default is true.
      backgroundColor: Theme.of(context).colorScheme.background,

      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }

  List<Widget> _buildScreens() {
    return [
      ...widget.screens!,
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home_filled, size: 35.sp),
          /*SvgPicture.asset(
            IconImages.homeIcon,
            semanticsLabel: 'homeIcon',
            height: 25.h,
            width: 25.w,
          ),*/
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: textColor,
          onPressed: (context) {
            setState(() {
              controller.index = 0;
            });
          }),
      PersistentBottomNavBarItem(
          icon: widget.isTrust
              ? Icon(FontAwesomeIcons.creditCard, size: 35.sp)
              : Image.asset(
                  IconImages.category,
                  color: controller.index == 1 ? buttonColor : textColor,
                ) /* Icon(
                  Icons.category,
                  size: 35.sp,
                )*/
          ,
          /*Image.asset(
            IconImages.paymentIcon,
          ),*/
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: textColor,
          onPressed: (context) {
            setState(() {
              controller.index = 1;
            });
          }),
      PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person_pin,
            size: 35.sp,
          ),
          activeColorPrimary: buttonColor,
          inactiveColorPrimary: textColor,
          onPressed: (context) {
            setState(() {
              controller.index = 2;
            });
          })
    ];
  }
}
