import 'dart:convert';
import 'package:http/http.dart' as http;

class JikanService {
  static const String baseUrl = 'https://api.jikan.moe/v4';

  Future<Map<String, dynamic>> getMangaDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/manga/$id'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    }
    throw Exception('Failed to load manga details');
  }

  Future<List<Map<String, dynamic>>> getTrendingManga() async {
    final response = await http.get(Uri.parse('$baseUrl/top/manga?filter=bypopularity'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.take(10).map((item) => item as Map<String, dynamic>).toList();
    }
    throw Exception('Failed to load trending manga');
  }

  Future<List<Map<String, dynamic>>> searchManga(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/manga?q=$query&order_by=popularity&sort=desc'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((item) => item as Map<String, dynamic>).toList();
    }
    throw Exception('Failed to search manga');
  }

  Future<List<Map<String, dynamic>>> getAllComics() async {
    final response = await http.get(Uri.parse('$baseUrl/manga'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'] as List;
      return data.map((item) => item as Map<String, dynamic>).toList();
    }
    throw Exception('Failed to get all comics');
  }
}