import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

void initLocalNotification (){

}

void firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {

      var androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInitializationSettings = DarwinInitializationSettings();

      var initializationSetting = InitializationSettings(

        android: androidInitializationSettings,
        iOS: iosInitializationSettings,

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