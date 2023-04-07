import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/product_screen_view_model.dart';
import 'package:sizer/sizer.dart';

class MitsumoriList extends ConsumerStatefulWidget {
  const MitsumoriList({super.key});

  @override
  ConsumerState<MitsumoriList> createState() => _MitsumoriListState();
}

class _MitsumoriListState extends ConsumerState<MitsumoriList> {
  final priceController = TextEditingController();
  final amountController = TextEditingController();
  final barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    amountController.dispose();
    barcodeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(productScreenViewModelProvider);

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 90),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 6, left: 12, right: 12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.colorWhite),
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            viewModel.getMitsumori_list[index].imgUrl,
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
                          width: (100.w - 180),
                          child: Text(
                            viewModel.getMitsumori_list[index].name,
                            maxLines: 2,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.colorBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                        Text(
                          viewModel.getMitsumori_list[index].price.toString(),
                          style: TextStyle(
                              color: AppColors.basicColor, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        '小計',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      )),
                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: TextFormField(
                          controller: amountController
                            ..text = viewModel.getMitsumori_list[index].amount
                                .toString(),
                          onChanged: (value) {
                            if (value != '') {
                              for (var i = 0;
                                  i < viewModel.getMitsumori_list.length;
                                  i++) {
                                if (viewModel.getMitsumori_list[i].barcode ==
                                    barcodeController.text) {
                                  viewModel.getMitsumori_list[i].amount =
                                      int.parse(value);
                                }
                              }
                              viewModel.updateTotalItemsAndPrice();
                            }
                          },
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 0,
                      ),
                      Visibility(
                          visible: false,
                          child: TextFormField(
                            controller: barcodeController
                              ..text =
                                  viewModel.getMitsumori_list[index].barcode,
                          )),
                      SizedBox(
                          width: 60,
                          child: Text(
                            (viewModel.getMitsumori_list[index].amount *
                                    viewModel.getMitsumori_list[index].price)
                                .toString(),
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ))
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
      itemCount: viewModel.getMitsumori_list.length,
    );
  }
}
