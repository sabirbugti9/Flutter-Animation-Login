import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reqres_app/App/HomeScreen/HomeScreen.dart';
import 'package:get/get.dart';
import 'package:reqres_app/App/auth/login/loginScreen.dart';
import 'package:reqres_app/flavors.dart';
import 'package:reqres_app/state/settingsState.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReqResApp extends StatelessWidget {
  const ReqResApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    GetInstance().put<SettingController>(SettingController());
    print(box.hasData('token'));
    print("DAKR");
    print(box.hasData('darkThem'));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      getPages: [
        GetPage(
            name: '/',
            page: () {
              return box.hasData('token') ? HomeScreen() : LoginScreen();
            })
      ],
    );
  }
}
