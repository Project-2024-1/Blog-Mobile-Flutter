import 'package:flutter/material.dart';

class DynamicTabBar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> views;
  const DynamicTabBar({required this.tabs, required this.views});

  @override
  _DynamicTabBarState createState() => _DynamicTabBarState();
}

class _DynamicTabBarState extends State<DynamicTabBar> {
  late List<Tab> _tabs;
  late List<Widget> _views;

  @override
  void initState() {
    super.initState();
    _tabs = widget.tabs.map((e) => Tab(child: Text(e))).toList();
    _views = widget.views;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          children: _views,
        ),
      ),
    );
  }
}

/*

    int intTabIndex = 0;
    intTabIndex = tabName.length;

    int intControler = 0;

    List<String> tabs = ['Tab 1', 'Tab 2', 'Tab 3'];
    int tabIndex = intTabIndex;

    if (tabIndex >= 0 && tabIndex < tabName.length) {
      // Access the element at the specified index
      String selectedTab = tabName[tabIndex];
      // intControler = selectedTab;
      print(selectedTab);
    } else {
      print('Invalid index: $tabIndex');
    }

    List<Widget> views = tabName.map((tab) => Center(child: Text(tab))).toList();
    Widget listAddScreen = Container(child: Text('abc'));


 */