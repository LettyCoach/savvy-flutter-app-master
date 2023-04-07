import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view/scan_result_screen.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';
import 'package:savvy/view_model/scan_screen_view_model.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:savvy/view_model/login_view_model.dart';

class CustomDialogBox extends ConsumerStatefulWidget {
  const CustomDialogBox({super.key});

  @override
  ConsumerState<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends ConsumerState<CustomDialogBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(scanScreenViewModel);
    final productViewModel = ref.watch(productScreenViewModelProvider);
    final loginViewModelProvider = ref.read(loginViewModel);
    var imgUrl = viewModel.getScranProductData.imgUrl;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(left: 12, top: 24, right: 12, bottom: 16),
            margin: const EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 4,
                ),
                Image.network(
                  imgUrl,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.getScranProductData.name,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.basicColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'コスト：${viewModel.getScranProductData.price.toString()}',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.basicColor,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(AppColors.activeColor)),
                      onPressed: () {
                        if (!productViewModel.getMitsumoriBarcodeList
                            .contains(viewModel.getBarcode)) {
                          productViewModel
                              .updateMitsumoriBarcodeList(viewModel.getBarcode);

                          productViewModel.addItemToMitsumoriList(
                              viewModel.getScranProductData);
                          viewModel.updateClickedState();
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ScanResultScreen()),
                          );
                        } else {
                          var snackBar = const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('すでに商品情報が存在します。'));
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ScanResultScreen()),
                            );
                          });
                        }

                        viewModel.updateBarcode('');
                        productViewModel.updateTotalItemsAndPrice();
                      },
                      child: Text(
                        '見積りに追加',
                        style: TextStyle(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.amber[800])),
                      onPressed: () {
                        var url = Uri.parse(
                            '${Constants.baseUrl}api/products/addSaveItem');
                        http
                            .post(url,
                                headers: {"Content-Type": "application/json"},
                                body: jsonEncode({
                                  'user_id': loginViewModelProvider.getUserId,
                                  'product_id': viewModel.getScranProductData.id
                                }))
                            .then((response) {
                          didChangeDependencies();
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pop(context);
                          });
                        });
                      },
                      child: const Text(
                        '保存アイテムに追加',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Positioned(
            left: 20,
            right: 20,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 45,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
