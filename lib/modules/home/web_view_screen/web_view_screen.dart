import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key, required this.linkUrl, required this.title})
      : super(key: key);
  final String linkUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Text(
          title,
          style: GoogleFonts.openSans(fontSize: 12.sp),
        ),
      ),
      body: WebView(
        initialUrl: linkUrl,
      ),
    );
  }
}
