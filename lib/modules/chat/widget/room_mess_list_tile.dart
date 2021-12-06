import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
    this.isOnline,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? avatar;
  final bool? isOnline;

  final void Function() function;
  @override
  Widget build(BuildContext context) {
    print(subtitle);
    return ListTile(
      onTap: function,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: kMainColor,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: avatar == null
                    ? Image.asset("assets/images/icon.png").image
                    : CachedNetworkImageProvider(avatar!),
              ),
            ),
          ),
          isOnline != null
              ? (isOnline! ? Badge(badgeColor: Colors.green) : SizedBox())
              : SizedBox(),
        ],
      ),
      title: Text(title, style: GoogleFonts.openSans(color: kMainColor)),
      subtitle: Text(
        subtitle ?? "Hello",
        style: GoogleFonts.openSans(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
