import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/constants.dart';
import 'package:savvy/model/invoice_data.dart';
import 'package:savvy/model/scan_data.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

final productScreenViewModelProvider =
    ChangeNotifierProvider((ref) => ProductScreenViewModel());

class ProductScreenViewModel extends ChangeNotifier {
  int _tabID = 0;
  int _status = 0;
  String _sumPrice = '0.0';
  String _sumItemsCounts = '0';
  String _pdfLink = '';
  bool _isSearching = false;

  final List<String> _countries = [
    'Afghanistan',
    'Albania',
    'Algeria',
    'Andorra',
    'Azerbaijan',
    'Bahrain',
    'Bangladesh',
    'Bosnia and Herzegovina',
    'Brunei',
    'Burkina Faso',
    'Chad',
    'Djibouti',
    'Egypt',
    'Eritrea',
    'Ethiopia',
    'Gambia',
    'Ghana'
  ];

  // ignore: non_constant_identifier_names, prefer_final_fields
  List<ScanData> _mitsumori_list = [];
  // ignore: prefer_final_fields
  List _mitsumoriBarCodelist = [];
  List _buyerSavedItemlist = [];
  List _followedSupplierlist = [];
  List _brandlist = [];
  List _searchResultlist = [];

  List get getCountries => _countries;
  List get getMitsumoriBarcodeList => _mitsumoriBarCodelist;
  // ignore: non_constant_identifier_names
  List<ScanData> get getMitsumori_list => _mitsumori_list;
  List get getBuyerSavedItemList => _buyerSavedItemlist;
  List get getFollowedSupplierList => _followedSupplierlist;
  List get getSearchResultList => _searchResultlist;
  List get getBrandList => _brandlist;
  int get getTabID => _tabID;
  int get getStatus => _status;
  String get getSumPrice => _sumPrice;
  String get getSumItemCounts => _sumItemsCounts;
  String get getPdfLink => _pdfLink;
  bool get getIsSearching => _isSearching;

  void updateTabID(int index) {
    _tabID = index;
    notifyListeners();
  }

  void updateIsSearchingState(bool state) {
    _isSearching = state;
    notifyListeners();
  }

  void updateMitsumoriBarcodeList(barcode) {
    _mitsumoriBarCodelist.insert(_mitsumoriBarCodelist.length, barcode);
    notifyListeners();
  }

  void updateBuyerSavedItemList(List savedItemList) {
    _buyerSavedItemlist = savedItemList;
    notifyListeners();
  }

  void updateBrandList(List brandList) {
    _brandlist = brandList;
    notifyListeners();
  }

  void updateSearchResultList(List searchList) {
    _searchResultlist = searchList;
    notifyListeners();
  }

  void updateFollowedSupplierList(List supplierList) {
    _followedSupplierlist = supplierList;
    notifyListeners();
  }

  void updateStatus(int status) {
    _status = status;
    notifyListeners();
  }

  void addItemToMitsumoriList(ScanData data) {
    _mitsumori_list.insert(_mitsumori_list.length, data);
  }

  void updateTotalItemsAndPrice() {
    var data = {};
    var sumPrice = 0.0;
    var itemCount = 0;
    for (var element in _mitsumori_list) {
      sumPrice = sumPrice + (element.amount * element.price);
      itemCount = itemCount + element.amount;
    }
    _sumPrice = sumPrice.toString();
    _sumItemsCounts = itemCount.toString();
    notifyListeners();
  }

  void sendInvoiceDataToServer() async {
    var data = _mitsumori_list.map((e) => e.toJson());
    var url = Uri.parse('${Constants.baseUrl}api/products/makeInvoice');

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data.toList()));

    var parsedJson = jsonDecode(response.body);
    var invoiceData = InvoiceData.fromJson(parsedJson);
    _pdfLink = Constants.baseUrl + invoiceData.pdfUrl;
    notifyListeners();
  }

  List searchByKeyWords(String k) {
    List result =
        getFollowedSupplierList.where((f) => f['name'].startsWith(k)).toList();
    return result;
  }
}
