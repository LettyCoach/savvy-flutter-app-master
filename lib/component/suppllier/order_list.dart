import 'package:flutter/material.dart';
import 'package:savvy/component/suppllier/image_lists.dart';
import 'package:savvy/theme/app_colors.dart';

// ignore: must_be_immutable
class OrderList extends StatelessWidget {
  List data = [
    {
      'user_name': 'lovely Thing',
      'total_price': "\$190",
      'avart': 'https://picsum.photos/250?image=9',
      'order_items': [
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
      ],
      'has_more': true,
      'save': true
    },
    {
      'user_name': 'lovely Thing',
      'total_price': "\$190",
      'avart': 'https://picsum.photos/250?image=9',
      'order_items': [
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
      ],
      'has_more': true,
      'save': true
    },
    {
      'user_name': 'lovely Thing',
      'total_price': "\$190",
      'avart': 'https://picsum.photos/250?image=9',
      'order_items': [
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
        'https://picsum.photos/250?image=9',
      ],
      'has_more': true,
      'save': false
    }
  ];
  OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 90),
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(color: AppColors.colorWhite),
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Flex(
                        direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  data[index]['avart'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  data[index]['user_name'],
                                  maxLines: 1,
                                  style: TextStyle(
                                      height: 1.4,
                                      overflow: TextOverflow.ellipsis,
                                      color: AppColors.listTitleColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                              Text(
                                'Item total: ${data[index]['total_price']}',
                                style: TextStyle(
                                    height: 1.4,
                                    color: AppColors.listDescColor,
                                    fontSize: 14),
                              ),
                              Text(
                                'テックガジェット',
                                style: TextStyle(
                                    height: 1.2,
                                    color: AppColors.listDescColor,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      ImageGrid(
                                        imgListData: data[index]['order_items'],
                                      )
                                    ],
                                  ),
                                  data[index]['has_more']
                                      ? Image.asset('assets/more_item.png')
                                      : Visibility(
                                          visible: false,
                                          child: Container(),
                                        )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: data[index]['save']
                          ? Image.asset(
                              'assets/ordered.png',
                              fit: BoxFit.fitWidth,
                            )
                          : Image.asset(
                              'assets/order.png',
                              fit: BoxFit.fitWidth,
                            ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Divider(
                    color: AppColors.mainScreenBorderColor,
                    thickness: 1,
                  ),
                )
              ],
            ));
      },
      itemCount: data.length,
    );
  }
}
