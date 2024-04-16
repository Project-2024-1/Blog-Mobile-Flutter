import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../common/snack_bar_helper/snack_bar_helper.dart';
import '../../provider/home_tab/HomeTabNotifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _showBadge = false;
  late PageController _pageController;
  SharedPreferences? _pref;
  bool _isLoading = false;
  bool _isChekMessage = false;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();


  void _onItemTapped(int index) {
    print('Home Tab Index: $index');

    final homeTabNotifier = context.read<HomeTabNotifier>();
    homeTabNotifier.changeTabIndex(index);
  }

  void _onItemTappedCheckSearch(bool isCheckSearchValue) {
    print('checkSearch : $isCheckSearchValue');
  }

  Widget _buildScreens() {
    final homeTabNotifier = context.watch<HomeTabNotifier>();
    final _currentPageIndex = homeTabNotifier.getTabIndex();

    // final isChekMessageNotifier = context.watch<HomeTabNotifier>();
    // final _isChekMessageNotifier = isChekMessageNotifier.getCheckSearch();

    switch (_currentPageIndex) {
      // case 0:
      // // return MessagePage2();
      //   return HomePageLux();
      // case 1:
      //   return ManualListTwoPage();
      // case 2:
      //   return FriendChatListPage();
      // case 3:
      //   return ChatListPage();
      // case 4:
      //   return SettingPage();
      default:
        return Center(
          child: Text(
            "coming soon",
            style: TextStyle(color: Colors.black),
          ),
        );
    }
  }

  Widget _renderBadge(int _counter) {
    return Text(
      '$_counter',
      style: new TextStyle(
          color: Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.normal
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {

    final homeTabNotifier = context.watch<HomeTabNotifier>();
    int _currentPageIndex = homeTabNotifier.getTabIndex();

    return Container(
        color: Colors.white,
        child: LoadingOverlay(
          isLoading: _isLoading,
          progressIndicator: LoadingAnimationWidget.threeArchedCircle(color: Colors.green, size: 50.0),
          child: SafeArea(
              top: false,
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: Colors.white,
                body: SizedBox.expand(
                  child:  PageView(
                    // controller: _pageController,
                      onPageChanged: (index) {
                        homeTabNotifier.changeTabIndex(index);
                      },
                      children: [
                        _buildScreens()
                      ]
                  ),
                ),

                bottomNavigationBar: BottomNavyBar(
                  selectedIndex: _currentPageIndex,
                  showElevation: true,
                  itemCornerRadius: 24,
                  curve: Curves.easeIn,
                  onItemSelected: _onItemTapped,
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                      icon: Icon(Icons.home),
                      title: Text('Home'),
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Color(0xff97ACB3),
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(Icons.volume_up),
                      title: Text('ManualTwo'),
                      activeColor: Colors.red,
                      inactiveColor: Color(0xff97ACB3),
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(Icons.people),
                      title: Text('Friend'),
                      activeColor: Colors.red,
                      inactiveColor: Color(0xff97ACB3),
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(Icons.message),
                      title: Text(
                        'Messages',
                      ),
                      activeColor: Colors.red,
                      inactiveColor: Color(0xff97ACB3),
                      textAlign: TextAlign.center,
                    ),
                    BottomNavyBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Settings'),
                      activeColor: Colors.blue,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                /*
                bottomNavigationBar:  SizedBox(
                    height: MediaQuery.of(context).size.height *.3/4,
                    child: BottomNavigationBar(
                      currentIndex: _currentPageIndex,
                      items: [
                        BottomNavigationBarItem(
                            icon: Container(
                                child: ImageIcon(AssetImage("assets/img/ic_home_v1_bland.png"), size: 24, color: Color(0xff51595C))
                            ),
                            activeIcon: Container(
                                child: ImageIcon(AssetImage("assets/img/ic_home_v1_dark.png"), size: 24, color: Color(0xff51595C))
                            ),
                            label: ''
                        ),
                        BottomNavigationBarItem(
                            icon: Container(
                                child: ImageIcon(AssetImage("assets/img/ic_home_v2_bland.png"), size: 35, color: Color(0xff51595C))),
                            activeIcon: Container(
                                child: ImageIcon(AssetImage("assets/img/ic_home_v2_dark.png"), size: 35, color: Color(0xff51595C))),
                            label: ''
                        ),
                        BottomNavigationBarItem(
                            icon: Container(
                              child: ImageIcon(AssetImage("assets/img/ic_home_v3_bland.png"), size: 35, color: Color(0xff51595C)),
                            ),
                            activeIcon: Container(
                                child: ImageIcon(AssetImage("assets/img/ic_home_v3_dark.png"), size: 35, color: Color(0xff51595C))
                            ),
                            label: ''
                        ),

                        BottomNavigationBarItem(
                          icon: Container(
                            child: ImageIcon(AssetImage("assets/img/ic_home_v4_bland.png"), size: 24, color: Color(0xff51595C)),
                          ),
                          activeIcon: Container(
                              child: ImageIcon(AssetImage("assets/img/ic_home_v4_dark.png"), size: 24, color: Color(0xff51595C))
                          ),
                          label: ''
                        ),

                        BottomNavigationBarItem(
                            icon: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: ImageIcon(AssetImage("assets/img/ic_home_v5_bland.png"), size: 24, color: Color(0xff51595C)),
                            ),
                            activeIcon: Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: ImageIcon(AssetImage("assets/img/ic_home_v5_dark.png"), size: 24, color: Color(0xff51595C))
                            ),
                            label: ''
                        ),
                      ],
                      selectedFontSize: 10,
                      unselectedFontSize: 10,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      selectedItemColor: Color(0xff51595C),
                      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                      showUnselectedLabels: true,
                      type: BottomNavigationBarType.fixed,
                      onTap: _onItemTapped,
                    )
                )

                 */
              )),
        )
    );
  }


  @override
  void dispose() {
    print('Out Home Page');
    super.dispose();
  }
}

