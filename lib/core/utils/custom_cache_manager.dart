import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const cacheKey = "image_cached";
  static final customCacheManager = CacheManager(Config(
    cacheKey,
    stalePeriod: const Duration(days: 2),
    maxNrOfCacheObjects: 50,
    repo: JsonCacheInfoRepository(databaseName: cacheKey),
    fileService: HttpFileService(),
  ));
}
