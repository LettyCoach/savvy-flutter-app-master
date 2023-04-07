import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';

class SearchList extends ConsumerStatefulWidget {
  const SearchList({super.key});

  @override
  ConsumerState<SearchList> createState() => _SearchListState();
}

// ignore: must_be_immutable
class _SearchListState extends ConsumerState<SearchList> {
  @override
  void initState() {
    super.initState();
    final productScreenViewModel = ref.read(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    getListData(viewModel, productScreenViewModel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productScreenViewModel = ref.read(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    getListData(viewModel, productScreenViewModel);
  }

  void getListData(viewModel, productScreenViewModel) {
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
      productScreenViewModel.updateSearchResultList(parsedJson);
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final productScreenViewModel = ref.watch(productScreenViewModelProvider);
    final viewModel = ref.watch(loginViewModel);

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
                            productScreenViewModel.getSearchResultList[index]
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
                          width: 180,
                          child: Text(
                            productScreenViewModel.getSearchResultList[index]
                                ['name'],
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.listTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                        Text(
                          productScreenViewModel.getSearchResultList[index]
                              ['brandName'],
                          style: TextStyle(
                              color: AppColors.listDescColor, fontSize: 14),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    productScreenViewModel.getSearchResultList[index]
                            ['isFavorite']
                        ? GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/favor.png',
                              fit: BoxFit.fitWidth,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {},
                            child: Image.asset(
                              'assets/favor_normal.png',
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                    const SizedBox(
                      width: 14,
                    ),
                    productScreenViewModel.getSearchResultList[index]['isSaved']
                        ? Image.asset(
                            'assets/ordered.png',
                            fit: BoxFit.fitWidth,
                          )
                        : GestureDetector(
                            onTap: () {
                              var url = Uri.parse(
                                  '${Constants.baseUrl}api/products/addSaveItem');
                              http
                                  .post(url,
                                      headers: {
                                        "Content-Type": "application/json"
                                      },
                                      body: jsonEncode({
                                        'user_id': viewModel.getUserId,
                                        'product_id': productScreenViewModel
                                            .getSearchResultList[index]['id'],
                                      }))
                                  .then((response) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                getListData(viewModel, productScreenViewModel);
                                Future.delayed(const Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                });
                              });
                            },
                            child: Image.asset(
                              'assets/order.png',
                              fit: BoxFit.fitWidth,
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: productScreenViewModel.getSearchResultList.length,
    );
  }
}
