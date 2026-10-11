class Yugioh{
  final int id;
  final String name;
  final String type;
  final String desc;
  final int? atk;
  final int? def;
  final int? level;
  final String race;
  final String? attribute;
  final String imageSmall;
  final String imageFull;

  const Yugioh({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    this.atk,
    this.def,
    this.level,
    required this.race,
    this.attribute,
    required this.imageSmall,
    required this.imageFull,
  });
  factory Yugioh.fromJson(Map<String, dynamic> json) {
    final img = (json['card_images'] as List).first;
    return Yugioh(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      desc: json['desc'],
      atk: json['atk'],
      def: json['def'],
      level: json['level'],
      race: json['race'],
      attribute: json['attribute'],
      imageSmall: img['image_url_small'],
      imageFull: img['image_url'],
    );
  }
}