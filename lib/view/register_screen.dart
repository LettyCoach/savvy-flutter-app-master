import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';

import 'package:flutter/material.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/custom_extention.dart';
import 'package:savvy/theme/app_colors.dart';
import 'package:savvy/view_model/login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:custom_check_box/custom_check_box.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// const List<String> countryList = <String>['選ぶ', 'One', 'Two', 'Three', 'Four'];

// ignore: must_be_immutable
class RegisterScreen extends ConsumerWidget {
  RegisterScreen({super.key});
  // String dropdownValue = countryList.first;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(loginViewModel);
    final ImagePickerPlatform picker = ImagePickerPlatform.instance;

    Future pickImage() async {
      try {
        final image = await picker.pickImage(source: ImageSource.camera);
        if (image == null) return;
        final imageTemp = File(image.path);
        viewModel.updateAvartaImage(imageTemp);
      } catch (e) {
        // ignore: avoid_print
        print('Failed to pick image: $e');
      }
    }

    final _formKey = GlobalKey<FormState>();

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
                        'assets/sm_logo.png',
                        height: 87,
                        width: 145,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                          onPressed: () {
                            context.go('/login');
                          },
                          child: Text('すでに登録済の方は、こちら',
                              style: TextStyle(
                                color: Colors.transparent,
                                shadows: [
                                  Shadow(
                                      offset: const Offset(0, -2),
                                      color: AppColors.colorWhite)
                                ],
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.colorWhite,
                                fontSize: 16,
                              )))
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
                        icon: viewModel.getAvartaImage == null
                            ? Image.asset(
                                "assets/avarta.png",
                                fit: BoxFit.fitWidth,
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(80),
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(80),
                                  child: Image.file(
                                    viewModel.getAvartaImage!,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                        onPressed: () {
                          pickImage();
                        },
                      ),
                    ],
                  )
                ]),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      'メールアドレス',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      child: TextFormField(
                                        controller: mailController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          } else if (!EmailValidationExtention
                                              .isValid(data: value)) {
                                            return 'メールの形式が正しくありません。';
                                          } else {
                                            return null;
                                          }
                                        },
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      '名',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      child: TextFormField(
                                        controller: firstNameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          }
                                          return null;
                                        },
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      '姓',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      child: TextFormField(
                                        controller: lastNameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          }
                                          return null;
                                        },
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      '郵便番号',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      child: TextFormField(
                                        controller: zipcodeController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          }
                                          return null;
                                        },
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
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 20, right: 20),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Text(
                            //           '企業名',
                            //           style: TextStyle(
                            //               color: AppColors.colorWhite, fontSize: 16),
                            //         ),
                            //         const Text(
                            //           '*',
                            //           style:
                            //               TextStyle(color: Colors.red, fontSize: 16),
                            //         )
                            //       ],
                            //     )),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20, right: 20),
                            //   child: Container(
                            //     width: 100.w - 40,
                            //     decoration: BoxDecoration(
                            //       border: Border(
                            //         bottom: BorderSide(
                            //           color: AppColors.basicBorderColor,
                            //           width: 1.0,
                            //         ),
                            //       ),
                            //     ),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Image.asset(
                            //           'assets/bussiness.png',
                            //           fit: BoxFit.fitWidth,
                            //           height: 36,
                            //         ),
                            //         Expanded(
                            //             child: Padding(
                            //           padding: const EdgeInsets.only(left: 6),
                            //           child: TextFormField(
                            //             decoration: const InputDecoration(
                            //               border: InputBorder.none,
                            //             ),
                            //             style: TextStyle(
                            //                 color: AppColors.colorWhite,
                            //                 fontSize: 16),
                            //           ),
                            //         ))
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 20, right: 20),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Text(
                            //           '国名',
                            //           style: TextStyle(
                            //               color: AppColors.colorWhite, fontSize: 16),
                            //         ),
                            //         const Text(
                            //           '*',
                            //           style:
                            //               TextStyle(color: Colors.red, fontSize: 16),
                            //         )
                            //       ],
                            //     )),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20, right: 20),
                            //   child: SizedBox(
                            //     width: 100.w - 40,
                            //     child: DropdownButton<String>(
                            //       dropdownColor: AppColors.colorBlack,
                            //       isExpanded: true,
                            //       value: dropdownValue,
                            //       icon: Align(
                            //           alignment: Alignment.centerRight,
                            //           child: Icon(
                            //             size: 10,
                            //             Icons.arrow_back_ios,
                            //             color: AppColors.colorWhite,
                            //             textDirection: TextDirection.rtl,
                            //           )),
                            //       elevation: 16,
                            //       style: TextStyle(
                            //           color: AppColors.colorWhite, fontSize: 16),
                            //       underline: Container(
                            //         height: 1,
                            //         color: AppColors.basicBorderColor,
                            //       ),
                            //       onChanged: (String? value) {
                            //         setState(() {
                            //           dropdownValue = value!;
                            //         });
                            //       },
                            //       items: countryList
                            //           .map<DropdownMenuItem<String>>((String value) {
                            //         return DropdownMenuItem<String>(
                            //           value: value,
                            //           child: Text(
                            //             value,
                            //           ),
                            //         );
                            //       }).toList(),
                            //     ),
                            //   ),
                            // ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      '住所',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      child: TextFormField(
                                        controller: addressController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          }
                                          return null;
                                        },
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
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 20, right: 20),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Text(
                            //           'ショップ（ブランド名）',
                            //           style: TextStyle(
                            //               color: AppColors.colorWhite, fontSize: 16),
                            //         ),
                            //         const Text(
                            //           '*',
                            //           style:
                            //               TextStyle(color: Colors.red, fontSize: 16),
                            //         )
                            //       ],
                            //     )),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20, right: 20),
                            //   child: Container(
                            //     width: 100.w - 40,
                            //     decoration: BoxDecoration(
                            //       border: Border(
                            //         bottom: BorderSide(
                            //           color: AppColors.basicBorderColor,
                            //           width: 1.0,
                            //         ),
                            //       ),
                            //     ),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Image.asset(
                            //           'assets/booking.png',
                            //           fit: BoxFit.fitWidth,
                            //           height: 36,
                            //         ),
                            //         Expanded(
                            //             child: Padding(
                            //           padding: const EdgeInsets.only(left: 6),
                            //           child: TextFormField(
                            //             decoration: const InputDecoration(
                            //               border: InputBorder.none,
                            //             ),
                            //             style: TextStyle(
                            //                 color: AppColors.colorWhite,
                            //                 fontSize: 16),
                            //           ),
                            //         ))
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 16,
                            // ),
                            // Padding(
                            //     padding: const EdgeInsets.only(left: 20, right: 20),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Text(
                            //           'ショップ（URL）',
                            //           style: TextStyle(
                            //               color: AppColors.colorWhite, fontSize: 16),
                            //         ),
                            //         const Text(
                            //           '*',
                            //           style:
                            //               TextStyle(color: Colors.red, fontSize: 16),
                            //         )
                            //       ],
                            //     )),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 20, right: 20),
                            //   child: Container(
                            //     width: 100.w - 40,
                            //     decoration: BoxDecoration(
                            //       border: Border(
                            //         bottom: BorderSide(
                            //           color: AppColors.basicBorderColor,
                            //           width: 1.0,
                            //         ),
                            //       ),
                            //     ),
                            //     child: Flex(
                            //       direction: Axis.horizontal,
                            //       children: [
                            //         Image.asset(
                            //           'assets/world.png',
                            //           fit: BoxFit.fitWidth,
                            //           height: 36,
                            //         ),
                            //         Expanded(
                            //             child: Padding(
                            //           padding: const EdgeInsets.only(left: 6),
                            //           child: TextFormField(
                            //             decoration: const InputDecoration(
                            //               border: InputBorder.none,
                            //             ),
                            //             style: TextStyle(
                            //                 color: AppColors.colorWhite,
                            //                 fontSize: 16),
                            //           ),
                            //         ))
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      '電話番号',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      child: TextFormField(
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          }
                                          return null;
                                        },
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
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    Text(
                                      'パスワード',
                                      style: TextStyle(
                                          color: AppColors.colorWhite,
                                          fontSize: 16),
                                    ),
                                    const Text(
                                      '*',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                                  ],
                                )),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                                      'assets/pass.png',
                                      fit: BoxFit.fitWidth,
                                      height: 36,
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '必須項目です。';
                                          }
                                          return null;
                                        },
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
                            Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                CustomCheckBox(
                                  value: viewModel.getIsAgreeState,
                                  splashRadius: 40,
                                  shouldShowBorder: true,
                                  borderColor: AppColors.basicColor,
                                  checkedFillColor: AppColors.activeColor,
                                  onChanged: (val) {
                                    viewModel.updateIsAgreeState(val);
                                  },
                                ),
                                Text(
                                  '利用規約に同意する',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.colorWhite),
                                )
                              ],
                            ),

                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 100, right: 100, top: 24, bottom: 36),
                                child: SizedBox(
                                  width: 100.w - 200,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: AppColors.activeColor,
                                      minimumSize: Size(80.w, 40),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                    ),
                                    onPressed: () async {
                                      if (viewModel.getAvartaImage == null) {
                                        var snackBar = const SnackBar(
                                            backgroundColor: Colors.red,
                                            content:
                                                Text('プロフィール写真を選択してください。'));
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      if (viewModel.getIsAgreeState == false) {
                                        var snackBar = const SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text('利用規約に同意してください。'));
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                      else {
                                        if (_formKey.currentState!.validate()) {
                                          var url = Uri.parse(
                                              '${Constants.baseUrl}api/register');
                                          var response = await http.post(url,
                                              headers: {
                                                "Content-Type":
                                                    "application/json",
                                              },
                                              body: jsonEncode({
                                                'email': mailController.text,
                                                'password':
                                                    passwordController.text,
                                                'name':
                                                    firstNameController.text,
                                                'full_name':
                                                    firstNameController.text +
                                                        lastNameController.text,
                                                'address':
                                                    addressController.text,
                                                'zip_code':
                                                    zipcodeController.text,
                                                'phone_number':
                                                    passwordController.text,
                                                'profile_url':
                                                    viewModel.getAvartaImage !=
                                                            null
                                                        ? base64Encode(viewModel
                                                            .getAvartaImage!
                                                            .readAsBytesSync())
                                                        : '',
                                              }));

                                          var parsedJson =
                                              jsonDecode(response.body);
                                          if (parsedJson['status'] ==
                                              'successful') {
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setString(
                                                'register_state', 'yes');
                                            viewModel.updateIsAgreeState(false);
                                            // ignore: use_build_context_synchronously
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: const [
                                                      CircularProgressIndicator(),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                            Future.delayed(
                                                const Duration(seconds: 1), () {
                                              context.go('/login');
                                            });
                                          } else {
                                            var snackBar = const SnackBar(
                                                backgroundColor: Colors.red,
                                                content:
                                                    Text('メールが既に存在しています。'));
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        }
                                      }
                                    },
                                    child: Text('送信',
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.colorWhite,
                                            decoration: TextDecoration.none)),
                                  ),
                                )),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));
        }));
  }
}
