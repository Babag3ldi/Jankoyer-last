// ignore_for_file: unused_local_variable, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jankoyer/model/academy_model.dart';
import 'package:jankoyer/model/news_model.dart';

import '../model/academy_players_model.dart';
import '../model/advertise_model.dart';
import '../model/championat_model.dart';
import '../model/futbol_table_model.dart';
import '../model/interviews_model.dart';
import '../model/news_id_model.dart';
import '../model/shop_model.dart';

class NewsService {
  static String basicUrl = 'http://jankoyer.com.tm/api/1.0/';

  Future<List<AdvertiseModel>> advertiseGet() async {
    final uri = Uri.parse(
      "http://jankoyer.com.tm/api/1.0/advertise?type=0",
    );
    final response = await http.get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final adver = json.map((e) {
        return AdvertiseModel(
          id: e['id'],
          image: e['image'],
          link: e['link'],
        );
      }).toList();
      return adver;
    } else {
      String adver = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<NewsModelNewsNews>> newsGet() async {
    // final queryParameters = {
    //   'param1': 'one',
    //   'param2': 'two',
    // };
    final uri = Uri.parse(
      "http://jankoyer.com.tm/api/1.0/news", //?page=1&size=10
    );
    final response = await http.get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final neww = json['news'] as List;
      final news = neww.map((e) {
        return NewsModelNewsNews(
          id: e['id'],
          title: e['title'],
          image: e['image'],
          views: e['views'],
          description: e['description'],
        );
      }).toList();
      return news;
    } else {
      String news = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<NewsIdModel>> newsGetId() async {
    final uri = Uri.parse(
      "${basicUrl}news/",
    );
    final response = await http.get(uri);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      // final neww = json['news'] as List;
      final newsId = json.map((e) {
        return NewsIdModel(
          id: e['id'],
          title: e['title'],
          image: e['image'],
          views: e['views'],
          description: e['description'],
          text: e['text'],
        );
      }).toList();
      return newsId;
    } else {
      String newsId = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<InterviewsModelConversation>> interviewsGet() async {
    final uri = Uri.parse("${basicUrl}conversation?page=1&size=10");
    final response = await http.get(uri);
    print("interviewsGet => ${response.statusCode}");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final getInter = json['conversation'] as List;
      final interviews = getInter.map((e) {
        return InterviewsModelConversation(
          id: e['id'],
          title: e['title'],
          image: e['image'],
          description: e['description'],
          video: e['video'],
          videoDuration: e['videoDuration'],
        );
      }).toList();
      return interviews;
    } else {
      String interviews = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<ChampionatModel>> championatGet() async {
    final uri = Uri.parse("${basicUrl}game/championat");
    final response = await http.get(uri);
    print("interviewsGet => ${response.statusCode}");
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      // final getChamp = json['conversation'] as List;
      final championa = json.map((e) {
        return ChampionatModel(
          id: e['id'],
          title: e['title'],
          image: e['image'],
          description: e['description'],
        );
      }).toList();
      return championa;
    } else {
      String championa = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<ShopModel>> shopGet() async {
    final uri = Uri.parse("${basicUrl}shop");
    final response = await http.get(uri);
    print("shopGet => ${response.body}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final shops = json.map((e) {
        return ShopModel(
          id: e['id'],
          title: e['title'],
          image: e['image'],
          phoneNumber: e['phoneNumber'],
        );
      }).toList();
      return shops;
    } else {
      String shops = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<TableModel>> tableGet() async {
    final uri = Uri.parse("${basicUrl}game/table/club/");
    final response = await http.get(uri);
    print("shopGet => ${response.statusCode}");
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      // final list = json['data'] as List;
      final tables = json.map((e) {
        return TableModel(
          id: e['id'],
          clubName: e['clubName'],
          image: e['image'],
          status: e['status'],
          totalGoals: e['totalGoals'],
          lose: e['lose'],
          win: e['win'],
          draw: e['draw'],
          totalMatches: e['totalMatches'],
          score: e['score'],
          totalRedCards: e['totalRedCards'],
          totalYellowCards: e['totalYellowCards'],
        );
      }).toList();
      return tables;
    } else {
      String tables = 'no internet';
    }
    return [];
    //  throw "Internet baglansygy yok";
  }

  Future<List<AcademyModel>> getAcademy() async {
    final response = await http
        .get(Uri.parse('http://jankoyer.com.tm/api/1.0/academy/'));
        print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body)['academy'];
          print(jsonData);
      final List<AcademyModel> productSer =
          jsonData.map((data) => AcademyModel.fromJson(data)).toList();
          
      return productSer;
    } else {
      throw Exception('getBrend. Status code: ${response.statusCode}');
    }
  }

  Future<List<AcademyPlayersModel>> getPlayers(int id) async {
    final response = await http
        .get(Uri.parse('http://jankoyer.com.tm/api/1.0/academy/players/$id'));
        print(response.statusCode);
    if (response.statusCode == 200) {
      final List<dynamic> jsonData =
          json.decode(response.body)['players'];
          print(jsonData);
      final List<AcademyPlayersModel> productSer =
          jsonData.map((data) => AcademyPlayersModel.fromJson(data)).toList();
          
      return productSer;
    } else {
      throw Exception('getBrend. Status code: ${response.statusCode}');
    }
  }
}
