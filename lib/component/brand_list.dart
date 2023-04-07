import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';

class BrandList extends ConsumerStatefulWidget {
  const BrandList({super.key});

  @override
  ConsumerState<BrandList> createState() => _BrandListState();
}

// ignore: must_be_immutable
class _BrandListState extends ConsumerState<BrandList> {
  @override
  void initState() {
    super.initState();
    final productScreenViewModel = ref.read(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    var url = Uri.parse('${Constants.baseUrl}api/products/getList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'user_id': viewModel.getUserId,
              // 'user_id': 2,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      productScreenViewModel.updateBrandList(parsedJson);
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productScreenViewModel = ref.read(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    var url = Uri.parse('${Constants.baseUrl}api/products/getList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'user_id': viewModel.getUserId,
              // 'user_id': 2,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      productScreenViewModel.updateBrandList(parsedJson);
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final productScreenViewModel = ref.watch(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 90),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.colorWhite),
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      width: 52,
                      height: 52,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(52),
                        child: SizedBox(
                          width: 52,
                          height: 52,
                          child: Image.network(
                            productScreenViewModel.getBrandList[index]
                                ['img_url'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            productScreenViewModel.getBrandList[index]['name'],
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.listTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                        Text(
                          productScreenViewModel.getBrandList[index]
                              ['brandName'],
                          style: TextStyle(
                              color: AppColors.listDescColor, fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 23,
                    ),
                    GestureDetector(
                        onTap: () {
                          var url = Uri.parse(
                              '${Constants.baseUrl}api/products/addSaveItem');
                          http
                              .post(url,
                                  headers: {"Content-Type": "application/json"},
                                  body: jsonEncode({
                                    'user_id': viewModel.getUserId,
                                    'product_id': productScreenViewModel
                                        .getBrandList[index]['id']
                                  }))
                              .then((response) {
                            didChangeDependencies();
                          });
                        },
                        child: productScreenViewModel.getBrandList[index]
                                ['isSaved']
                            ? Image.asset(
                                'assets/favor.png',
                                fit: BoxFit.fitWidth,
                              )
                            : Image.asset(
                                'assets/favor_normal.png',
                                fit: BoxFit.fitWidth,
                              )),
                    const SizedBox(
                      width: 14,
                    ),
                    // GestureDetector(
                    //   onTap: () {},
                    //   child: Image.asset(
                    //     'assets/check.png',
                    //     fit: BoxFit.fitWidth,
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: productScreenViewModel.getBrandList.length,
    );
  }
}
