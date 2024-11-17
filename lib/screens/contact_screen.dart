// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jankoyer/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    Future<void> makePhoneCall(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> advertiseLink(Uri url) async {
      if (!await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      )) {
        throw Exception('Could not launch $url');
      }
    }

    sendEmail(String recipientemail) async {
      final Email email = Email(
        body: '',
        subject: '',
        recipients: [recipientemail],
        isHTML: false,
      );
      await FlutterEmailSender.send(email);
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primary,
          title:
              const Text('HABARLAŞMAK', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: sizeWidth * 10, vertical: sizeHeight * 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              container(Icons.call, '+993 64 17 08 17', () {
                makePhoneCall("tel:+99364170817");
              }),
              container(Icons.mail, 'jankoyercomtm@gmail.com', () {
                sendEmail('jankoyercomtm@gmail.com');
              }),
              container(FontAwesomeIcons.instagram, 'jankoyer.com.tm', () {
                advertiseLink(Uri.parse('jankoyer.com.tm'));
              }),
              container(Icons.tiktok, 'jankoyer.com.tm', () {
                advertiseLink(Uri.parse('jankoyer.com.tm'));
              }),
            ],
          ),
        ),
      ),
    );
  }

  InkWell container(IconData iconData, String text, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Icon(iconData, color: Colors.white, size: 30),
            const SizedBox(width: 20),
            Text(text,
                style: const TextStyle(fontSize: 20, color: Colors.white))
          ],
        ),
      ),
    );
  }
}
