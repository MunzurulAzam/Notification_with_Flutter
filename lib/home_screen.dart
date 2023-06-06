import 'package:flutter/material.dart';

import 'notification_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationService notificationService = NotificationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationService.reqNotificationPermission();
    // notificationService.isTokenRefresh()
    notificationService.firebaseInit();
    notificationService.getDeviceToken().then((value){
      print('device Token');
      print(value);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
