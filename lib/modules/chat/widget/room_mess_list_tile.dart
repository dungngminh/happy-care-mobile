import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';

class RoomMessListTile extends StatelessWidget {
  const RoomMessListTile({
    Key? key,
    required this.function,
    this.avatar,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? avatar;

  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      leading: CircleAvatar(
        radius:25, backgroundColor: kMainColor,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: avatar == null
                                ? Image.asset("assets/images/icon.png").image
                                : Image.memory(base64Decode(avatar!)).image,
          ),
        ),
      ),
      title: Text(title, style: GoogleFonts.openSans(color: kMainColor)),
      subtitle: Text(
        "Tôi có thể giúp gì cho bạn?",
        style: GoogleFonts.openSans(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
