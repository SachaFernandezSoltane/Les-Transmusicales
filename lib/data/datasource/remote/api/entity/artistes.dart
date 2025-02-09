class Artiste {
  final String artistes;

  Artiste({required this.artistes});

  // Factory constructor pour créer un objet Artiste à partir d'un seul élément JSON
  factory Artiste.fromJson(Map<String, dynamic> json) {
    return Artiste(
      artistes: json['artistes'] ?? '', // Corrigé : on prend bien la clé "artistes"
    );
  }

  // Convertir un objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'artistes': artistes,
    };
  }
}
