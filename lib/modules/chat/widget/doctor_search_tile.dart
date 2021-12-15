import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';

class DoctorSearchTile extends StatelessWidget {
  const DoctorSearchTile({
    Key? key,
    this.fullname,
    this.specialization,
    this.status,
    required this.function,
    this.avatar,
  }) : super(key: key);

  final String? fullname;
  final String? specialization;
  final int? status;
  final String? avatar;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: kMainColor,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: avatar == null
                  ? Image.asset("assets/images/icon.png").image
                  : CachedNetworkImageProvider(avatar!, cacheManager: CustomCacheManager.customCacheManager,),
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
        trailing: status == 1
            ? Badge(
                toAnimate: false,
                shape: BadgeShape.circle,
                badgeColor: Colors.red,
              )
            : (status == 2
                ? Badge(
                    toAnimate: false,
                    shape: BadgeShape.circle,
                    badgeColor: Colors.green,
                  )
                : Icon(Icons.wifi_off_rounded, color: Colors.grey[300])),
        onTap: function,
      ),
    );
  }
}
