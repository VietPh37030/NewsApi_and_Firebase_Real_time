



import 'package:flutter/cupertino.dart';
import 'package:new_paper_pj/services/news_api.dart';

import '../models/news_model.dart';


class NewsProvider with ChangeNotifier {
  List<NewsModel> newsList = [];

  List<NewsModel> get getNewsList {
    return newsList;
  }

Future<List<NewsModel>> fetchAllNews({required int pageIndex,required String sortBy}) async{
    newsList = await NewsApiService.getAllNews(page: pageIndex, sortBy: sortBy);
    return newsList;
}
NewsModel  finByDate({required String publishedAt}){
    return newsList.firstWhere((newsModel)=>newsModel.publishedAt ==publishedAt);
}
  Future<List<NewsModel>> fetchTopHeadlines() async{
    newsList = await NewsApiService.getTopHeadlines();
    return newsList;
  }
  Future<List<NewsModel>> searchNesProvider({ required String query}) async{
    newsList = await NewsApiService.searchNews(query: query);
    return newsList;
  }
}
