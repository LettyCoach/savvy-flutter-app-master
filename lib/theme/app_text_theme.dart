import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app_fonts.dart';

class AppTextTheme {
  static TextStyle textH1 = GoogleFonts.notoSans(
    fontSize: FontSize.pt13.sp,
    height: 1.4,
  );

  static TextStyle textH2 = GoogleFonts.notoSans(
    fontSize: FontSize.pt11.sp,
    height: 1.4,
  );

  static TextStyle textH3 = GoogleFonts.notoSans(
    fontSize: FontSize.pt10.sp,
    height: 1.3,
  );

  static TextStyle textH3Bold = GoogleFonts.notoSans(
    fontSize: FontSize.pt10.sp,
    height: 1.4,
    fontWeight: FontWeight.bold,
  );

  static TextStyle textH4 = GoogleFonts.notoSans(
    fontSize: FontSize.pt8.sp,
    height: 1.3,
  );

  static TextStyle textH5 = GoogleFonts.notoSans(
    fontSize: FontSize.pt7.sp,
    height: 1.2,
  );
}
