import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class FollowList extends ConsumerStatefulWidget {
  const FollowList({super.key});

  @override
  ConsumerState createState() => _FollowListState();
}

// ignore: must_be_immutable
class _FollowListState extends ConsumerState<FollowList> {
  @override
  void initState() {
    super.initState();
    final productScreenViewModel = ref.read(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    var url = Uri.parse('${Constants.baseUrl}api/buyer/getUserList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'buyer_id': viewModel.getUserId,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      productScreenViewModel.updateFollowedSupplierList(parsedJson);
      Future.delayed(const Duration(seconds: 1), () {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productScreenViewModel = ref.read(productScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    var url = Uri.parse('${Constants.baseUrl}api/buyer/getUserList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'buyer_id': viewModel.getUserId,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      productScreenViewModel.updateFollowedSupplierList(parsedJson);
      Future.delayed(const Duration(seconds: 1), () {});
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
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6, left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.colorWhite),
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: productScreenViewModel
                                          .getFollowedSupplierList[index]
                                      ['profile_url'] ==
                                  null
                              ? Image.asset(
                                  'assets/no_image.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  productScreenViewModel
                                          .getFollowedSupplierList[index]
                                      ['profile_url'],
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                        width: 160,
                        child: Text(
                          productScreenViewModel.getFollowedSupplierList[index]
                              ['name'],
                          style: TextStyle(
                            color: AppColors.basicColor,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    TextButton(
                        onPressed: productScreenViewModel
                                        .getFollowedSupplierList[index]
                                    ['supplyed'] ==
                                false
                            ? () {
                                var url = Uri.parse(
                                    '${Constants.baseUrl}api/buyer/setFollow');
                                http
                                    .post(url,
                                        headers: {
                                          "Content-Type": "application/json"
                                        },
                                        body: jsonEncode({
                                          'buyer_id': viewModel.getUserId,
                                          'supplyer_id': productScreenViewModel
                                                  .getFollowedSupplierList[
                                              index]['id']
                                        }))
                                    .then((response) {
                                  productScreenViewModel
                                      .updateIsSearchingState(false);
                                  didChangeDependencies();
                                });
                              }
                            : () {
                                var url = Uri.parse(
                                    '${Constants.baseUrl}api/buyer/unsetFollow');
                                http
                                    .post(url,
                                        headers: {
                                          "Content-Type": "application/json"
                                        },
                                        body: jsonEncode({
                                          'buyer_id': viewModel.getUserId,
                                          'supplyer_id': productScreenViewModel
                                                  .getFollowedSupplierList[
                                              index]['id']
                                        }))
                                    .then((response) {
                                  productScreenViewModel
                                      .updateIsSearchingState(false);
                                  didChangeDependencies();
                                });
                              },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: SizedBox(
                              child: productScreenViewModel
                                          .getFollowedSupplierList[index]
                                      ['supplyed']
                                  ? Image.asset(
                                      'assets/favor.png',
                                      width: 30,
                                      height: 30,
                                    )
                                  : Image.asset(
                                      'assets/favor_normal.png',
                                      width: 30,
                                      height: 30,
                                    )),
                        )),
                    productScreenViewModel.getFollowedSupplierList[index]
                            ['supplyAccepted']
                        ? Icon(
                            Icons.done,
                            color: AppColors.doneColor,
                            size: 14,
                          )
                        : const SizedBox(
                            width: 14,
                          )
                  ],
                ),
              )
            ],
          ),
        );
      },
      itemCount: productScreenViewModel.getFollowedSupplierList.length,
    );
  }
}
