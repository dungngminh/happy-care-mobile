import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:happy_care/core/utils/custom_cache_manager.dart';

class ViewImage extends StatelessWidget {
  const ViewImage({Key? key, required this.imgUrl}) : super(key: key);

  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        child: InteractiveViewer(
          child: Center(
            child: Hero(
              tag: imgUrl,
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                cacheManager: CustomCacheManager.customCacheManager,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
