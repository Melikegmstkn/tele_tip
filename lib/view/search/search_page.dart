import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tele_tip/model/doctor_model.dart';
import 'package:tele_tip/model/search_model.dart';
import 'package:tele_tip/view/authentication/viewmodel/login_viewmodel.dart';
import 'package:tele_tip/view/message/message_page.dart';
import 'package:tele_tip/view/search/search_viewmodel.dart';

class SearchPage extends StatefulWidget {
  final String title;
  final bool istItDoctor;
  final bool istItProfession;
  const SearchPage(
      {Key? key,
      required this.title,
      this.istItDoctor = false,
      this.istItProfession = false})
      : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var color = const Color(0xE12E183B);
  Future<List<Doctor>>? docList;

  @override
  Widget build(BuildContext context) {
    final searchViewModel = Provider.of<SearchViewModel>(context);

    TextEditingController _searchController = TextEditingController();
    Future<List<ProfessionSearch>>? proffessionList =
        getSearch(searchViewModel, _searchController);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(widget.title),
        bottom: PreferredSize(
            child: searchWidget(searchViewModel, widget.istItDoctor,
                widget.istItProfession, _searchController, proffessionList),
            preferredSize: const Size.fromHeight(65.0)),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildDoctorNameSearch(searchViewModel),
          ),
        ],
      ),
    );
  }

  FutureBuilder<List<ProfessionSearch>> buildFutureBuilderProfessionSearch(
      Future<List<ProfessionSearch>> proffessionList) {
    return FutureBuilder<List<ProfessionSearch>>(
      future: proffessionList,
      builder: (context, AsyncSnapshot<List<ProfessionSearch>> snap) {
        if (snap.hasData) {
          if (snap.data!.isEmpty) {
            return const Center(
                child: Text(
              "Veri bulunamadı",
            ));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5.0,
                child: ListTile(
                  title: Column(
                    children: [
                      CircleAvatar(
                        radius: 45.0,
                        child: snap.data![index].gender == Gender.WOMAN
                            ? Image.asset("assets/images/woman.png")
                            : Image.asset("assets/images/man.png"),
                      ),
                      Text(snap.data![index].name!),
                      Text("Uzmanlık : " +
                          snap.data![index].professionName!.toString()),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (_) => LoginViewModel(),
                                  child: ChatDetailPage(
                                    title: snap.data![index].name!,
                                  ),
                                )));
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  FutureBuilder<List<Doctor>> buildDoctorNameSearch(
      SearchViewModel searchViewModel) {
    return FutureBuilder<List<Doctor>>(
      future: searchViewModel.getDoctorList(),
      builder: (context, AsyncSnapshot<List<Doctor>> snap) {
        if (snap.hasData) {
          if (snap.data!.isEmpty) {
            return const Center(
                child: Text(
              "Veri bulunamadı",
            ));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              return buildCardProfession(snap, index, context);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Card buildCardProfession(
      AsyncSnapshot<List<Doctor>> snap, int index, BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
        title: Column(
          children: [
            CircleAvatar(
              radius: 45.0,
              child: snap.data![index].gender == Gender.WOMAN
                  ? Image.asset("assets/images/woman.png")
                  : Image.asset("assets/images/man.png"),
            ),
            Text(snap.data![index].name!),
            Text("Uzmanlık : " + snap.data![index].professionName!.toString()),
          ],
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                        create: (_) => LoginViewModel(),
                        child: ChatDetailPage(
                          title: snap.data![index].name!,
                        ),
                      )));
        },
      ),
    );
  }

  searchWidget(
      SearchViewModel searchViewModel,
      bool isItDoctor,
      bool istItProfession,
      TextEditingController searchController,
      Future<List<ProfessionSearch>> proffessionList) {
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
                  controller: searchController,
                  onChanged: (value) {
                    getSearch(searchViewModel, searchController);
                  },
                  decoration: const InputDecoration.collapsed(
                      hintText: "randevu ara..."),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    getSearch(searchViewModel, searchController);
                  });
                },
                icon: Icon(Icons.search)),
          ],
        ),
      ),
    );
  }

  startSearching(
    String query,
    SearchViewModel searchViewModel,
    bool isItDoctor,
    bool istItProfession,
  ) {
    docList = searchViewModel.getDoctorList();
  }

  Future<List<ProfessionSearch>> getSearch(
      SearchViewModel searchViewModel, TextEditingController controller) async {
    return searchViewModel.getProfessionDoctorList(
        searchProfessionName: controller.text);
  }
}
