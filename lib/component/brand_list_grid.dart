import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';

class BrandListGrid extends ConsumerStatefulWidget {
  const BrandListGrid({super.key});

  @override
  ConsumerState<BrandListGrid> createState() => _BrandListGridState();
}

// ignore: must_be_immutable
class _BrandListGridState extends ConsumerState<BrandListGrid> {
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
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.colorWhite),
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(38),
                      child: SizedBox(
                        width: 76,
                        height: 76,
                        child: Image.network(
                          productScreenViewModel.getBrandList[index]['img_url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    productScreenViewModel.getBrandList[index]['name'],
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.listTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ));
        },
        itemCount: productScreenViewModel.getBrandList.length);
  }
}
