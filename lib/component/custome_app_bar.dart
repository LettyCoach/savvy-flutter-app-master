import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/view/scan_screen.dart';
import 'package:savvy/view/search_result_screen.dart';
import 'package:savvy/view_model/login_view_model.dart';

class CustomAppBar extends ConsumerWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(100.0),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModel);

    return AppBar(
      toolbarHeight: 100,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          child: TextButton(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(54),
              child: SizedBox.fromSize(
                child: Image.asset(
                  'assets/scan_mark.png',
                  width: 60,
                ),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ScannerPage()),
              );
            },
          ),
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appbar_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Image.asset(
          'assets/hamb.png',
          height: 18,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Row(
            children: [
              viewModel.getUserType == 'buyer'
                  ? GestureDetector(
                      child: Image.asset(
                        'assets/action_search.png',
                        width: 36,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchResultScreen()),
                        );
                      },
                    )
                  : Visibility(
                      visible: false,
                      child: Container(),
                    ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/action_book.png',
                  width: 36,
                ),
                onTap: () {},
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                child: Image.asset(
                  'assets/action_cart.png',
                  width: 36,
                ),
                onTap: () {},
              ),
            ],
          ),
        )
      ],
    );
  }
}
