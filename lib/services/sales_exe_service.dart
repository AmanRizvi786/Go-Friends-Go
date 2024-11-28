import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/sales_exe_model/sales_execut_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class SalesPersonService {
  Future<SalesPersonResponse> fetchSalesPerson(String token) async {
    log('Fetching sales person details from service file');
    try {
      final response = await http.get(
        Uri.parse('${API.baseUrl}/sales-executive'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return SalesPersonResponse.fromJson(parsed);
      } else {
        log('Error: ${response.body}');
        log('Error: Failed to load sales person details with status code ${response.statusCode}');
        throw Exception(
            'Failed to load sales person details. Error from sales person service area.');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load sales person details: $e');
    }
  }
}
