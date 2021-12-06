import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
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
              child: type == "text"
                  ? Card(
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
                        child: Text(
                          messenge,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: messenge,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      progressIndicatorBuilder: (context, string, progress) {
                        return SizedBox(
                          height: 200,
                          width: 200,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                              color: kMainColor,
                            ),
                          ),
                        );
                      },
                      errorWidget: (context, string, dymamic) => SizedBox(
                        height: 200,
                        width: 300,
                        child: Center(
                          child: Icon(Icons.error),
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
