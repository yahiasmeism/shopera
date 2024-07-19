import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager {
  ImageCacheManager._();
  static Future<File> getImagePath(String imageUrl) async {
    var file = await DefaultCacheManager().getSingleFile(imageUrl);
    return file;
  }
}
