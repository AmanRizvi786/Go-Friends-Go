import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/banner_model/banner_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class BannerService {
  Future<BannersModel> fetchBanner(String token) async {
    log('Fetching banners from service file');
    try {
      final response = await http.get(
        Uri.parse('${API.baseUrl}/banners'),
        
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return BannersModel.fromJson(parsed);
      } else {
        log('Error: Failed to load carousals with status code ${response.statusCode}');
        throw Exception('Failed to load carousal this error is showing from banner service area ');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load carousals: $e');
    }
  }
}
