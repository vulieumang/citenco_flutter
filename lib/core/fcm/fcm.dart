import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cnvsoft/core/fcm/fcm_handle.dart';
import 'package:cnvsoft/core/package.dart';
import 'package:cnvsoft/global.dart';
// import 'package:cnvsoft/special/announcement/announcement_model.dart';
// import 'package:cnvsoft/special/announcement/popup_widget/noti.dart';
import 'package:cnvsoft/base_citenco/mix/profile_mix.dart';
import 'package:cnvsoft/base_citenco/package/package.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../base_core/data_mix.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

class FCM with DataMix {
  static FCM? _internal;
  FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description:'This channel is used for important notifications.',
    importance: Importance.max,
  );

  FCM._();

  factory FCM() {
    if (_internal == null) _internal = FCM._();
    return _internal!;
  }

  String get topic =>
      (MyProfile().isVerifiedPhone) ? MyProfile().phone! : "null";

  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void config(State state) async {
    Future.delayed(Duration(seconds: 2)).then((value) {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? message) {
        if (message != null) {
          handle(state, message.data);
        }
      });
    });

    await FirebaseMessaging.instance.requestPermission();

    //firebase
    FirebaseMessaging.instance.subscribeToTopic(topic);
    FirebaseMessaging.instance.getToken().then((v) async {
      if (v != null) { 
      } else {
        print("Token FCM: on null");
      }
    });

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    _local.initialize(initializationSettings,
        onSelectNotification: (payload) async {
      print("onSelectNotification: " + payload!);
      return handle(state, dataOf(() => json.decode(payload)));
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      Map<String, dynamic> data = message.data;
      if (notification != null) {
        print("onMessage: " + json.encode(message.data));
        AndroidNotification? android = message.notification?.android;
        if (android != null) {
          _showAndroidNotification(notification, data);
        } else {
          // vì đã cài đặt notification IOS foreground ở AppDelegate.swift
          // if #available(iOS 10.0, *) {
          // UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          // }
          // nên không cần code show local notificaion

          // _showAppleNotification(notification, data);
        }
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: " + json.encode(message.data));
      await handle(state, message.data);
    });
  }

  Future<void> _showAndroidNotification(
      RemoteNotification? notification, Map<String, dynamic>? data) async {
    var id = intOf(() => Random().nextInt(300));
    var title = stringOf(() => notification!.title!);
    var body = stringOf(() => notification!.body!);
    var payload = dataOf(() => json.encode(data));
    var channelId = stringOf(() => notification!.android!.channelId!,
        "default_notification_channel_id");
    // final Int64List vibrationPattern = Int64List(4);
    // vibrationPattern[0] = 0;
    // vibrationPattern[1] = 1000;
    // vibrationPattern[2] = 5000;
    // vibrationPattern[3] = 2000;

    // var file = await androidDrawable.loadBitmap(name: "app_icon");

    FilePathAndroidBitmap? bitmap;

    var imageUrl = stringOf(() => notification!.android!.imageUrl!);
    if (imageUrl.isNotEmpty) {
      String ext = stringOf(() => imageUrl.split(".").last, "jpg");
      var path = await _downloadAndSaveFile(imageUrl, 'large_image.$ext');
      print(path);
      bitmap = FilePathAndroidBitmap(path);
    }

    var channel = new AndroidNotificationDetails(channelId, Config.title, channelDescription:"",
        importance: Importance.max,
        priority: Priority.max,
        enableVibration: true,
        largeIcon: bitmap,
        styleInformation: BigTextStyleInformation(body,
            summaryText: body,
            contentTitle: title,
            htmlFormatBigText: true,
            htmlFormatContent: true,
            htmlFormatTitle: true,
            htmlFormatContentTitle: true,
            htmlFormatSummaryText: true),
        enableLights: true);
    await _local.show(id, title, body, NotificationDetails(android: channel),
        payload: payload);
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> _showAppleNotification(
      RemoteNotification? notification, Map<String, dynamic>? data) async {
    var id = intOf(() => Random().nextInt(300));
    var title = stringOf(() => notification!.title!);
    var body = stringOf(() => notification!.body!);
    var payload = dataOf(() => json.encode(data));
    var channel = new IOSNotificationDetails(
        presentAlert: true, presentBadge: true, presentSound: true);
    await _local.show(id, title, body, NotificationDetails(iOS: channel),
        payload: payload);
  }

  // Future<void> handleNoti(State state, Map? msg, {Datas? dataNoti}) async {
  //   if (msg != null) {
  //     var data = msg;
  //     if (Platform.isAndroid && boolOf(() => data['is_push_noti'], true)) {
  //       data = msg["data"];
  //     }
  //     String? type = data['subject_type'];
  //     String? id = stringOf(() => data["transactionId"],
  //         stringOf(() => data['subject_id']), [""]);
  //     String? announcementID = data['announcement_id'];
  //     String? route = data["route"];

  //     if (route != null) {
  //       if (PackageManager().existRoute(route)) {
  //         NotiPopup.show(state,
  //             title: dataNoti!.templateTitle,
  //             discription: dataNoti.templateBody, onTapNavigator: () async {
  //           // await Navigator.of(state.context).pushNamed(route);
  //           // Navigator.of(state.context)
  //           //     .popUntil((route) => route.settings.name == "dash_board");
  //         });
  //       }
  //     } else if (type != null) {
  //       RemoteHandle remote;
  //       int index = max(int.tryParse(type) ?? 0, 0);
  //       remote = _getRemotes(id, announcementID, index);
  //       await _onNotifyHandlerNoti(state, remote, dataNoti: dataNoti);
  //     }
  //   } else {
  //     NotiPopup.show(state,
  //         title: dataNoti!.templateTitle,
  //         discription: dataNoti.templateBody, onTapNavigator: () {
  //       // Navigator.of(state.context).pushNamed("announcement");
  //     });
  //   }
  // }

  // Future<void> _onNotifyHandlerNoti(State state, RemoteHandle? remote,
  //     {Datas? dataNoti}) async {
  //   var name = "announcement";
  //   if (PackageManager().existRoute(remote!.route!)) {
  //     name = remote.route!;
  //   } else if (PackageManager().existRoute(remote.secondary!)) {
  //     name = remote.secondary!;
  //   }
  //   if (stringOf(() => remote.announcementID!).isNotEmpty) {
  //     BasePKG.of(state).getAnnouncement(stringOf(() => remote.announcementID!));
  //   }
  //   try {
  //     NotiPopup.show(state,
  //         title: dataNoti!.templateTitle,
  //         discription: dataNoti.templateBody,
  //         // onTapNavigator: () =>
  //         //     Navigator.of(Config.routeObserver.navigator!.context)
  //         //         .pushNamed(name, arguments: remote.argument)
  //                 );
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  
  Future<void> handle(State state, Map? msg) async {
    if (msg != null) {
      var data = msg;

      /// handle FCM dùng khi nhấn vào noti,
      /// các function muốn dùng cần truyền vào is_push_noti: fasle
      /// nếu không data sẽ bị null
      if (Platform.isAndroid && boolOf(() => data['is_push_noti'], true)) {
        data = msg["data"];
      }
      String? type = data['subject_type'];
      String? id = stringOf(() => data["transactionId"],
          stringOf(() => data['subject_id']), [""]);
      String? announcementID = data['announcement_id'];
      String? route = data["route"];

      if (route != null) {
        if (PackageManager().existRoute(route)) {
          await Navigator.of(state.context).pushNamed(route);
          Navigator.of(state.context)
              .popUntil((route) => route.settings.name == "dash_board");
        }
      } else if (type != null) {
        RemoteHandle remote;
        int index = max(int.tryParse(type) ?? 0, 0);
        remote = _getRemotes(id, announcementID, index);
        await _onNotifyHandler(state, remote);
      }
    } else {
      Navigator.of(state.context).pushNamed("announcement");
    }
  }

  RemoteHandle _getRemotes(dynamic id, String? announce, int index) {
    return {
          0: RemoteHandle.announcements(),
          1: RemoteHandle.announcement(id, announce),
          2: RemoteHandle.blog(id, announce),
          3: RemoteHandle.reward(id, announce),
          4: RemoteHandle.warranty(id, announce),
          5: RemoteHandle.announcements(),
          6: RemoteHandle.gym(id, announce),
          7: RemoteHandle.product(id, announce),
          8: RemoteHandle.wine(id, announce),
          9: RemoteHandle.review(id, announce),
          10: RemoteHandle.quote(id, announce),
          11: RemoteHandle.booking(id, announce),
          15: RemoteHandle.luckyNumberGame(id, announce),
          16: RemoteHandle.topUpHistory(id, announce),
          17: RemoteHandle.productCollection(id, announce),
          18: RemoteHandle.orderDetail(id, announce),
          701: RemoteHandle.wheelWeb(id, announce),
        }[index] ??
        (boolOf(() => announce?.isNotEmpty)
            ? RemoteHandle.announcement(announce, announce)
            : RemoteHandle.announcements());
  }

  Future<void> _onNotifyHandler(State state, RemoteHandle? remote) async {
    var name = "announcement";
    if (PackageManager().existRoute(remote!.route!)) {
      name = remote.route!;
    } else if (PackageManager().existRoute(remote.secondary!)) {
      name = remote.secondary!;
    } 
    try {
      await Navigator.of(Config.routeObserver.navigator!.context)
          .pushNamed(name, arguments: remote.argument);
    } catch (e) {
      print(e);
    }
  } 

  Future dispose(State state) async {
    Completer completer = Completer();
    int count = 0;
    Function _count = (_) {
      count++;
      if (count >= 2 && !completer.isCompleted) {
        completer.complete();
      }
    };
    // _local.cancelAll().then((_) => _count());
    var token = await FirebaseMessaging.instance.getToken();
    // await _local.cancelAll().then((value) => _count);

    await FirebaseMessaging.instance.deleteToken().catchError((err) {
      print(err);
    });

    await FirebaseMessaging.instance
        .unsubscribeFromTopic(topic)
        .then((value) => _count)
        .catchError((err) {
      print(err);
    });
    if (token != null) { 
    }
  }
}
