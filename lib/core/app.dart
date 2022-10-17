import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cnvsoft/core/connection.dart';
import 'package:cnvsoft/core/log.dart';
import 'package:cnvsoft/core/translation.dart';
import 'package:cnvsoft/global.dart';
import 'package:cnvsoft/base_citenco/package/translation.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simple_logger/simple_logger.dart';

import 'package.dart';
import 'storage.dart';

const List<DeviceOrientation> ONLY_PORTRAIT = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
];
const List<DeviceOrientation> ONLY_LANDSCAPE = [
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
];
const List<DeviceOrientation> FULL_ORIENTATION = [
  DeviceOrientation.portraitUp,
  DeviceOrientation.portraitDown,
  DeviceOrientation.landscapeLeft,
  DeviceOrientation.landscapeRight,
];

AppState? appState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageCNV().init();
  StorageCNV().setBool("IS_APPLE", false);
  if (!StorageCNV().containsKey("APP_ACP_VERSION")) StorageCNV().setDefault();
  // await StorageCNV().clearStorageCNV();

  Config.initial();
  Translations().supports = [Locale("vi", "VN"), Locale("en", "US")];
  Config.intialAsset();
  runZonedGuarded(
    () {
      // Firebase.initializeApp();
      runApp(App(title: Config.title));

      Logger.root.level = kDebugMode ? Level.ALL : Level.OFF;
      Logger.root.onRecord.listen((record) {
        print(
            '${record.loggerName} | ${record.level.name}: ${record.time}: ${record.message}');
      });
      FlutterError.onError = (details, {bool forceReport = false}) {
        try {
          _captureException(details.exception, details.stack);
        } catch (e) {
          print('Sending report to sentry.io failed: $e');
        } finally {
          FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
        }
      };
    },
    (error, stackTrace) async {
      if (!(error is SocketException) &&
          !(error is DioError && error.error is SocketException)) {
        _captureException(error, stackTrace);
      }
    },
  );
}

_captureException(error, stackTrace) async {
  Log().severe({"error": error, "stackTrace": stackTrace});
}

class App extends StatefulWidget {
  final String? title;

  static EventBus _bus = EventBus();

  static bool get isDemo => Config.title == "CNV Loyalty";

  static void restart() => _bus.fire("restart");

  @override
  State<StatefulWidget> createState() => AppState();

  const App({Key? key, required this.title}) : super(key: key);
}

class AppState extends State<App> {
  Locale? _locale;
  @override
  void initState() {
    super.initState();
    setOrientation(ONLY_PORTRAIT);
    Config.config();
    Connection().init();

    _locale = (StorageCNV().containsKey("TRANSLATION_APP"))
        ? StorageCNV().getString("TRANSLATION_APP") == "vi"
            ? Locale("vi", "VN")
            : Locale("en", "US")
        : Locale("vi", "VN");
    Translations().locale = (StorageCNV().containsKey("TRANSLATION_APP"))
        ? StorageCNV().getString("TRANSLATION_APP") == "vi"
            ? Locale("vi", "VN")
            : Locale("en", "US")
        : Locale("vi", "VN");

    App._bus.on().listen((event) {
      if (event == "restart") {
        StorageCNV().remove("HELP");
        setState(() {
          Config.config();
          _locale = (StorageCNV().containsKey("TRANSLATION_APP"))
              ? StorageCNV().getString("TRANSLATION_APP") == "vi"
                  ? Locale("vi", "VN")
                  : Locale("en", "US")
              : Locale("vi", "VN");
          Translations().locale = (StorageCNV().containsKey("TRANSLATION_APP"))
              ? StorageCNV().getString("TRANSLATION_APP") == "vi"
                  ? Locale("vi", "VN")
                  : Locale("en", "US")
              : Locale("vi", "VN");
          Config.routeObserver = RouteObserver<PageRoute>();
        });
      }
    });
  }

  setOrientation(List<DeviceOrientation> listOrientation) {
    SystemChrome.setPreferredOrientations(listOrientation);
  }

  // Locale _deviceLocale;
  @override
  Widget build(BuildContext context) {
    return Material(
      key: ValueKey(Config.routeObserver),
      color: Colors.transparent,
      child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: _locale,
          supportedLocales: Translations().supports,
          debugShowCheckedModeBanner: false,
          title: widget.title ?? "",
          navigatorObservers: [Config.routeObserver],
          onGenerateRoute: _onGenerateRoute,
          initialRoute: PackageManager().initialRoute),
    );
  }

  @override
  void dispose() {
    App._bus.destroy();
    Connection().dispose();
    super.dispose();
  }

  Route _onGenerateRoute(RouteSettings settings) {
    Widget _screen = PackageManager().getByRouteSettings(settings);
    Log().fine({
      "name": settings.name,
      "arguments": settings.arguments,
    });
    if (["dash_board"].contains(settings.name)) {
      return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => _screen,
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return new FadeTransition(
              opacity: new Tween<double>(
                begin: 0.0,
                end: 1.0,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                ),
              ),
              child: child,
            );
          },
          transitionDuration:
              Duration(milliseconds: settings.name == "landing" ? 10 : 200));
    } else
      return MaterialPageRoute(
          builder: (context) => _screen, settings: settings);
  }
}
