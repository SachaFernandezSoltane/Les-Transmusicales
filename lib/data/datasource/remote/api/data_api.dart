import 'dart:convert';
import 'package:http/http.dart' as http;

String token = "";
String uri = "";
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

Future<List<Map<String, String>>> fetchArtistes() async {
  final response = await http.get(Uri.parse(
      'https://data.rennesmetropole.fr/api/explore/v2.1/catalog/datasets/artistes_concerts_transmusicales/records?select=artistes&limit=25'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    List<Map<String, String>> artistesList = [];
    List<dynamic> results = jsonData['results'];

    for (var element in results) {
      String imgUrl = await fetchImgArtist(element['artistes']);

      artistesList.add({
        'nomArtiste': element['artistes'] ?? 'Inconnu',
        'urlImage': imgUrl ??
            'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTjOSHQ-yEq0QFZb7BgthYtUVCJOXe5MbXYp5ixGpSMkf_tRRom0jpcOREwM6em4RR9HF2DVjKsQUuFKEBXipn4rw',
      });
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

Future<void> fetchArtistSearchSpotify(String artistName) async {
  await getSpotifyAccessToken();

  final response = await http.get(
    Uri.parse(
        "https://api.spotify.com/v1/search?q=$artistName&type=artist&limit=1"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);

    if (jsonData['artists']['items'].isNotEmpty) {
      uri = jsonData['artists']['items'][0]['uri'].substring(15);
    } else {
      throw Exception("Aucun artiste trouvé.");
    }
  } else {
    throw Exception(response.reasonPhrase);
  }
}

Future<String> fetchImgArtist(String artistName) async {
  await fetchArtistSearchSpotify(artistName);
  final response = await http.get(
    Uri.parse("https://api.spotify.com/v1/artists/$uri"),
    headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    List<dynamic> results = jsonData['images'];

    // Vérification si la liste des images est vide
    String imgArtist = (results.isNotEmpty && results[0]["url"] != null)
        ? results[0]["url"]
        : 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTjOSHQ-yEq0QFZb7BgthYtUVCJOXe5MbXYp5ixGpSMkf_tRRom0jpcOREwM6em4RR9HF2DVjKsQUuFKEBXipn4rw'; // Image par défaut

    return imgArtist;
  } else {
    throw Exception("Aucun album trouvé.");
  }
}

Future<List<Map<String, dynamic>>> fetchAlbumArtist(String artistName) async {
  await fetchArtistSearchSpotify(artistName);
  final response = await http.get(
    Uri.parse("https://api.spotify.com/v1/artists/$uri/albums?limit=5"),
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
        'imgUrl': element['images'][0]['url'],
        'releaseDate': element['release_date'],
      };
    }).toList();

    return albumList;
  } else {
    throw Exception("Aucun album trouvé.");
  }
}

Future<Map<String, Map<String, double>>> getCoordinates(
    List<String> citiesName) async {
  Map<String, Map<String, double>> coordinatesMap = {};

  for (var city in citiesName) {
    final response = await http.get(
      Uri.parse(
          'https://nominatim.openstreetmap.org/search?q=$city&format=json&limit=1'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      if (jsonData.isNotEmpty) {
        final location = jsonData[0];
        coordinatesMap[city] = {
          'lat': double.parse(location['lat']),
          'lng': double.parse(location['lon']),
        };
      } else {
        throw Exception('Aucun résultat trouvé pour $city');
      }
    } else {
      throw Exception(
          'Erreur lors de la requête à l\'API Nominatim pour $city');
    }
  }

  return coordinatesMap;
}

Future<Map<String, Map<String, double>>> fetchMapsPointsArtists(
    String artistName) async {
  String encodedArtistName = Uri.encodeComponent(artistName);

  final response = await http.get(
    Uri.parse(
        "https://data.rennesmetropole.fr/api/explore/v2.1/catalog/datasets/artistes_concerts_transmusicales/records?where=artistes%20like%20%22$encodedArtistName%22&limit=100"),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonData = json.decode(response.body);
    final List<String> mapsPointsAPI = [];
    bool entryExist = true;
    int index = 0;
    List<String> cities = [
      '1ere_ville',
      '2eme_ville',
      '3eme_ville',
      '4eme_ville',
      '5eme_ville',
      '6eme_ville'
    ];
    for (var result in jsonData['results']) {
      while (entryExist && index < cities.length) {
        if (result[cities[index]] != null) {
          mapsPointsAPI.add(result[cities[index]]);
          index++;
        } else {
          entryExist = false;
        }
      }
      index = 0;
      entryExist = true;
    }
    Map<String, Map<String, double>> coordinates =
        await getCoordinates(mapsPointsAPI);
    return coordinates;
  } else {
    throw Exception("Aucun album trouvé.");
  }
}
