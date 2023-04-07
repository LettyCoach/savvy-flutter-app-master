import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:savvy/component/mitsumori_list.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ScanResultScreen extends ConsumerStatefulWidget {
  const ScanResultScreen({super.key});

  @override
  ConsumerState<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends ConsumerState<ScanResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(productScreenViewModelProvider);

    return Scaffold(
        backgroundColor: AppColors.productScreenBG,
        appBar: AppBar(
            title: const Text(
              '見積り /インボイス依頼',
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
          return Stack(
            children: [
              ListView(
                physics: const ScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  MitsumoriList()
                ],
              ),
              Positioned(
                right: 0,
                bottom: 0,
                left: 0,
                child: Container(
                  width: 100.w,
                  height: 60,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () async {
                          var url = Uri.parse(
                              '${Constants.baseUrl}api/products/makeInvoice');
                          var response = await http.post(url,
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode(viewModel.getMitsumori_list));

                          var parsedJson = jsonDecode(response.body);
                          launchURL(parsedJson['pdf_url']);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                AppColors.activeColor)),
                        child: Text(
                          '見積り /インボイス依頼',
                          style: TextStyle(
                              color: AppColors.colorWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${viewModel.getSumItemCounts}点',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${viewModel.getSumPrice}円',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
