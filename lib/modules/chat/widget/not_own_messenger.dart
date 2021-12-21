import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';
import 'package:happy_care/modules/chat/widget/view_image.dart';
import 'package:sizer/sizer.dart';

class NotOwnMessenger extends StatelessWidget {
  const NotOwnMessenger(
      {Key? key,
      required this.message,
      required this.time,
      this.avatar,
      this.type = "text"})
      : super(key: key);
  final String message;
  final String time;
  final String? avatar;
  final String type;

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: kSecondColor,
                backgroundImage: avatar == null
                    ? Image.asset("assets/images/icon.png").image
                    : CachedNetworkImageProvider(
                        avatar!,
                        cacheManager: CustomCacheManager.customCacheManager,
                      ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: type == "text"
                ? ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 100.w - 120),
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
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          message,
                          style: GoogleFonts.openSans(
                            fontSize: 14.sp,
                            color: kMainColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () => Get.to(() => ViewImage(imgUrl: message)),
                    child: Hero(
                      tag: message,
                      child: CachedNetworkImage(
                        cacheManager: CustomCacheManager.customCacheManager,
                        imageUrl: message,
                        imageBuilder: (context, imageProvider) => Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.contain),
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
                          width: 170,
                          child: Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(time, style: GoogleFonts.openSans(color: kMainColor)),
        ],
      ),
    );
  }
}
