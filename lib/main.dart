import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:happy_care/routes/app_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env");
  await Hive.initFlutter();
  await Hive.openBox('jwt');
  print(Hive.box('jwt').get('jwt'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Happy Care",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Hive.box('jwt').get('jwt') == null
          ? AppPages.initial
          : AppPages.initial2,
      getPages: AppPages.routes,
    );
  }
}
