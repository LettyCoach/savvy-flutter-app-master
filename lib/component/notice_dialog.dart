import 'package:flutter/material.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class NoticeDialog extends StatelessWidget {
  const NoticeDialog({super.key});

  dialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            CrossAxisAlignment.start, // To make the card compact
        children: <Widget>[
          const Text(
            "おめでとうございま",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24.0, fontWeight: FontWeight.w700, height: 3),
          ),
          Text(
            "管理者から30ポイントの無料ポイントを受け取りました",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: AppColors.deactiveColor),
          ),
          const SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      color: AppColors.activeColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 40),
                      child: Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      )),
                )),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
