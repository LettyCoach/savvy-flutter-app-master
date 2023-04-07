// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/component/brand_list.dart';
import 'package:savvy/component/brand_list_grid.dart';
import 'package:savvy/component/custome_app_bar.dart';
import 'package:savvy/component/custome_drawer.dart';
import 'package:savvy/component/follow_list_grid.dart';
import 'package:savvy/component/saved_list.dart';
import 'package:savvy/component/follow_list.dart';
import 'package:savvy/component/searc_follow_list.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  List searResult = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(productScreenViewModelProvider);

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
                  length: 3,
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
                                      ? Image.asset('assets/bookact.png')
                                      : Image.asset('assets/book.png'),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('保存アイテム'),
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
                                      ? Image.asset('assets/itemact.png')
                                      : Image.asset('assets/item.png'),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('ブランド一覧'),
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
                                  viewModel.getTabID == 2
                                      ? Image.asset('assets/heartact.png')
                                      : Image.asset('assets/heart.png'),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Text('フォロー中'),
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
                            Column(
                              children: [
                                Container(
                                  height: 16,
                                ),
                                Expanded(
                                  child: ListView(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        SavedItem(),
                                      ],
                                    )
                                  ]),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 70.w,
                                          height: 36,
                                          child: TextField(
                                              onChanged: (value) {},
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
                                                            .colorWhite),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .colorWhite,
                                                          style: BorderStyle
                                                              .solid)),
                                                  filled: true,
                                                  fillColor:
                                                      AppColors.colorWhite))),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.updateStatus(0);
                                              viewModel.getStatus;
                                            },
                                            child: viewModel.getStatus == 0
                                                ? Image.asset(
                                                    'assets/listview_act.png')
                                                : Image.asset(
                                                    'assets/listview.png'),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.updateStatus(1);
                                              viewModel.getStatus;
                                            },
                                            child: viewModel.getStatus == 0
                                                ? Image.asset(
                                                    'assets/gridview.png')
                                                : Image.asset(
                                                    'assets/gridview_act.png'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView(shrinkWrap: true, children: [
                                    viewModel.getStatus == 0
                                        ? const BrandList()
                                        : const BrandListGrid()
                                  ]),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          width: 70.w,
                                          height: 36,
                                          child: TextField(
                                              onChanged: (value) {
                                                var dataList = viewModel
                                                    .searchByKeyWords(value);
                                                if (value == '') {
                                                  viewModel
                                                      .updateIsSearchingState(
                                                          false);
                                                  setState(() {
                                                    searResult = dataList;
                                                  });
                                                } else {
                                                  setState(() {
                                                    viewModel
                                                        .updateIsSearchingState(
                                                            true);
                                                    searResult = dataList;
                                                  });
                                                }
                                              },
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
                                                            .colorWhite),
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .colorWhite,
                                                          style: BorderStyle
                                                              .solid)),
                                                  filled: true,
                                                  fillColor:
                                                      AppColors.colorWhite))),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.updateStatus(0);
                                            },
                                            child: viewModel.getStatus == 0
                                                ? Image.asset(
                                                    'assets/listview_act.png')
                                                : Image.asset(
                                                    'assets/listview.png'),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              viewModel.updateStatus(1);
                                            },
                                            child: viewModel.getStatus == 0
                                                ? Image.asset(
                                                    'assets/gridview.png')
                                                : Image.asset(
                                                    'assets/gridview_act.png'),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: viewModel.getIsSearching
                                      ? ListView(shrinkWrap: true, children: [
                                          viewModel.getStatus == 0
                                              ? SearchFollowList(
                                                  searchList: searResult,
                                                )
                                              : SearchFollowList(
                                                  searchList: searResult,
                                                )
                                        ])
                                      : ListView(shrinkWrap: true, children: [
                                          viewModel.getStatus == 0
                                              ? const FollowList()
                                              : const FollowListGrid()
                                        ]),
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
