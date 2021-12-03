import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class OwnMessenger extends StatelessWidget {
  const OwnMessenger(
      {Key? key,
      required this.messenge,
      required this.time,
      this.status,
      this.type = "text"})
      : super(key: key);
  final String messenge;
  final String time;
  final bool? status;
  final String type;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(time, style: GoogleFonts.openSans(color: kMainColor)),
          SizedBox(width: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 80),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                color: kMainColor,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: type == "text"
                      ? Text(
                          messenge,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.white,
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
        ],
      ),
    );
  }
}
