import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/yugiohModel.dart';
class YgoApi {
static const _base = 'https://db.ygoprodeck.com/api/v7/cardinfo.php';

  /// Pass any API filters, e.g. {'archetype': 'Blue-Eyes'}
  static Future<List<Yugioh>> fetchCards(Map<String, String> params) async {
    final uri = Uri.parse(_base).replace(queryParameters: params);
    final res = await http.get(uri).timeout(const Duration(seconds: 2));

    if (res.statusCode != 200) {
      // The API returns {"error": "..."} with a 400 on bad params
      final msg = jsonDecode(res.body)['error'] ?? 'Request failed';
      throw Exception(msg);
    }

    final data = jsonDecode(res.body)['data'] as List;

    return data.map((e) => Yugioh.fromJson(e)).toList();
  }
  
  static Future<Yugioh> streamFetchCard() async {
    final uri = Uri.parse('https://db.ygoprodeck.com/api/v7/randomcard.php');
    final response = await http.get(uri).timeout(const Duration(seconds: 3));

    if (response.statusCode != 200) {
      throw Exception('Server: ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final card = body['data'] is List ? (body['data'] as List).first : body;

    return Yugioh.fromJson(card as Map<String, dynamic>);
  }
}
