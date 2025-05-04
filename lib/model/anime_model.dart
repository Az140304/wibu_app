class Anime {
  final int id;
  final String name;
  final String imageUrl;
  final String familyCreator;
  final String clan;

  Anime({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.familyCreator,
    required this.clan
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'noName',
      imageUrl: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]
          : 'https://placehold.co/600x400',
      familyCreator: (json['family'] != null)
          ? (json['family']['creator'] ?? json['family']['brother'] ?? "Family Creator is Null")
          : "No Family",
      clan: (json['personal'] != null && json['personal']['clan'] != null)
          ? "${json['personal']['clan']} Clan"
          : "No Clan",
    );
  }
}