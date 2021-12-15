import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_care/core/themes/colors.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';
import 'package:sizer/sizer.dart';

class CustomNewsListTile extends StatelessWidget {
  const CustomNewsListTile({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.description,
    required this.function,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final String description;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 15.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kShadowColor,
                blurRadius: 4,
                offset: Offset(-1, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CachedNetworkImage(
                  cacheManager: CustomCacheManager.customCacheManager,
                  imageUrl: imgUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 14.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fitHeight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  progressIndicatorBuilder: (context, string, progress) {
                    return SizedBox(
                      width: 14.h,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: progress.progress,
                          color: kMainColor,
                        ),
                      ),
                    );
                  },
                  errorWidget: (context, string, dymamic) => SizedBox(
                    width: 14.h,
                    child: Center(
                      child: Icon(
                        Icons.error,
                        color: kMainColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  right: 15,
                  left: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      style: GoogleFonts.openSans(
                        color: Colors.black,
                        // fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    AutoSizeText(
                      description,
                      style: GoogleFonts.openSans(
                        color: Colors.grey[500],
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
