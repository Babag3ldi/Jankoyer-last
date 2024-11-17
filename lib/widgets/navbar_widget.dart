// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jankoyer/provider/video_controller_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../const/colors.dart';
import '../provider/navbar_provider.dart';
import '../screens/last_home_page.dart';
import '../screens/media.dart';
import '../screens/news_page.dart';
import '../screens/others_pages.dart';
import '../screens/super_liga_pages.dart';

class NavBarHome extends StatefulWidget {
  final int index;
  const NavBarHome({super.key, this.index = 0});

  @override
  State<NavBarHome> createState() => _NavBarHomeState();
}

class _NavBarHomeState extends State<NavBarHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PersistentTabController _controller;
  int selectedIndex = 0;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: widget.index);

    super.initState();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_outlined),
          inactiveIcon: const Icon(Icons.home_outlined),
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: Colors.white,
          onPressed:  
          // (_controller.index != 0) ?  null :
           (p0)  {
          // if (selectedIndex == 0) {
            
            print(_controller.index);
              pushNewScreen(
                context,
                screen: const NavBarHome(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.fade,
              );
              // return;
            // }
            // return null;
            
          },
          title: 'Baş Sahypa'),
      PersistentBottomNavBarItem(
          icon:
              SvgPicture.asset('assets/svg/new.svg', color: AppColors.primary),
          inactiveIcon: SvgPicture.asset('assets/svg/new.svg'),
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: Colors.white,
          title: 'Täzelikler'),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/svg/media.svg',
              color: AppColors.primary),
          inactiveIcon: SvgPicture.asset('assets/svg/media.svg'),
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: Colors.white,
          title: 'Media'),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/svg/trophy.svg',
              color: AppColors.primary),
          inactiveIcon: SvgPicture.asset('assets/svg/trophy.svg'),
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: Colors.white,
          title: 'Netijeler'),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.more_horiz),
          inactiveIcon: const Icon(Icons.more_horiz),
          activeColorPrimary: AppColors.primary,
          inactiveColorPrimary: Colors.white,
          title: 'Başgalar'),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        key: _scaffoldKey,
        body: PersistentTabView(context,
            controller: _controller,
            screens: const [
              LastHomePage(),
              NewsPage(),
              MediaPage(),
              SuperLigaPages(),
              OthersPages(),
            ],
            items: _navBarsItems(),
            confineInSafeArea: true,
            onItemSelected: ((value) {
              print("item Selected=$value");
                 Provider.of<VideoControllerProvider>(context, listen: false).disposeVideo();
            }),
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            navBarHeight: 70,
            hideNavigationBarWhenKeyboardShows: true,
            margin: const EdgeInsets.all(0.0),
            popActionScreens: PopActionScreensType.once,
            //   bottomScreenMargin: 0.0, onWillPop: (context) async {
            //   return await showDialog(
            //       context: context!,
            //       barrierColor: Colors.black38,
            //       builder: (BuildContext context) => CustomAlertDialog(
            //             title: AppLocalizations.of(context)!.tassyklamak,
            //             content: AppLocalizations.of(context)!.sizCyndanamUlgamdan,
            //             onConfirm: () {
            //               Navigator.of(exit(0));
            //             },
            //           ));
            // },
            hideNavigationBar:
                Provider.of<NavBarProvider>(context).showBottomNav,
            decoration: NavBarDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 1,
                      spreadRadius: 0)
                ],
                colorBehindNavBar: const Color(0xffF4F4F4),
                borderRadius: BorderRadius.circular(0.0)),
            backgroundColor: AppColors.background,
            popAllScreensOnTapOfSelectedTab: true,
            itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 400), curve: Curves.ease),
            screenTransitionAnimation: const ScreenTransitionAnimation(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200)),
            navBarStyle: NavBarStyle.style6)); //8
  }
}
