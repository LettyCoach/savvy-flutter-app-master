import 'package:flutter/material.dart';
import 'package:savvy/theme/app_colors.dart';

// ignore: must_be_immutable
class ItemGrid extends StatelessWidget {
  List data = [
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    },
    {
      'title': 'オフィスデザイン オフィスデザインオフィスデザインオフィスデザインオフィスデザイン',
      'desc': 'オフィスデザイン',
      'image': 'https://picsum.photos/250?image=9',
    }
  ];

  ItemGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.only(left: 20, right: 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColors.colorWhite),
                    padding: const EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(38),
                      child: SizedBox(
                        width: 76,
                        height: 76,
                        child: Image.network(
                          data[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    data[index]['title'],
                    maxLines: 1,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: AppColors.listTitleColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ));
        },
        itemCount: data.length);
  }
}
