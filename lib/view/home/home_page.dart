import 'package:flutter/material.dart';
import 'package:tele_tip/core/components/text_field.dart';
import 'package:tele_tip/core/extension/context_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tcController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  PageController pageController = PageController();

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xdf7d2ac7),
        // actions: [
        //   Padding(
        //     padding: context.paddingLow,
        //     child: Stack(
        //       alignment: Alignment.topRight,
        //       children: [
        //         IconButton(
        //           onPressed: () {},
        //           icon: Icon(
        //             Icons.notifications,
        //             size: context.shortestSide < 600 ? null : 27.0,
        //           ),
        //         ),
        //         Positioned(
        //           right: 7,
        //           top: 2,
        //           child: CircleAvatar(
        //             backgroundColor: Colors.red,
        //             radius: context.shortestSide < 600 ? 8 : 10,
        //             child: const Text(
        //               "1",
        //               style: TextStyle(
        //                 fontSize: 12,
        //                 color: Colors.white,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
        bottom: _selectedIndex == 0
            ? PreferredSize(
                child: searchWidget(),
                preferredSize: const Size.fromHeight(65.0))
            : null,
      ),
      body: PageView(
        controller: pageController,
        children: [
          buildHomePage(context),
          buildProfilPage(context),
          ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 2.0,
                margin: context.paddingLow,
                child: const ListTile(
                  minVerticalPadding: 25.0,
                  leading: CircleAvatar(
                    radius: 25.0,
                    child: Icon(Icons.person),
                  ),
                  title: Text("Dr. Doktor adı"),
                  subtitle: Text("mesaj içeriği"),
                ),
              );
            },
          )
        ],
        onPageChanged: onTap,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xdf7d2ac7),
        selectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "AnaSayfa"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(
              icon: buildMessagePageIcon(context), label: "Mesajlar"),
        ],
        currentIndex: _selectedIndex,
        onTap: onTap,
      ),
    );
  }

  Stack buildMessagePageIcon(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            Icons.message,
            size: context.shortestSide < 600 ? null : 27.0,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 17,
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
    );
  }

  Widget buildHomePage(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: context.paddingLow,
          width: context.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color(0x54996EE8),
          ),
          child: Row(
            children: [
              Image.asset("assets/images/woman.png"),
              const Expanded(
                child: Text(
                  "Melike Gümüştekin",
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
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
    );
  }

  Container buildProfilPage(BuildContext context) {
    return Container(
      margin: context.paddingLow,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: const Color(0x54996EE8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Image.asset("assets/images/woman.png"),
                const Text(
                  "Melike Gümüştekin",
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                MyTextField(
                  nameController,
                  icon: Icons.person,
                  labelText: "Melike Gümüştekin",
                  text: "ad Soyad : ",
                ),
                MyTextField(
                  emailController,
                  icon: Icons.vpn_key,
                  labelText: "melike@mlk.com",
                  text: "email : ",
                ),
                MyTextField(
                  birthdayController,
                  icon: Icons.vpn_key,
                  labelText: "01/01/2000",
                  text: "dogum tarihi : ",
                ),
                MyTextField(
                  tcController,
                  icon: Icons.vpn_key,
                  labelText: "123456789",
                  text: "tc : ",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }

  searchWidget() {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 70.0,
      child: Container(
        width: MediaQuery.of(context).size.width - 40.0,
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: TextField(
                  onChanged: (value) {
                    // startSearching(value);
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: "randevu ara..."),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
