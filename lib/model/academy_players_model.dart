class AcademyPlayersModel {
  final int id;
  final String image;
  final String fullName;
  final String academy;

  AcademyPlayersModel({
    required this.id,
    required this.image,
    required this.fullName,
    required this.academy,
  });

  factory AcademyPlayersModel.fromJson(Map<String, dynamic> json) => AcademyPlayersModel(
        id: json["id"],
        image: json["image"],
        fullName: json["fullName"],
        academy: json["academy"],
      );
}
