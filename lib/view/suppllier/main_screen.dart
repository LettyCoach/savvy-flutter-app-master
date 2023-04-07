import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/component/custome_app_bar.dart';
import 'package:savvy/component/custome_drawer.dart';
import 'package:savvy/component/suppllier/follow_list.dart';
import 'package:savvy/component/suppllier/order_list.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/supplier_screen_view_model.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SPMainScreen extends ConsumerWidget {
  const SPMainScreen({super.key});

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(supplierScreenViewModelProvider);

    return Scaffold(
        backgroundColor: AppColors.productScreenBG,
        drawer: const CustomDrawer(),
        appBar: CustomAppBar(),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Stack(
            children: [
              Center(
                  child: SafeArea(
                child: DefaultTabController(
                  length: 2,
                  initialIndex: viewModel.getTabID,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.w - 40,
                        height: 46,
                        margin: const EdgeInsets.only(top: 20),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.colorBlack),
                        child: TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          indicator: BoxDecoration(
                            border: Border.all(color: AppColors.colorWhite),
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.colorWhite,
                          ),
                          unselectedLabelStyle:
                              const TextStyle(color: Colors.white),
                          labelColor: AppColors.markColor,
                          unselectedLabelColor: AppColors.colorWhite,
                          labelStyle: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          labelPadding: const EdgeInsets.only(left: 6),
                          onTap: (value) {
                            viewModel.updateTabID(value);
                          },
                          tabs: [
                            Tab(
                              icon: Flex(
                                direction: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  viewModel.getTabID == 0
                                      ? Image.asset('assets/follow_act.png')
                                      : Image.asset('assets/follow.png'),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('オーダー一覧'),
                                  )
                                ],
                              ),
                            ),
                            Tab(
                              icon: Flex(
                                direction: Axis.horizontal,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  viewModel.getTabID == 1
                                      ? Image.asset('assets/man_act.png')
                                      : Image.asset('assets/man.png'),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('フォロワー一覧'),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                  color: AppColors.colorWhite,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            viewModel.updateStatus(0);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 4),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: viewModel
                                                                .getStatus ==
                                                            0
                                                        ? AppColors.activeColor
                                                        : AppColors.colorWhite),
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  transformAlignment:
                                                      Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  4)),
                                                      color: AppColors
                                                          .textActiveBg),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 4,
                                                        horizontal: 8),
                                                    child: Text(
                                                      '4',
                                                      style: TextStyle(
                                                          color: AppColors
                                                              .activeColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text('オーダー数',
                                                    style: TextStyle(
                                                        color: viewModel
                                                                    .getStatus ==
                                                                0
                                                            ? AppColors
                                                                .activeColor
                                                            : AppColors
                                                                .textDeActiveColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700))
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 4),
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                    width: 2,
                                                    color: viewModel
                                                                .getStatus ==
                                                            1
                                                        ? AppColors.activeColor
                                                        : AppColors.colorWhite),
                                              ),
                                            ),
                                            child: viewModel.getStatus == 1
                                                ? Text('保存',
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.activeColor,
                                                      fontSize: 14,
                                                    ))
                                                : Text('保存',
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .textDeActiveColor,
                                                      fontSize: 14,
                                                    )),
                                          ),
                                          onTap: () {
                                            viewModel.updateStatus(1);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    padding: const EdgeInsets.all(20),
                                    child: SizedBox(
                                        width: 100.w,
                                        height: 36,
                                        child: TextField(
                                            enabled: true,
                                            textAlign: TextAlign.start,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.search,
                                                  color: AppColors.basicColor,
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.all(4),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  borderSide: BorderSide(
                                                      width: 1,
                                                      color: AppColors
                                                          .mainScreenBorderColor),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    borderSide: BorderSide(
                                                        color: AppColors
                                                            .colorWhite,
                                                        style:
                                                            BorderStyle.solid)),
                                                filled: true,
                                                fillColor:
                                                    AppColors.colorWhite))),
                                  ),
                                  Expanded(
                                    child: ListView(
                                        shrinkWrap: true,
                                        children: [OrderList()]),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Expanded(
                                  child: ListView(
                                      shrinkWrap: true,
                                      children: const [FollowList()]),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          );
        }));
  }
}
