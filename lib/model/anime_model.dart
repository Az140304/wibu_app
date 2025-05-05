class Anime {
  final int id;
  final String name;
  final String imageUrl;
  final String clan;

  Anime({
    required this.id,
    required this.name,
    required this.imageUrl,

    required this.clan
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    // Safer extraction of the clan with proper null checks
    String clanValue = "No Clan";
    if (json['personal'] != null &&
        json['personal'] is Map &&
        json['personal']['clan'] != null) {
      clanValue = "${json['personal']['clan']} Clan";
    }

    return Anime(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'noName',
      imageUrl: (json['images'] != null && json['images'] is List && json['images'].isNotEmpty)
          ? json['images'][0]
          : 'https://placehold.co/600x400',
      clan: clanValue,
    );
  }
}