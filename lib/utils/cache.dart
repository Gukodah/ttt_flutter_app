import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(hours: 1),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}