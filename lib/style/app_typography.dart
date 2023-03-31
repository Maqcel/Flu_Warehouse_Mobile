import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  static const String fontFamily = 'Raleway';

  static final header1 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    height: 1.18,
  );

  static final header2 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    height: 1.18,
  );

  static final body1 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1.18,
  );

  static final body2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.18,
  );

  static final overline = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.18,
    decoration: TextDecoration.underline,
  );
}
