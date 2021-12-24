import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/modules/splash_screen/splash_screen.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  var isNotFirstTime = await SharedPrefUtils.getBoolKey("first_time") ?? true;
  var token = await SharedPrefUtils.getStringKey('token');
  runApp(MyApp(isNotFirstTime: isNotFirstTime, token: token));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isNotFirstTime, this.token})
      : super(key: key);
  final bool isNotFirstTime;
  final String? token;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: "Happy Care",
        debugShowCheckedModeBanner: false,
        initialBinding: BindingsBuilder.put(() => Client()),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: isNotFirstTime
        //     ? AppRoutes.rOnboarding
        //     : (token != null ? AppRoutes.rMain : AppRoutes.rSignIn),
        home: SplashScreen(token: token, isNotFirstTime: isNotFirstTime),
        getPages: AppPages.routes,
      );
    });
  }
}
