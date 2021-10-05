import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_care/routes/app_pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Happy Care",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
