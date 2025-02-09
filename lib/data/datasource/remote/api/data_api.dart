import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> fetchArtistes() async {
  final response = await http.get(Uri.parse('https://data.rennesmetropole.fr/api/explore/v2.1/catalog/datasets/artistes_concerts_transmusicales/records?select=artistes'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    late List<String> artistesList= [];
    List<dynamic> results = jsonData['results'];

    for (var element in results) {
      artistesList.add(element['artistes']);
    }
    
    return artistesList;
  } else {
    throw Exception('Erreur lors du chargement des artistes');
  }
}
