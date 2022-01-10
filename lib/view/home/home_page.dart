import 'package:flutter/material.dart';
import 'package:tele_tip/core/extension/context_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xdf7d2ac7),
        actions: [
          Padding(
            padding: context.paddingLow,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    size: context.shortestSide < 600 ? null : 27.0,
                  ),
                ),
                Positioned(
                  right: 7,
                  top: 2,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: context.shortestSide < 600 ? 8 : 10,
                    child: const Text(
                      "1",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: [
          Column(
            children: [
              Container(
                margin: context.paddingLow,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0x54996EE8),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/images/woman.png"),
                    const Text(
                      "Melike Gümüştekin",
                    ),
                  ],
                ),
              ),
              Container(
                margin: context.paddingLow,
                width: context.width,
                height: context.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: const Color(0x54996EE8),
                ),
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container();
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: context.paddingLow,
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color(0x54996EE8),
            ),
            child: Column(
              children: [
                Image.asset("assets/images/woman.png"),
                const Text(
                  "Melike Gümüştekin",
                ),
              ],
            ),
          ),
        ],
        onPageChanged: onTap,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xdf7d2ac7),
        selectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "AnaSayfa"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
        currentIndex: _selectedIndex,
        onTap: onTap,
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }
}
