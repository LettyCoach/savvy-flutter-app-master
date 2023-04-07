import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/component/dialog.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/model/scan_data.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/scan_screen_view_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:scan/scan.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class ScannerPage extends ConsumerWidget {
  ScannerPage({super.key});
  ScanController controller = ScanController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(scanScreenViewModel);
    final loginViewModelProvoder = ref.watch(loginViewModel);

    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: ScanView(
                controller: controller,
                scanAreaScale: .7,
                scanLineColor: AppColors.colorWhite,
                onCapture: (data) async {
                  controller.pause();
                  viewModel.updateBarcode(data);

                  var url = Uri.parse(
                      '${Constants.baseUrl}api/products/getByBarcode');
                  var response = await http.post(url,
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({
                        'user_id': loginViewModelProvoder.getUserId,
                        'user_type': loginViewModelProvoder.getUserType,
                        'barcode': data,
                      }));
                  if (response.statusCode == 200) {
                    var parsedJson = jsonDecode(response.body);
                    if (parsedJson['id'] == 0) {
                      var snackBar = const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('商品情報が存在しません。'));
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pop(context);
                      });
                    } else {
                      try {
                        var data = ScanData.fromJson(parsedJson);
                        viewModel.updateScanProductData(data);

                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          builder: (ctx) => const CustomDialogBox(),
                        );
                      } catch (e) {
                        controller.pause();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      }
                    }
                  } else {
                    var snackBar = const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('操作が失敗しました。'));
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
            top: 36,
            left: 16,
            child: GestureDetector(
              onTap: () {
                controller.pause();
                Navigator.of(context).pop();
              },
              child: Image.asset('assets/close.png'),
            )),
        Positioned(
            top: 40,
            right: 16,
            child: GestureDetector(
              onTap: () {
                controller.pause();
                controller.toggleTorchMode();
              },
              child: Image.asset('assets/thunder.png'),
            )),
        Positioned(
            bottom: 40,
            right: 50.w - 30,
            child: GestureDetector(
              onTap: () {
                controller.resume();
              },
              child: Image.asset('assets/scan_mark.png'),
            )),
      ],
    ));
  }
}
