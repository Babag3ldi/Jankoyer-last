// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:grock/grock.dart';

class FirebaseNotificationService {
  late final FirebaseMessaging messaging;

  void settingNotification() async {
    await messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );
  }

  void connectNotification() async {
    await Firebase.initializeApp();
    messaging = FirebaseMessaging.instance;
    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      sound: true,
      badge: true,
    );

    settingNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      Grock.snackBar(
          title: '${event.notification?.title}',
          description: '${event.notification?.body}',
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/logo.png",
                    ),
                    fit: BoxFit.fill)),
          ),
          opacity: 0.5,
          position: SnackbarPosition.top);
      print('Gelen message ${event.notification?.title}');
    });

    messaging
        .getToken()
        .then((value) => log("Tokenn: $value", name: "FCM Token"));
  }

  static Future<void> backgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();

    print("Message Id ${message.messageId}");
  }

//   Future<Album> createAlbum(String token) async {
//     final response = await http.post(
//       Uri.parse('http://jankoyer.com.tm/send-notification'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode({
//         'token': messaging.getToken().then((value) => log("$value")),
//       }),
//     );
//     print(response.statusCode);
//     if (response.statusCode == 201) {
//       return Album.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to create album.');
//     }
//   }
}

class Album {
  final String token;

  const Album({required this.token});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      token: json['token'],
    );
  }
}
