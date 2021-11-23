import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';

class RoomMessListTile extends StatelessWidget {
  const RoomMessListTile({
    Key? key,
    required this.function,
  }) : super(key: key);

  final void Function() function;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: Image.asset("assets/images/icon.png").image,
      ),
      title: Text("Nguyễn Minh Dũng",
          style: GoogleFonts.openSans(color: kMainColor)),
      subtitle: Text(
        "Á đụ má mày nói con kặc gì dậy",
        style: GoogleFonts.openSans(),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
