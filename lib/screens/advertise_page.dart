import 'package:flutter/material.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:jankoyer/model/advertise_model.dart';

class AdvertisePage extends StatefulWidget {
  const AdvertisePage(this.adver, {super.key});

  final AdvertiseModel adver;

  @override
  State<AdvertisePage> createState() => _AdvertisePageState();
}

class _AdvertisePageState extends State<AdvertisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Advertise text',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network('http://jankoyer.com.tm${widget.adver.image}'),
        )
      ]),
    );
  }
}