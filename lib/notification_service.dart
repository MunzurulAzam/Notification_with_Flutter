import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void reqNotificationPermission () async {

    NotificationSettings settings =   await messaging.requestPermission(
      alert: true,
       announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
       sound: true,

    );
    
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print(" User granted permission");
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print("user granted provitional permission");
    }else{
      print("user denied permission");
    }

}

void initLocalNotification (BuildContext context, RemoteMessage message) async {


  var androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosInitializationSettings = const DarwinInitializationSettings();

  var initializationSetting = InitializationSettings(

    android: androidInitializationSettings,
    iOS: iosInitializationSettings,

  );

  await _flutterLocalNotificationsPlugin.initialize(

    initializationSetting,
    onDidReceiveNotificationResponse: (payload){

    }
  );

}

void firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {


        print(message.notification!.title.toString());
        print(message.notification!.body.toString());


      showNotification(message);

    });
}

Future<void> showNotification(RemoteMessage message) async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(),
        'High important notification',
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString(),
        channelDescription: 'azam chanel description',
        icon: '@mipmap/ic_launcher',
        importance: Importance.max,
        priority: Priority.max,
        ticker: 'ticker',
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(

      presentAlert: true,
      presentBadge: true,
      presentSound: true,

    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, (){

      _flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails,
      );

    });

}

Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;

    }

  void isTokenRefresh() async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print("new token");
    });
  }
}