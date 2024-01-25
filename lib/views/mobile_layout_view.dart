import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vibe/services/auth_service.dart';
import 'package:vibe/views/create_post_view.dart';
import 'package:vibe/views/home_view.dart';
import 'package:vibe/views/profile_view.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  int _page = 0;
  late PageController pageController;
  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {_page = page;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: PageView(
        children: [
          Home(),
          CreatePost(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shadowColor: Colors.orange,
        height: 70,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                navigationTapped(0);
              },
              enableFeedback: false,
              tooltip: 'Home',
              icon: Icon(
                Icons.home,
                size: 40,
                color: (_page == 0) ? Colors.white : Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {
                navigationTapped(1);
              },
              enableFeedback: false,
              tooltip: 'Create Posts',
              icon: Icon(
                Icons.add_circle_outline,
                size: 40,
                color: (_page == 1) ? Colors.white : Colors.white70,
              ),
            ),
            IconButton(
              onPressed: () {
                navigationTapped(2);
              },
              tooltip: 'Profile',
              icon: Icon(
                Icons.account_circle_outlined,
                size: 40,
                color: (_page == 2) ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
