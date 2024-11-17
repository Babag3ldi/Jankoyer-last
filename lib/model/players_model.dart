class PlayersModel {
    final int id;
    final String clubName;
    final String image;
    final String status;
    final List<PlayerInfo> players;

    PlayersModel({
        required this.id,
        required this.clubName,
        required this.image,
        required this.status,
        required this.players,
    });

    factory PlayersModel.fromJson(Map<String, dynamic> json) => PlayersModel(
        id: json["id"],
        clubName: json["clubName"],
        image: json["image"],
        status: json["status"],
        players: List<PlayerInfo>.from(json["players"].map((x) => PlayerInfo.fromJson(x))),
    );

   
}

class PlayerInfo {
    final int id;
    final String fullName;
    final String image;
    final bool active;
    final int clubId;

    PlayerInfo({
        required this.id,
        required this.fullName,
        required this.image,
        required this.active,
        required this.clubId,
    });

    
    factory PlayerInfo.fromJson(Map<String, dynamic> json) => PlayerInfo(
        id: json["id"],
        fullName: json["fullName"],
        image: json["image"],
        active: json["active"],
        clubId: json["clubId"],
    );

}
