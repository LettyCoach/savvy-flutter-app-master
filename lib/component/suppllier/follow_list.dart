import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:flutter_switch/flutter_switch.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/supplier_screen_view_model.dart';

// ignore: must_be_immutable
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
    final supplierScreenViewModel = ref.read(supplierScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    var url = Uri.parse('${Constants.baseUrl}api/supplyer/getFollowedList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'supplyer_id': viewModel.getUserId,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      supplierScreenViewModel.updateFollowedBuyerList(parsedJson);
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final supplierScreenViewModel = ref.read(supplierScreenViewModelProvider);
    final viewModel = ref.read(loginViewModel);
    var url = Uri.parse('${Constants.baseUrl}api/supplyer/getFollowedList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'supplyer_id': viewModel.getUserId,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      supplierScreenViewModel.updateFollowedBuyerList(parsedJson);
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final supplierScreenViewModel = ref.watch(supplierScreenViewModelProvider);
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
                          child: supplierScreenViewModel
                                          .getFollowedBuyerList[index]
                                      ['profile_url'] ==
                                  null
                              ? Image.asset(
                                  'assets/no_image.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  supplierScreenViewModel
                                          .getFollowedBuyerList[index]
                                      ['profile_url'],
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
                          width: 160,
                          child: Text(
                            supplierScreenViewModel.getFollowedBuyerList[index]
                                ['name'],
                            maxLines: 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.listTitleColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Text(
                            supplierScreenViewModel.getFollowedBuyerList[index]
                                ['full_name'],
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.listDescColor,
                                fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              FlutterSwitch(
                width: 64.0,
                height: 32.0,
                toggleSize: 32.0,
                value: supplierScreenViewModel.getFollowedBuyerList[index]
                    ['isAccepted'],
                borderRadius: 32.0,
                padding: 2.0,
                toggleColor: AppColors.colorWhite,
                activeColor: AppColors.activeColor,
                inactiveColor: AppColors.mainScreenBorderColor,
                onToggle: (val) {
                  if (!val) {
                    var url = Uri.parse(
                        '${Constants.baseUrl}api/supplyer/setFollowAccept');
                    http
                        .post(url,
                            headers: {"Content-Type": "application/json"},
                            body: jsonEncode({
                              'supplyer_id': viewModel.getUserId,
                              'buyer_id': supplierScreenViewModel
                                  .getFollowedBuyerList[index]['id']
                            }))
                        .then((response) {
                      didChangeDependencies();
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
      itemCount: supplierScreenViewModel.getFollowedBuyerList.length,
    );
  }
}
