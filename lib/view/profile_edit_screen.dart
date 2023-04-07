import 'dart:async';
import 'dart:io';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

const List<String> countryList = <String>['選ぶ', 'One', 'Two', 'Three', 'Four'];

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  File? image;
  String dropdownValue = countryList.first;

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        final imageTemp = File(image.path);
        setState(() => this.image = imageTemp);
      } catch (e) {
        // ignore: avoid_print
        print('Failed to pick image: $e');
      }
    }

    return Scaffold(
        backgroundColor: AppColors.basicColor,
        appBar: AppBar(
            title: Text(
              '新規登録',
              style: TextStyle(
                  color: AppColors.colorWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.basicColor,
            iconTheme: const IconThemeData(
              color: Colors.white,
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
            children: [
              SizedBox(
                width: 100.w,
                child: Container(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.basicBorderColor,
                        width: 1.0,
                      ),
                      bottom: BorderSide(
                        color: AppColors.basicBorderColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text('すでに登録済の方は、こちら',
                          style: TextStyle(
                              color: Colors.transparent,
                              shadows: [
                                Shadow(
                                    offset: const Offset(0, -2),
                                    color: AppColors.colorWhite)
                              ],
                              decoration: TextDecoration.underline,
                              fontSize: 18,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      IconButton(
                        iconSize: 80,
                        icon: image == null
                            ? Image.asset(
                                "assets/avarta.png",
                                fit: BoxFit.fitWidth,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(80),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                        onPressed: () {
                          pickImage();
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 60.w,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ショップ名ユーザ名',
                                        hintStyle: TextStyle(
                                            color: AppColors.colorWhite,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                    style: TextStyle(
                                        color: AppColors.colorWhite,
                                        fontSize: 18),
                                  ),
                                ),
                                Text(
                                  'アバターを選択ショ',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: AppColors.basicBorderColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                )
                              ]))
                    ],
                  )
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                'メールアドレス',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/envelop.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '名',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/user.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '姓',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/user.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '企業名',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/bussiness.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '国名',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          width: 100.w - 40,
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.colorBlack,
                            isExpanded: true,
                            value: dropdownValue,
                            icon: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  size: 10,
                                  Icons.arrow_back_ios,
                                  color: AppColors.colorWhite,
                                  textDirection: TextDirection.rtl,
                                )),
                            elevation: 16,
                            style: TextStyle(
                                color: AppColors.colorWhite, fontSize: 16),
                            underline: Container(
                              height: 1,
                              color: AppColors.basicBorderColor,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: countryList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '住所',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/local.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                'ショップ（ブランド名）',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/booking.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                'ショップ（URL）',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/world.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Text(
                                '電話番号',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 16),
                              ),
                              const Text(
                                '*',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 16),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          width: 100.w - 40,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.basicBorderColor,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                'assets/phone.png',
                                fit: BoxFit.fitWidth,
                                height: 36,
                              ),
                              Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  style: TextStyle(
                                      color: AppColors.colorWhite,
                                      fontSize: 16),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 16, bottom: 36),
                          child: SizedBox(
                            width: 100.w - 40,
                            child: Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: AppColors.activeColor,
                                  minimumSize: Size(80.w, 40),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                ),
                                onPressed: () => context.go('/product'),
                                child: Text('新規登録',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.colorWhite,
                                        decoration: TextDecoration.none)),
                              ),
                            ),
                          )),
                    ],
                  )
                ],
              )
            ],
          ));
        }));
  }
}
