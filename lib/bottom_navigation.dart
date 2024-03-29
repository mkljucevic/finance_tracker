import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/screens/add_trans_screen.dart';
import 'package:finance_tracker/screens/dashboard_screen.dart';
import 'package:finance_tracker/screens/records_screen.dart';
import 'package:finance_tracker/screens/settings_screen.dart';
import 'package:finance_tracker/screens/statistics_screen_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late PageController pageController;
  int _page = 0;

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  void initState() {
    addData();
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;
    bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom == 0;

    return Scaffold(
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView(
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              controller: pageController,
              children: const [
                DashboardScreen(),
                RecordsScreen(),
                StatisticsScreenNew(),
                SettingsScreen(),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: keyboardOpen
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddTransScreen(selectedIndex: 0)));
              },
              backgroundColor: primaryColor,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(
                  _page == 0
                      ? CupertinoIcons.square_grid_2x2_fill
                      : CupertinoIcons.square_grid_2x2,
                  size: 25,
                  color: _page == 0 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(0);
                    _page = 0;
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(
                  size: 25,
                  _page == 1
                      ? CupertinoIcons.chart_bar_fill
                      : CupertinoIcons.chart_bar,
                  color: _page == 1 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(1);
                    _page = 1;
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(left: 28.0),
                icon: Icon(
                  _page == 2
                      ? CupertinoIcons.graph_circle_fill
                      : CupertinoIcons.graph_circle,
                  color: _page == 2 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(2);
                    _page = 2;
                  });
                },
              ),
              IconButton(
                iconSize: 30.0,
                padding: const EdgeInsets.only(right: 28.0),
                icon: Icon(
                  _page == 3
                      ? CupertinoIcons.gear_alt_fill
                      : CupertinoIcons.gear_alt,
                  size: 25,
                  color: _page == 3 ? primaryColor : Colors.grey[400],
                ),
                onPressed: () {
                  setState(() {
                    pageController.jumpToPage(3);
                    _page = 3;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
