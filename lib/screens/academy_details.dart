// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:jankoyer/model/academy_model.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../const/colors.dart';
import '../model/academy_players_model.dart';
import '../service/news_service.dart';

class AcademyDetails extends StatefulWidget {
  const AcademyDetails({super.key, required this.academyModel});

  final AcademyModel academyModel;

  @override
  State<AcademyDetails> createState() => _AcademyDetailsState();
}

class _AcademyDetailsState extends State<AcademyDetails> {
  List<AcademyPlayersModel> academyPlayersList = [];
  bool isFocusedNote = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPlayers();
  }

  Future<void> getPlayers() async {
    try {
      academyPlayersList =
          await NewsService().getPlayers(widget.academyModel.id);
      setState(() {
        isLoading = true;
      });
    } catch (e) {
      print("academy players error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(widget.academyModel.name,
              style: const TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Column(
        children: [
          SizedBox(height: sizeHeight * 1),
          InkWell(
            onTap: () {
              pushNewScreen(
                context,
                screen: AcademyDescription(academyModel: widget.academyModel),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Center(
                child: Image.network(
                    'http://jankoyer.com.tm${widget.academyModel.image}',
                    fit: BoxFit.contain,
                    height: sizeHeight * 25)),
          ),
          !isLoading
              ? const CircularProgressIndicator()
              : academyPlayersList.isEmpty
                  ? SizedBox(
                      height: sizeHeight * 30,
                      child: const Center(
                        child: Text("Oyuncy yok",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        itemCount: academyPlayersList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: sizeHeight * 8,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(96, 26, 17, 65)),
                            child: Row(children: [
                              Container(
                                  width: sizeWidth * 20,
                                  height: sizeHeight * 8,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: const BoxDecoration(
                                      color: AppColors.primary),
                                  child: Image.network(
                                      'http://jankoyer.com.tm${academyPlayersList[index].image}',
                                      fit: BoxFit.contain)),
                              SizedBox(width: sizeWidth * 4),
                              Expanded(
                                child: Text(academyPlayersList[index].fullName,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 22)),
                              )
                            ]),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

class AcademyDescription extends StatelessWidget {
  const AcademyDescription({super.key, required this.academyModel});

  final AcademyModel academyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: Text(academyModel.name,
              style: const TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          academyModel.description,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
