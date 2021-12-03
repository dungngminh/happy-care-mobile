import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class NotOwnMessenger extends StatelessWidget {
  const NotOwnMessenger(
      {Key? key,
      required this.messenge,
      required this.time,
      this.avatar,
      this.type = "text"})
      : super(key: key);
  final String messenge;
  final String time;
  final String? avatar;
  final String type;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 5.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: kMainColor,
            child: Padding(
              padding: const EdgeInsets.all(1.5),
              child: CircleAvatar(
                backgroundImage: avatar == null
                    ? Image.asset("assets/images/icon.png").image
                    : Image.memory(base64Decode(avatar!)).image,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 120),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: type == "text"
                      ? Text(
                          messenge,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: kMainColor,
                          ),
                        )
                      : Image.memory(
                          base64Decode(messenge),
                          width: 200,
                          height: 300,
                        ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(time, style: GoogleFonts.openSans(color: kMainColor)),
        ],
      ),
    );
  }
}
