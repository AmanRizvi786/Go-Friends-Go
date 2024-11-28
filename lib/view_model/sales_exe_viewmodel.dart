import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/sales_exe_model/sales_execut_model.dart';
import 'package:gofriendsgo/services/sales_exe_service.dart';
// Update with the actual path to your SalesPerson service class
import 'package:gofriendsgo/services/shared_preferences.dart'; // Update with the actual path to your SharedPreferences service class

class SalesPersonViewModel extends ChangeNotifier {
  final SalesPersonService _service = SalesPersonService();
  SalesPersonResponse? _salesPersonResponse;
  bool _isLoading = false;

  SalesPersonResponse? get salesPersonResponse => _salesPersonResponse;
  bool get isLoading => _isLoading;

  Future<void> fetchSalesPerson() async {
    log('Fetching sales person details from view model');
    _isLoading = true;

    try {
      _salesPersonResponse =
          await _service.fetchSalesPerson(SharedPreferecesServices.token!);
      if (_salesPersonResponse != null) {
        log('Sales person details fetched successfully');
        // Example: logging the name of the sales person if it exists
        log(_salesPersonResponse!.data.email);
            }
      notifyListeners(); // Notify listeners that loading has started
    } catch (e) {
      // Handle error
      log('Error fetching sales person details: $e');
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify listeners that loading has ended
    }
  }
}
