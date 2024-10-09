import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ImageMarker {
  static Future<Marker?> buildMarkerFromUrl({
    required String id,
    required String url,
    required LatLng position,
    int? width,
    int? height,
    Offset offset = const Offset(0.5, 0.5),
    VoidCallback? onTap,
  }) async {
    final icon = await getIconFromUrl(url, height: height, width: width);
    if (icon == null) return null;

    return Marker(markerId: MarkerId(id), position: position, icon: icon, anchor: offset, onTap: onTap);
  }

  static Future<BitmapDescriptor?> getIconFromUrl(String url, {int? width, int? height}) async {
    Uint8List? bytes = await getBytesFromUrl(url, height: height, width: width);
    if (bytes == null) {
      return null;
    }

    final resizedBytes = await cropToCircle(bytes, width ?? 100);
    if (resizedBytes == null) {
      return null;
    }

    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  static Future<Uint8List?> getBytesFromUrl(String url, {int? width, int? height}) async {
    final cache = CacheManager(Config('markers', stalePeriod: const Duration(days: 3)));
    final file = await cache.getSingleFile(url);
    final bytes = await file.readAsBytes();
    return resizeImageFromBytes(bytes, width: width, height: height);
  }

  static Future<Uint8List?> resizeImageFromBytes(Uint8List bytes, {int? width, int? height}) async {
    Codec codec = await instantiateImageCodec(bytes, targetWidth: width, targetHeight: height);
    FrameInfo fi = await codec.getNextFrame();
    ByteData? data = await fi.image.toByteData(format: ImageByteFormat.png);
    return data?.buffer.asUint8List();
  }

  static Future<Uint8List?> cropToCircle(Uint8List bytes, int size) async {
    final codec = await instantiateImageCodec(bytes, targetWidth: size, targetHeight: size);
    final frameInfo = await codec.getNextFrame();
    final image = frameInfo.image;

    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);

    final paint = Paint()..isAntiAlias = true;
    final clipPath = Path()..addOval(Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()));

    canvas.clipPath(clipPath);
    canvas.drawImage(image, Offset.zero, paint);

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(size, size);

    final byteData = await img.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}
