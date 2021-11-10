import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class InformationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;

  const InformationTile({
    Key? key,
    required this.icon,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: kMainColor,
      ),
      title: Text(
        title,
        style: GoogleFonts.openSans(
            color: kMainColor, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        subtitle ?? "Chưa có thông tin",
        style: GoogleFonts.openSans(),
      ),
    );
  }
}
