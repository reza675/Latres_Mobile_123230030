import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'https://api.tvmaze.com';

  // Fetch daftar shows
  static Future<List<dynamic>> getShows({int page = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shows?page=$page'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal fetch shows');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // Fetch detail show berdasarkan ID
  static Future<dynamic> getShowDetail(int id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/shows/$id'),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal fetch detail show');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
