import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

String token = "";
const String clientId = "1b6335b0eb9f42188f3654496591957a";
const String clientSecret = "d01698c8908d446fa5b1a74a6405e2ef";

Future<void> getSpotifyAccessToken() async {
  final response = await http.post(
    Uri.parse("https://accounts.spotify.com/api/token"),
    headers: {
      "Content-Type": "application/x-www-form-urlencoded",
    },
    body: {
      "grant_type": "client_credentials",
      "client_id": clientId,
      "client_secret": clientSecret,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    token = jsonData['access_token'];
  } else {
    throw Exception("Erreur lors de la récupération du token Spotify");
  }
}

Future<List<String>> fetchArtistes() async {
  final response = await http.get(Uri.parse(
      'https://data.rennesmetropole.fr/api/explore/v2.1/catalog/datasets/artistes_concerts_transmusicales/records?select=artistes'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    List<String> artistesList = [];
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
        'date': element['annee'].substring(0, 10) ?? 'N/A'
      };
    }).toList();

    return artistesList;
  } else {
    throw Exception('Erreur lors du chargement des transmusicales');
  }
}

// 🔹 Fonction pour récupérer un artiste via Spotify
Future<String> fetchArtistSearchSpotify() async {
  await getSpotifyAccessToken(); // Attendre la récupération du token

  final response = await http.get(
    Uri.parse(
        "https://api.spotify.com/v1/search?q=TheGlitchMob&type=artist&limit=1"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);

    if (jsonData['artists']['items'].isNotEmpty) {
      return jsonData['artists']['items'][0]['uri'];
    } else {
      throw Exception("Aucun artiste trouvé.");
    }
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<List<Map<String, dynamic>>> fetchAlbumArtist() async {
  await getSpotifyAccessToken();

  final response = await http.get(
    Uri.parse(
        "https://api.spotify.com/v1/artists/3a9qv6NLHnsVxJUtKOMHvD/albums?limit=5"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    List<dynamic> results = jsonData['items'];

    List<Map<String, dynamic>> albumList = results.map((element) {
      return {
        'albumName': element['name'] ?? 'Inconnu',
        'imgUrl' : element['images'][0]['url'],
        'releaseDate': element['release_date'],
      };
    }).toList();

    return albumList;

    } else {
      throw Exception("Aucun album trouvé.");
    }
}
