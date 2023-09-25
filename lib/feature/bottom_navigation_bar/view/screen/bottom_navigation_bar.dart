import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vcare_app/core/constants/app_color.dart';
import 'package:vcare_app/core/utilities/cache/secure_storage.dart';
import 'package:vcare_app/feature/home_screen/business_logic/home_cubit/home_cubit.dart';
import 'package:vcare_app/feature/home_screen/date/repo/home_repo.dart';

import '../../../../core/constants/text_style.dart';
import '../../../../core/widgets/drawer.dart';
import '../../../../injection.dart';
import '../../../home_screen/presentation/view/screen/home_screen.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _bottomNavbarController = PersistentTabController();

  List<Widget> _buildScreens() {
    return [
      blocProviderHomeScreen(),
      Container(),
      Container(),
      Container(),
      Container(),
    ];
  }

  Widget blocProviderHomeScreen() {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(getIt.get<HomeRepo>() , getIt.get<SecureStorage>()),
      child: const HomeScreen(),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        title: 'Doctors',
        icon: const ImageIcon(AssetImage('assets/Icons/icon_doctor.png')),
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        title: ("Search"),
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.access_time_filled),
        title: ("History"),
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Account"),
        activeColorPrimary: kMainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  PersistentTabView _persistentTabView() {
    return PersistentTabView(
      context,
      controller: _bottomNavbarController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'VCare',
          style: Style.textStyle20,
        ),
      ),
      drawer: const AppDrawer(),
      body: _persistentTabView(),
    );
  }
}
