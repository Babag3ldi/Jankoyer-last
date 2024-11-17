// To parse this JSON data, do
//
//     final statisticModelMatches = statisticModelMatchesFromJson(jsonString);

import 'dart:convert';

class StatisticModelMatches {
    final int id;
    final dynamic goal;
    final Player player;
    final int totalGoals;

    StatisticModelMatches({
        required this.id,
        this.goal,
        required this.player,
        required this.totalGoals,
    });

    StatisticModelMatches copyWith({
        int? id,
        dynamic goal,
        Player? player,
        int? totalGoals,
    }) => 
        StatisticModelMatches(
            id: id ?? this.id,
            goal: goal ?? this.goal,
            player: player ?? this.player,
            totalGoals: totalGoals ?? this.totalGoals,
        );

    factory StatisticModelMatches.fromRawJson(String str) => StatisticModelMatches.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory StatisticModelMatches.fromJson(Map<String, dynamic> json) => StatisticModelMatches(
        id: json["id"],
        goal: json["goal"],
        player: Player.fromJson(json["player"]),
        totalGoals: json["totalGoals"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "goal": goal,
        "player": player.toJson(),
        "totalGoals": totalGoals,
    };
}

class Player {
    final int id;
    final String fullName;
    final String image;
    final bool active;
    final int clubId;
    final Club club;

    Player({
        required this.id,
        required this.fullName,
        required this.image,
        required this.active,
        required this.clubId,
        required this.club,
    });

    Player copyWith({
        int? id,
        String? fullName,
        String? image,
        bool? active,
        int? clubId,
        Club? club,
    }) => 
        Player(
            id: id ?? this.id,
            fullName: fullName ?? this.fullName,
            image: image ?? this.image,
            active: active ?? this.active,
            clubId: clubId ?? this.clubId,
            club: club ?? this.club,
        );

    factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        fullName: json["fullName"],
        image: json["image"],
        active: json["active"],
        clubId: json["clubId"],
        club: Club.fromJson(json["club"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "image": image,
        "active": active,
        "clubId": clubId,
        "club": club.toJson(),
    };
}

class Club {
    final int id;
    final String clubName;
    final String image;

    Club({
        required this.id,
        required this.clubName,
        required this.image,
    });

    Club copyWith({
        int? id,
        String? clubName,
        String? image,
    }) => 
        Club(
            id: id ?? this.id,
            clubName: clubName ?? this.clubName,
            image: image ?? this.image,
        );

    factory Club.fromRawJson(String str) => Club.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Club.fromJson(Map<String, dynamic> json) => Club(
        id: json["id"],
        clubName: json["clubName"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clubName": clubName,
        "image": image,
    };
}
