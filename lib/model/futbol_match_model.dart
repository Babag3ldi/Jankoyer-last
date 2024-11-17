// To parse this JSON data, do
//
//     final matchModelMatches = matchModelMatchesFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, constant_identifier_names

import 'dart:convert';

class MatchModelMatches {
  final int id;
  final int number;
  final String title;
  final bool home;
  final List<Match> matches;

  MatchModelMatches({
    required this.id,
    required this.number,
    required this.title,
    required this.home,
    required this.matches,
  });

  factory MatchModelMatches.fromRawJson(String str) =>
      MatchModelMatches.fromJson(json.decode(str));

  factory MatchModelMatches.fromJson(Map<String, dynamic> json) =>
      MatchModelMatches(
        id: json["id"],
        number: json["number"],
        title: json["title"],
        home: json["home"],
        matches:
            List<Match>.from(json["matches"].map((x) => Match.fromJson(x))),
      );
}

class Match {
  final int id;
  final DateTime schedule;
  final MatchStatus status;
  final int firstClubId;
  final int secondClubId;
  final Club? firstClub;
  final Club? secondClub;

  Match({
    required this.id,
    required this.schedule,
    required this.status,
    required this.firstClubId,
    required this.secondClubId,
    required this.firstClub,
    required this.secondClub,
  });

  factory Match.fromRawJson(String str) => Match.fromJson(json.decode(str));

  factory Match.fromJson(Map<String, dynamic> json) {
    // List listtt = matchStatusValues.map[json["status"]];
    // Map listtt = json["status"];
    // Map sche = json["firstClub"];
    return Match(
      id: json["id"],
      schedule: DateTime.parse(
          // sche.isEmpty ? '' :
          json["schedule"]),
      status: matchStatusValues.map[json["status"]]!,
      firstClubId: json["firstClubId"],
      secondClubId: json["secondClubId"],
      firstClub: Club.fromJson(json["firstClub"]),
      secondClub: Club.fromJson(json["secondClub"]),
    );
  }
}

class Club {
  final int id;
  final FirstClubStatus status;
  final ClubClass club;
  final List<ResultGoal> resultGoals;
  final List<ResultCard> resultCards;

  Club({
    required this.id,
    required this.status,
    required this.club,
    required this.resultGoals,
    required this.resultCards,
  });

  factory Club.fromRawJson(String str) => Club.fromJson(json.decode(str));

  factory Club.fromJson(Map<String, dynamic> json) {
    List listt = json["resultGoals"];
    List listtt = json['resultCards'];
    return Club(
      id: json["id"],
      status: firstClubStatusValues.map[json["status"]]!,
      club: ClubClass.fromJson(json["club"]),
      resultGoals: listt.isEmpty
          ? []
          : List<ResultGoal>.from(
              json["resultGoals"].map((x) => ResultGoal.fromJson(x))),
      resultCards: listtt.isEmpty
          ? []
          : List<ResultCard>.from(
              json["resultCards"].map((x) => ResultCard.fromJson(x))),
    );
  }
}

class ClubClass {
  final int id;
  final String clubName;
  final String image;
  final ClubStatus status;

  ClubClass({
    required this.id,
    required this.clubName,
    required this.image,
    required this.status,
  });

  factory ClubClass.fromRawJson(String str) =>
      ClubClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClubClass.fromJson(Map<String, dynamic> json) => ClubClass(
        id: json["id"],
        clubName: json["clubName"],
        image: 'http://jankoyer.com.tm' + json["image"],
        status: clubStatusValues.map[json["status"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clubName": clubName,
        "image": 'http://jankoyer.com.tm$image',
        "status": clubStatusValues.reverse[status],
      };
}

enum ClubStatus { FOOTBALL }

final clubStatusValues = EnumValues({"football": ClubStatus.FOOTBALL});

class ResultGoal {
  final int? id;
  final Goal? goal;
  final String? minute;
  final Player? player;

  ResultGoal({
    required this.id,
    required this.goal,
    required this.minute,
    required this.player,
  });

  factory ResultGoal.fromRawJson(String str) =>
      ResultGoal.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory ResultGoal.fromJson(Map<String, dynamic> json) {
    // List<dynamic> listt = json["minute"];
    return ResultGoal(
      id: json["id"] == null ? null : json['id'],
      goal: json["goal"] == null ? null : goalValues.map[json["goal"]]!,
      minute: json["minute"], // == listt ?  [] : json["minute"] ,
      player: Player.fromJson(json["player"]),
    );
  }
}

class ResultCard {
  final List<String> minute;
  final List<Cardd> cardd;
  final Player player;

  ResultCard({
    required this.minute,
    required this.cardd,
    required this.player,
  });

  factory ResultCard.fromRawJson(String str) =>
      ResultCard.fromJson(json.decode(str));

  factory ResultCard.fromJson(Map<String, dynamic> json) => ResultCard(
        minute: List<String>.from(json["minute"].map((x) => x)),
        cardd: List<Cardd>.from(json["card"].map((x) => cardValues.map[x]!)),
        player: Player.fromJson(json["player"]),
      );
}

enum Cardd { RED, YELLOW }

final cardValues = EnumValues({"red": Cardd.RED, "yellow": Cardd.YELLOW});

enum Goal { PENALTY, EMPTY, AUTOGOAL }

final goalValues = EnumValues(
    {"autogoal": Goal.AUTOGOAL, "": Goal.EMPTY, "penalty": Goal.PENALTY});

class Player {
  final int id;
  final String fullName;
  final String image;

  Player({
    required this.id,
    required this.fullName,
    required this.image,
  });

  factory Player.fromRawJson(String str) => Player.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Player.fromJson(Map<String, dynamic> json) => Player(
        id: json["id"],
        fullName: json["fullName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "image": image,
      };
}

enum FirstClubStatus { HOME, AWAY }

final firstClubStatusValues =
    EnumValues({"away": FirstClubStatus.AWAY, "home": FirstClubStatus.HOME});

enum MatchStatus { END, WAIT, LIVE }

final matchStatusValues = EnumValues({
  "end": MatchStatus.END,
  "wait": MatchStatus.WAIT,
  "live": MatchStatus.LIVE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
