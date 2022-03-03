import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/my_widget/text_field.dart';
import 'package:tele_tip/view/home/home_viewmodel.dart';
import 'package:tele_tip/view/search/search_page.dart';
import 'package:tele_tip/view/search/search_viewmodel.dart';

class HomePage extends StatefulWidget {
  final bool isItDoctor;
  const HomePage({Key? key, this.isItDoctor = false}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tcController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  PageController pageController = PageController();

  List<String> searchTitle = [
    " UZMANLIK ALANINA GÖRE ARA",
    " ANA DALA GÖRE ARA",
    " DOKTOR ADINA GÖRE ARA ",
  ];

  int _selectedIndex = 0;
  var color = const Color(0xE12E183B);
  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
      ),
      body: PageView(
        controller: pageController,
        children: [
          buildHomePage(context, homeViewModel, searchTitle),
          buildProfilPage(context),
          ListView.builder(
            itemCount: homeViewModel.userList.length,
            itemBuilder: (context, index) {
              return const Card(
                elevation: 2.0,
                margin: EdgeInsets.all(8.0),
                child: ListTile(
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
        backgroundColor: color,
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
            size: MediaQuery.of(context).size.shortestSide < 600 ? null : 27.0,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 17,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            radius: MediaQuery.of(context).size.shortestSide < 600 ? 8 : 10,
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

  Widget buildHomePage(BuildContext context, HomeViewModel homeViewModel,
      List<String> cardTitle) {
    return ListView(
      children: [
        Container(
          margin: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: color.withAlpha(100),
          ),
          child: Row(
            children: [
              Image.asset("assets/images/woman.png"),
              Expanded(
                child: Text(
                  homeViewModel.user.name!,
                  style: const TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: color.withAlpha(100),
          ),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
            ),
            itemCount: cardTitle.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.all(25.0),
                child: ListTile(
                  title: Column(
                    children: [
                      Text(cardTitle[index]),
                      const Icon(Icons.search, size: 45.0),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        (MaterialPageRoute(
                          builder: (context) => ChangeNotifierProvider(
                            create: (_) => SearchViewModel(),
                            child: SearchPage(
                              title: cardTitle[index],
                              istItProfession: index == 0 ? true : false,
                              istItDoctor: index == 2 ? true : false,
                            ),
                          ),
                        )));
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container buildProfilPage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: color.withAlpha(100),
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
}
