import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class SavedItem extends ConsumerStatefulWidget {
  const SavedItem({super.key});

  @override
  ConsumerState<SavedItem> createState() => _SavedItemState();
}

// ignore: must_be_immutable
class _SavedItemState extends ConsumerState<SavedItem> {
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
    var url = Uri.parse('${Constants.baseUrl}api/products/getSaveItemList');
    http
        .post(url,
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              'user_id': viewModel.getUserId,
            }))
        .then((response) {
      var parsedJson = jsonDecode(response.body);
      productScreenViewModel.updateBuyerSavedItemList(parsedJson);
      Future.delayed(const Duration(seconds: 2), () {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(productScreenViewModelProvider);

    return GridView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 20, right: 20),
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 1),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {},
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        viewModel.getBuyerSavedItemList[index]['img_url']),
                    fit: BoxFit.cover,
                  ),
                ),
              ));
        },
        itemCount: viewModel.getBuyerSavedItemList.length);
  }
}
