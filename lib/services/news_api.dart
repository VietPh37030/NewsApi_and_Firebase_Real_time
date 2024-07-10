import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:new_paper_pj/consts/api_consts.dart';
import 'package:new_paper_pj/models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  static Future<List<NewsModel>> getAllNews({required int page,required String sortBy}) async {
    // var url = Uri.parse(
    //     'https://newsapi.org/v2/everything?q=bitcoin&pageSize=5&apiKey=d39185a94fd04c62ab8def1fcef4e4fd');
    try {
      var uri = Uri.http(BASEURL, "v2/everything", {
        "q": "bitcoin",
        "pageSize": "6",
        "domains": "zdnet.com,techcrunch.com,cnbc.com,bloomberg.com,decrypt.co,cryptoslate.com,",
        "page": page.toString(),
        "sortBy": sortBy
      });
      var response = await http.get(uri, headers: {"X-Api-key": API_KEY});
      // print('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTemplist = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data['articles']) {
        newsTemplist.add(v);
        log(v.toString());
        print(data['articles'].length.toString());
      }
      return NewsModel.newsFromsnapshot(newsTemplist);
    } catch (error) {
      throw error.toString();
    }
  }
  static Future<List<NewsModel>> getTopHeadlines() async {
    try {
      var uri = Uri.https(BASEURL, "v2/top-headlines", {'country': 'us'});
      var response = await http.get(
        uri,
        headers: {"X-Api-key": API_KEY},
      );
      log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTempList = [];

      if (data['code'] != null) {
        throw HttpException(data['code']);
        // throw data['message'];
      }
      for (var v in data["articles"]) {
        newsTempList.add(v);
        // log(v.toString());
        // print(data["articles"].length.toString());

      }
      return NewsModel.newsFromsnapshot(newsTempList);
    } catch (error) {
      throw error.toString();
    }
  }
  static Future<List<NewsModel>> searchNews({required String query}) async {
    try {
      var uri = Uri.http(BASEURL, "v2/everything", {
        "q":query,
        "pageSize": "10",
        "domains": "zdnet.com,techcrunch.com,cnbc.com,bloomberg.com,decrypt.co,cryptoslate.com,",

      });
      var response = await http.get(uri, headers: {"X-Api-key": API_KEY});
      // print('Response status: ${response.statusCode}');
      // log('Response body: ${response.body}');
      Map data = jsonDecode(response.body);
      List newsTemplist = [];
      if (data['code'] != null) {
        throw HttpException(data['code']);
      }
      for (var v in data['articles']) {
        newsTemplist.add(v);
        log(v.toString());
        print(data['articles'].length.toString());
      }
      return NewsModel.newsFromsnapshot(newsTemplist);
    } catch (error) {
      throw error.toString();
    }
  }
}
