import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:happy_care/core/utils/shared_pref.dart';
import 'package:happy_care/routes/app_pages.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  var isNotFirstTime = await SharedPrefUtils.getBoolKey("first_time") ?? true;
  runApp(MyApp(
    isNotFirstTime: isNotFirstTime,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isNotFirstTime}) : super(key: key);
  final bool isNotFirstTime;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Happy Care",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: isNotFirstTime ? AppRoutes.rOnboarding : AppRoutes.rSignIn,
      getPages: AppPages.routes,
    );
  }
}
