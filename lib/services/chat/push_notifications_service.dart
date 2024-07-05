import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';

class FirebasePushNotificationService {
  static final _pushNotification = FirebaseMessaging.instance;
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<String?> getToken() async {
    return await _firebaseMessaging.getToken();
  }

  static Future<void> init() async {
    final notificationSettings = await _pushNotification.requestPermission();
    final token = await _pushNotification.getToken();

    
  }

  static void sendNotificationMessage(
      String token, String fromUSer, String message) async {
    await Future.delayed(Duration(seconds: 1));
    final jsonCredentials = await rootBundle.loadString('service-account.json');

    var accountCredentials =
        ServiceAccountCredentials.fromJson(jsonCredentials);

    var scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    final client = await clientViaServiceAccount(accountCredentials, scopes);

    // print(client.credentials.accessToken);
    final notificationData = {
      'message': {
        'token': token,
        'notification': {

          'title': fromUSer,
          'body': message,
        }
      },
    };

    const projectId = "chat-app-e3b69";
    Uri url = Uri.parse(
        "https://fcm.googleapis.com/v1/projects/$projectId/messages:send");

    final response = await client.post(
      url,
      headers: {
        'content-type': 'application/json',
        'Authorization': 'Bearer ${client.credentials.accessToken}',
      },
      body: jsonEncode(notificationData),
    );

    client.close();
    if (response.statusCode == 200) {
      print("YUBORILDI");
    }

    // print('Notification Sending Error Response status: ${response.statusCode}');
    // print('Notification Response body: ${response.body}');
  }

}
