import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savvy/model/scan_data.dart';

final scanScreenViewModel =
    ChangeNotifierProvider((ref) => ScanScreenViewModel());

class ScanScreenViewModel extends ChangeNotifier {
  ScanData _scanProductData = ScanData(
      id: 0,
      name: '',
      price: 0,
      detail: '',
      barcode: '',
      amount: 0,
      category: '',
      other: '',
      imgUrl: '',
      brandName: '',
      color: '',
      imgUrls: [],
      material: '',
      size: '',
      sku: '');
  String _barcode = '';
  bool _isClicked = false;

  ScanData get getScranProductData => _scanProductData;
  String get getBarcode => _barcode;
  bool get getClickedState => _isClicked;

  void updateScanProductData(data) {
    _scanProductData = data;
    notifyListeners();
  }

  void updateBarcode(String data) {
    _barcode = data;
    notifyListeners();
  }

  void updateClickedState() {
    _isClicked = !_isClicked;
    notifyListeners();
  }
}
