import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _AppTextStyles {
  static const TextStyle medium = TextStyle(
    fontWeight: FontWeight.w500,
  );
  static const TextStyle boldItalic = TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle semiBold = TextStyle(
    fontWeight: FontWeight.w600,
  );

  static const TextStyle semiBoldItalic = TextStyle(
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.italic,
  );

  static const TextStyle regular = TextStyle(
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bold = TextStyle(
    fontWeight: FontWeight.w700,
  );

  static const TextStyle extraBold = TextStyle(
    fontWeight: FontWeight.w900,
  );
}

class AppTextStyles {
  // ************************* HEADINGS ***************************
  static TextStyle heading1ExtraBold42({Color? color, List<Shadow>? shadows}) =>
      _AppTextStyles.bold.copyWith(
        fontSize: 42,
        color: color,
        shadows: shadows,
      );

  static TextStyle heading1Bold32({
    Color? color,
    FontStyle fontStyle = FontStyle.normal,
  }) =>
      _AppTextStyles.bold.copyWith(
        fontSize: 32,
        color: color,
        fontStyle: fontStyle,
      );

  static TextStyle heading1Bold24({Color? color}) =>
      _AppTextStyles.bold.copyWith(fontSize: 24.sp, color: color);

  static TextStyle heading1ExtraBold24({Color? color, List<Shadow>? shadows}) =>
      _AppTextStyles.bold.copyWith(
        fontSize: 24.sp,
        color: color,
        shadows: shadows,
      );

  static TextStyle heading1ExtraBold20({Color? color, List<Shadow>? shadows}) =>
      _AppTextStyles.bold.copyWith(
        fontSize: 20.sp,
        color: color,
        shadows: shadows,
      );

  static TextStyle heading1BoldItalic24({Color? color}) =>
      _AppTextStyles.boldItalic.copyWith(fontSize: 24.sp, color: color);

  static TextStyle heading1SemiBoldItalic24({Color? color}) =>
      _AppTextStyles.semiBoldItalic.copyWith(fontSize: 24.sp, color: color);

  static TextStyle heading2SemiBoldItalic28({Color? color}) =>
      _AppTextStyles.semiBoldItalic.copyWith(fontSize: 28.sp, color: color);

  static TextStyle heading3SemiBold18({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(fontSize: 18.sp, color: color);

  static TextStyle heading3SemiBoldItalic18({Color? color}) =>
      _AppTextStyles.semiBoldItalic.copyWith(fontSize: 18.sp, color: color);

  static TextStyle heading4ExtraBold16({Color? color}) => _AppTextStyles.bold
      .copyWith(fontWeight: FontWeight.w800, fontSize: 14.sp, color: color);

  static TextStyle heading5SemiBold16({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(fontSize: 16.sp, color: color);

  // ************************* BODY ***************************
  static TextStyle body1Bold18({Color? color}) => _AppTextStyles.bold.copyWith(
        fontSize: 18.sp,
        color: color,
      );

  static TextStyle body1BoldItalic18({Color? color}) =>
      _AppTextStyles.boldItalic.copyWith(
        fontSize: 18.sp,
        color: color,
      );

  static TextStyle body2Bold16({Color? color}) => _AppTextStyles.bold.copyWith(
        fontSize: 16.sp,
        color: color,
      );

  static TextStyle body3Bold14({Color? color}) => _AppTextStyles.bold.copyWith(
        fontSize: 14.sp,
        color: color,
      );

  static TextStyle body4Bold12({Color? color}) => _AppTextStyles.bold.copyWith(
        fontSize: 12.sp,
        color: color,
      );

  static TextStyle body5ExtraBold10({Color? color}) =>
      _AppTextStyles.extraBold.copyWith(
        fontSize: 10.sp,
        color: color,
      );

  static TextStyle body5Bold10({Color? color}) => _AppTextStyles.bold.copyWith(
        fontSize: 10.sp,
        color: color,
      );

  static TextStyle body1SemiBold18({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(
        fontSize: 18.sp,
        color: color,
      );

  static TextStyle body2SemiBold16({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(
        fontSize: 16.sp,
        color: color,
      );

  static TextStyle body2SemiBoldItalic16({Color? color}) =>
      _AppTextStyles.semiBoldItalic.copyWith(
        fontSize: 16.sp,
        color: color,
      );

  static TextStyle body3SemiBold14({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(
        fontSize: 14.sp,
        color: color,
      );

  static TextStyle body3SemiBoldItalic14({Color? color}) =>
      _AppTextStyles.semiBoldItalic.copyWith(
        fontSize: 14.sp,
        color: color,
      );

  static TextStyle body4SemiBold12({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(
        fontSize: 12.sp,
        color: color,
      );

  static TextStyle body5SemiBold10({Color? color}) =>
      _AppTextStyles.semiBold.copyWith(
        fontSize: 10.sp,
        color: color,
      );

  static TextStyle body1Medium18({Color? color}) =>
      _AppTextStyles.medium.copyWith(
        fontSize: 18.sp,
        color: color,
      );

  static TextStyle body2Medium16({Color? color}) =>
      _AppTextStyles.medium.copyWith(
        fontSize: 16.sp,
        color: color,
      );

  static TextStyle body3Medium14({Color? color}) =>
      _AppTextStyles.medium.copyWith(
        fontSize: 14.sp,
        color: color,
      );

  static TextStyle body4Medium12({Color? color}) =>
      _AppTextStyles.medium.copyWith(
        fontSize: 12.sp,
        color: color,
      );

  static TextStyle body5Medium10({Color? color}) =>
      _AppTextStyles.medium.copyWith(
        fontSize: 10.sp,
        color: color,
      );

  static TextStyle body1Regular18({Color? color}) =>
      _AppTextStyles.regular.copyWith(
        fontSize: 18.sp,
        color: color,
      );

  static TextStyle body2Regular16({Color? color}) =>
      _AppTextStyles.regular.copyWith(
        fontSize: 16.sp,
        color: color,
      );

  static TextStyle body3Regular14({Color? color}) =>
      _AppTextStyles.regular.copyWith(
        fontSize: 14.sp,
        color: color,
      );

  static TextStyle body4Regular12({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      _AppTextStyles.regular.copyWith(
        fontSize: fontSize ?? 12.sp,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static TextStyle body5Regular10({Color? color}) =>
      _AppTextStyles.regular.copyWith(fontSize: 10.sp, color: color);

  static TextStyle body5Regular8({Color? color}) =>
      _AppTextStyles.regular.copyWith(fontSize: 8.sp, color: color);
}
