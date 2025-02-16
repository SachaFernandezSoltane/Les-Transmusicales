import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchArtistes() async {
  final response = await http.get(Uri.parse(
      'https://data.rennesmetropole.fr/api/explore/v2.1/catalog/datasets/artistes_concerts_transmusicales/records?select=artistes'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    late List<String> artistesList = [];
    List<dynamic> results = jsonData['results'];

    for (var element in results) {
      artistesList.add(element['artistes']);
    }

    return artistesList;
  } else {
    throw Exception('Erreur lors du chargement des artistes');
  }
}

Future<List<Map<String, dynamic>>> fetchTransms() async {
  final response = await http.get(Uri.parse(
      'https://data.rennesmetropole.fr/api/explore/v2.1/catalog/datasets/artistes_concerts_transmusicales/records?select=annee%2Cedition_rencontres_trans_musicales&group_by=annee%2Cedition_rencontres_trans_musicales&order_by=annee%2Cedition_rencontres_trans_musicales&limit=100'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    List<dynamic> results = jsonData['results'];

    List<Map<String, dynamic>> artistesList = results.map((element) {
      return {
        'nom': element['edition_rencontres_trans_musicales'] ?? 'Inconnu',
        'date': element['annee'].substring(0,10) ?? 'N/A'
      };
    }).toList();

    return artistesList;
  } else {
    throw Exception('Erreur lors du chargement des transmusicales');
  }
}

