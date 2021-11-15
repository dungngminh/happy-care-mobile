import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.size,
    required this.function,
  }) : super(key: key);

  final Size size;
  final void Function() function;
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
              CircleAvatar(
                radius: 30,
                backgroundImage: Image.asset("assets/images/icon.png").image,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Minh Đức Bie Nguyễn",
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
