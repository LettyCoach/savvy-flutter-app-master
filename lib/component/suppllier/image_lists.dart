import 'package:flutter/material.dart';

class ImageGrid extends StatelessWidget {
  final List<String> imgListData;

  const ImageGrid({super.key, required this.imgListData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          for (int x = 0;
              x < (imgListData.length > 6 ? 6 : imgListData.length);
              x++) ...[
            SizedBox(
              width: 32,
              height: 32,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  imgListData[x],
                  width: 32,
                  height: 32,
                ),
              ),
            )
          ],
        ],
      ),
    );
  }
}
