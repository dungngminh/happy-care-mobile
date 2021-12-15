import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';
import 'package:sizer/sizer.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.function,
    required this.status,
    this.fullName,
    this.avatar,
    required this.width,
  }) : super(key: key);

  final void Function() function;
  final int status;
  final double width;
  final String? fullName;
  final String? avatar;

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
          width: width,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    backgroundColor: kMainColor,
                    radius: 29,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundColor: kSecondColor,
                        radius: 29,
                        backgroundImage: avatar == null
                            ? Image.asset("assets/images/icon.png").image
                            : CachedNetworkImageProvider(
                                avatar!,
                                cacheManager:
                                    CustomCacheManager.customCacheManager,
                              ),
                      ),
                    ),
                  ),
                  status == 1
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
                          : SizedBox()),
                ],
              ),
              SizedBox(
                height: 0.8.h,
              ),
              Text(
                fullName ?? "Bác sĩ giấu tên",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: kMainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
