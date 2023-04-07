import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:savvy/component/search_list.dart';
import 'package:savvy/theme/app_colors.dart';

class SearchResultScreen extends ConsumerWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: AppColors.productScreenBG,
        appBar: AppBar(
            title: const Text(
              'パスワード再発行',
              style: TextStyle(
                  color: Color(0xFF4C566B),
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.colorWhite,
            iconTheme: const IconThemeData(
              color: Color(0xFF4C566B),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            )),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Center(
              child: ListView(
            children: const [
              SizedBox(
                height: 20,
              ),
              SearchList()
            ],
          ));
        }));
  }
}
