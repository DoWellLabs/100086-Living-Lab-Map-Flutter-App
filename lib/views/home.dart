import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_labs_maps_api/utils/colors.dart';
import 'package:living_labs_maps_api/utils/utils.dart';

/// Created by Patrice Mulindi email(mulindipatrice00@gmail.com) on 6.06.2023.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController pageController;
  int _page = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
      ),
      bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(0),
                icon: Icon(
                  Icons.nearby_error_rounded,
                  color: _page == 0 ? purpleColor : secondaryColor,
                ),
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(1),
                icon: Icon(
                  Icons.place,
                  color: _page == 1 ? purpleColor : secondaryColor,
                ),
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(2),
                icon: Icon(
                  Icons.cloud_upload,
                  color: _page == 2 ? purpleColor : secondaryColor,
                ),
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () => navigationTapped(3),
                icon: Icon(
                  Icons.verified_user,
                  color: _page == 3 ? purpleColor : secondaryColor,
                ),
              ),
              label: '',
              backgroundColor: primaryColor,
            ),
          ]),
    );
  }
}
