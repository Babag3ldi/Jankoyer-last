class AcademyModel {
  final int id;
  final String image;
  final String name;
  final String description;

  AcademyModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
  });

  factory AcademyModel.fromJson(Map<String, dynamic> json) => AcademyModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );
}
