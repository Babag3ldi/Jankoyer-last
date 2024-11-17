import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../model/championat_model.dart';
import 'futbol_liga/match.dart';
import 'futbol_liga/statistika.dart';
import 'futbol_liga/table.dart';

class FutbolLigaPage extends StatefulWidget {
  const FutbolLigaPage(this.championatsget, {super.key});

  final ChampionatModel championatsget;

  @override
  State<FutbolLigaPage> createState() => _FutbolLigaPageState();
}

class _FutbolLigaPageState extends State<FutbolLigaPage> {
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;

  int selectTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    final champ = widget.championatsget;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          widget.championatsget.title.toString(),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: sizeHeight * 2.5),
          SizedBox(
            width: sizeWidth * 91,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = true;
                      tab2 = false;
                      tab3 = false;
                      selectTabIndex = 0;
                    });
                  },
                  child: Container(
                    width: sizeWidth * 27,
                    height: sizeHeight * 4.7,
                    decoration: BoxDecoration(
                        color: tab1 ? AppColors.primary : AppColors.tabPossive,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: AppColors.primary,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: Text(
                        'OÝUNLAR',
                        style: TextStyle(
                          fontSize: 14,
                          color: tab1 ? Colors.black : Colors.white,
                        ),
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  width: sizeWidth * 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = false;
                      tab2 = true;
                      tab3 = false;
                      selectTabIndex = 1;
                    });
                  },
                  child: Container(
                    height: sizeHeight * 4.7,
                    width: sizeWidth * 27,
                    decoration: BoxDecoration(
                        color: tab2 ? AppColors.primary : AppColors.tabPossive,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: AppColors.primary,
                        )),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'TABLISA ',
                        style: TextStyle(
                          fontSize: 14,
                          color: tab2 ? Colors.black : Colors.white,
                        ),
                      ),
                    )),
                  ),
                ),
                SizedBox(
                  width: sizeWidth * 5,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = false;
                      tab2 = false;
                      tab3 = true;
                      selectTabIndex = 2;
                    });
                  },
                  child: Container(
                    width: sizeWidth * 27,
                    height: sizeHeight * 4.7,
                    decoration: BoxDecoration(
                        color: tab3 ? AppColors.primary : AppColors.tabPossive,
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: AppColors.primary,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                          child: Text(
                        'STATISTIKA',
                        style: TextStyle(
                          fontSize: 14,
                          color: tab3 ? Colors.black : Colors.white,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeHeight * 2.5,
          ),
          Expanded(
            child: IndexedStack(
              index: selectTabIndex,
              children: [
                FutbolMatchPage(champ),
                FutbolTablePage(champ),
                FutbolStatistikaPage(champ)
              ],
            ),
          )
        ],
      ),
    );
  }
}
