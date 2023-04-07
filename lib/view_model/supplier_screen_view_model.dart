import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final supplierScreenViewModelProvider =
    ChangeNotifierProvider((ref) => SupplierScreenViewModel());

class SupplierScreenViewModel extends ChangeNotifier {
  int _tabID = 0;
  int _status = 0;
  List _followedBuyerlist = [];

  int get getTabID => _tabID;
  int get getStatus => _status;
  List get getFollowedBuyerList => _followedBuyerlist;

  void updateTabID(int index) {
    _tabID = index;
    notifyListeners();
  }

  void updateStatus(int status) {
    _status = status;
    notifyListeners();
  }

  void updateFollowedBuyerList(List buyerList) {
    _followedBuyerlist = buyerList;
    notifyListeners();
  }

  void updateFollowedBuyerListItemData(int index, bool isAccepted) {
    _followedBuyerlist[index]['isAccepted'] = isAccepted;
    notifyListeners();
  }
}
