import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

/// This class defines all the methods used to render assets in UI layer
class ImageLoader {
  ImageLoader._();

  static Widget asset(
    String assetName, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
  }) {
    return Image.asset(
      assetName,
      height: height,
      width: width,
      color: color,
      fit: fit ?? BoxFit.contain,
    );
  }

  static Widget assetSvg(
    String assetName, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
  }) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
    );
  }

  static Widget cachedNetworkImage(
    String assetName, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
    Widget? errorWidget,
    Widget? placeholderWidget,
    bool? isCoverImage,
  }) {
    if (assetName.contains('.svg')) {
      return CachedNetworkSVGImage(
        assetName,
        placeholder: placeholderWidget ?? const SizedBox.shrink(),
        errorWidget: errorWidget ??
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40.h),
              ],
            ),
        width: width,
        height: height,
      );
    }
    return CachedNetworkImage(
      imageUrl: assetName,
      height: height,
      width: width,
      color: color,
      fit: fit,
      placeholder: (context, value) =>
          placeholderWidget ?? const SizedBox.shrink(),
      errorWidget: (BuildContext? context, url, error) {
        if (errorWidget != null) {
          return errorWidget;
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Icon(Icons.error_outline, color: Colors.red, size: 40.h)],
        );
      },
    );
  }

  static Widget networkSvg(
    String assetName, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
  }) {
    return SvgPicture.network(
      assetName,
      height: height,
      width: width,
      color: color,
      fit: fit ?? BoxFit.cover,
    );
  }

  static Widget network(
    String url, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
    bool? isCoverImage,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
  }) {
    return Image.network(
      url,
      height: height,
      width: width,
      color: color,
      fit: fit ?? BoxFit.contain,
    );
  }

  static Widget lottie(
    String path, {
    double? height,
    double? width,
    Color? color,
    BoxFit? fit,
  }) {
    return Lottie.asset(path, height: height, width: width, fit: fit);
  }

  static Widget file(
    String path, {
    double? height,
    double? width,
    BoxFit? fit,
  }) {
    return Image.file(File(path), height: height, width: width, fit: fit);
  }
}
