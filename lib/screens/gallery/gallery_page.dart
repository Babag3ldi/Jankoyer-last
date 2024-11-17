// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../const/colors.dart';
import '../../model/gallery_model.dart';
import 'gallery_datails.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late List<Gallery> galleryes;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetch();
  }

  @pragma('vm:entry-point')
  fetch() async {
    galleryes = await getgallery();
    setState(() {
      isLoading = false;
    });
  }

  @pragma('vm:entry-point')
  Future<List<Gallery>> getgallery() async {
    final uri = Uri.parse(
        "http://jankoyer.com.tm/api/1.0/gallery?limitAttachment=1&page=1");  ////?limitAttachment=1&page=1
    var response = await http.get(uri);
    print("galleryGettt => ${response.statusCode}");
    var json = jsonDecode(response.body)['gallery'] as List;
    if (response.statusCode == 200) {
      List<Gallery> gallery =
          List<Gallery>.from(json.map((e) => Gallery.fromJson(e)));
      return gallery;
    } else {
      String gallery = 'no internet';
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Fotoreportaž',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
                child: SizedBox(
                  width: sizeWidth * 91,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(top: 10),
                      itemCount: galleryes.length,
                      itemBuilder: (context, index) {
                        final galleryInx = galleryes[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GalleryDetails(
                                           galleryInx,
                                        )),
                              );
                            },
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: sizeHeight * 28,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                // color:  Colors.white
                                //     .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GalleryDetails(
                                                   galleryInx,
                                                )),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                "http://jankoyer.com.tm${galleryInx.galleryAttachments.first.image}",
                                              ),
                                              fit: BoxFit.fill)
                                          ),
                                      width: sizeWidth * 91,
                                      // child: Image.network(
                                      //     "http://jankoyer.com.tm${galleryInx.galleryAttachments.first.image}",
                                      //     // color:const Color.fromARGB(255, 155, 154, 154)
                                      //     //     .withOpacity(0.9),
                                      //     colorBlendMode: BlendMode.modulate,
                                      //     fit: BoxFit.fill)
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      width: sizeWidth * 91,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(5),
                                            bottomRight: Radius.circular(5)),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: sizeWidth * 85,
                                              child: Text(
                                                galleryInx.title,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
          ),
    );
  }
}
