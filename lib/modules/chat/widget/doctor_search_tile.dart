import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';

class DoctorSearchTile extends StatelessWidget {
  const DoctorSearchTile({
    Key? key,
    this.fullname,
    this.specialization,
    this.isOnline, required this.function,
  }) : super(key: key);

  final String? fullname;
  final String? specialization;
  final bool? isOnline;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: kMainColor,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: 28,
            backgroundImage: Image.asset("assets/images/doctor.png").image,
            backgroundColor: Colors.white,
            foregroundColor: kMainColor,
          ),
        ),
      ),
      title: Text(
        fullname ?? "Bác sĩ giấu tên",
        style: GoogleFonts.openSans(
          color: kMainColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(specialization ?? "Chưa có thông tin",
          style: GoogleFonts.openSans()),
      trailing: isOnline! ? Icon(Icons.wifi_rounded, color: kMainColor) : null,
      onTap: function,
    );
  }
}
