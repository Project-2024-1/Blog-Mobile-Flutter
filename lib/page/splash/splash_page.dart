import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/storage_keys.dart';
import '../../config/config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _initialized = false;
  String? _error;
  bool needUpdate = false;
  String? linkDownloadUpdate;
  String? releaseNote;

  Future loadConfigFlavor() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageName = packageInfo.packageName;
    // check setting

    switch (packageName) {
      case "jp.ongrit.dev":
        Config.load(CONFIG_DEV);
        break;
      case "jp.ongrit.stag":
        Config.load(CONFIG_STAGING);
        break;
      case "jp.ongrit":
        Config.load(CONFIG_PROD);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    print("init _SplashPageState");
    initializeConfig();
  }

  void initializeConfig() async {
    await loadConfigFlavor();
    // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // if (Platform.isAndroid) {
    //   AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   print('Device name: ${androidInfo.brand} - ${androidInfo.version.release} - ${androidInfo.device}');
    // } else if (Platform.isIOS) {
    //   IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //   print('Device name: ${iosInfo.model} - ${iosInfo.systemName} - ${iosInfo.systemVersion}');
    // }
    // final needUpdate = await checkUpdateApp();
    // if (needUpdate) {
    //   return;
    // }

     Navigator.pushReplacementNamed(context, '/home');

    // SharedPreferences.getInstance().then((preference) async {
    //   final String keyAccountId = preference.getString(KEY_ACCESS_TOKEN) ?? "";

    //   if (keyAccountId.isEmpty) {
    //     final preferences = await SharedPreferences.getInstance();
    //     await preferences.clear();
    //     // remove badge app
    //   } else {}

    //   if (keyAccountId.isNotEmpty) {
    //     Navigator.pushReplacementNamed(context, '/home');
    //   } else {
    //     Navigator.pushReplacementNamed(context, '/login');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Scaffold(
          backgroundColor: theme.primaryColor,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white, // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.light, //<-- For Android SEE HERE (dark icons)
              statusBarBrightness:
                  Brightness.dark, //<-- For iOS SEE HERE (dark icons)
            ),
            toolbarHeight: 0,
            elevation: 0,
          ),
          body: SafeArea(
              child: Container(
            color: Colors.white,
            // padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
            padding: EdgeInsets.only(bottom: 100),
            child: Center(
              child: Image.asset("assets/img/logo_app_horizontal.png",
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width * .5),
            ),
          )),
        ),
        // this.needUpdate
        //     ? NeedUpdateAppOverlay(
        //         note: this.releaseNote ?? "",
        //         linkDownload: this.linkDownloadUpdate ?? "")
        //     : Container()
      ],
    );
  }
}
