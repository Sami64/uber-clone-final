import 'package:flutter/cupertino.dart';
import 'package:uber_clone/datamodels/address.dart';

class AppData extends ChangeNotifier {
  Address pickupAddress = Address.initial();

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
}
