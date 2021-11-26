import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.size,
    required this.function,
    required this.isOnline,
    this.fullName,
  }) : super(key: key);

  final Size size;
  final void Function() function;
  final bool isOnline;
  final String? fullName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 12.0,
          left: 10.0,
          right: 10.0,
        ),
        child: SizedBox(
          width: size.width * 0.17,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        Image.asset("assets/images/icon.png").image,
                  ),
                  isOnline
                      ? Badge(
                          toAnimate: false,
                          shape: BadgeShape.circle,
                          badgeColor: Colors.green,
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                fullName ?? "Bác sĩ giấu tên",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: kMainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
