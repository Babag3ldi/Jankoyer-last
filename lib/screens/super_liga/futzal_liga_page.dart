// import 'package:flutter/material.dart';

// import '../../const/colors.dart';
// import 'futbol_liga/match.dart';
// import 'futbol_liga/statistika.dart';
// import 'futbol_liga/table.dart';
// import 'futzal_liga/match.dart';

// class FutzalLigaPage extends StatefulWidget {
//   const FutzalLigaPage({super.key});

//   @override
//   State<FutzalLigaPage> createState() => _FutzalLigaPageState();
// }

// class _FutzalLigaPageState extends State<FutzalLigaPage> {
//   bool tab1 = true;
//   bool tab2 = false;
//   bool tab3 = false;

//   int selectTabIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     double sizeWidth = MediaQuery.of(context).size.width / 100;
//     double sizeHeight = MediaQuery.of(context).size.height / 100;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         title: const Text(
//           'Turkmenistanyn Super Ligasy',
//           style: TextStyle(color: Colors.black),
//         ),
//         centerTitle: true,
//         iconTheme: IconThemeData(color: Colors.black),
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: sizeHeight * 2.5,
//           ),
//           Container(
//             width: sizeWidth * 91,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       tab1 = true;
//                       tab2 = false;
//                       tab3 = false;
//                       selectTabIndex = 0;
//                     });
//                   },
//                   child: Container(
//                     width: sizeWidth * 27,
//                     height: sizeHeight * 4.7,
//                     decoration: BoxDecoration(
//                         color:
//                             tab1 ? AppColors.primary : AppColors.tabPossive,
//                         borderRadius: BorderRadius.circular(5.0),
//                         border: Border.all(
//                           color: AppColors.primary,
//                         )),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Center(
//                           child: Text(
//                         'MAÇLAR',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: tab1 ? Colors.black : Colors.white,
//                         ),
//                       )),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       tab1 = false;
//                       tab2 = true;
//                       tab3 = false;
//                       selectTabIndex = 1;
//                     });
//                   },
//                   child: Container(
//                     height: sizeHeight * 4.7,
//                     width: sizeWidth * 27,
//                     decoration: BoxDecoration(
//                         color:
//                             tab2 ? AppColors.primary : AppColors.tabPossive,
//                         borderRadius: BorderRadius.circular(5.0),
//                         border: Border.all(
//                           color: AppColors.primary,
//                         )),
//                     child: Center(
//                         child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Text(
//                         'TABLISA ',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: tab2 ? Colors.black : Colors.white,
//                         ),
//                       ),
//                     )),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       tab1 = false;
//                       tab2 = false;
//                       tab3 = true;
//                       selectTabIndex = 2;
//                     });
//                   },
//                   child: Container(
//                     height: sizeHeight * 4.7,
//                     width: sizeWidth * 27,
//                     decoration: BoxDecoration(
//                         color:
//                             tab3 ? AppColors.primary : AppColors.tabPossive,
//                         borderRadius: BorderRadius.circular(5.0),
//                         border: Border.all(
//                           color: AppColors.primary,
//                         )),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Center(
//                           child: Text(
//                         'STATISTIKA',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: tab3 ? Colors.black : Colors.white,
//                         ),
//                         textAlign: TextAlign.center,
//                       )),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//            SizedBox(
//             height: sizeHeight * 2.5,
//           ),
//           Expanded(
//             child: IndexedStack(
//               index: selectTabIndex,
//               children: [
//                 VideoList(),
//                  FutbolTablePage(),
//                 const FutbolStatistikaPage()
//               ],
//             ),
//           )
//         ],
//       ),
      
//     );
//   }
// }
