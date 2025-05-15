import 'package:flutter/foundation.dart';
import '../models/address_model.dart';

class AddressProvider with ChangeNotifier {
  List<AddressModel> _addresses = [];

  List<AddressModel> get addresses => _addresses;

  void addAddress(AddressModel address) {
    _addresses.add(address);
    notifyListeners();
  }

  void editAddress(int index, AddressModel newAddress) {
    _addresses[index] = newAddress;
    notifyListeners();
  }

  void deleteAddress(int index) {
    _addresses.removeAt(index);
    notifyListeners();
  }
}
