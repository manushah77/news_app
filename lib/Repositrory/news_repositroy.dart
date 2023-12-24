import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/model/category_mode.dart';
import 'package:news_app/model/news_channel_headlibes_model.dart';
class NewsRepository {
  Future<NewsChannelHeadlineModel> fetchNewsHeadlinesApi (String name) async{
    String url = 'https://newsapi.org/v2/top-headlines?sources=${name}&apiKey=e393bfe227be476a85dd71970a414b22';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlineModel.fromJson(body);

    }
    throw Exception('Error fech data');


  }
  Future<CategoryModel> fetchNewsCategoriesApi (String category) async{
    String url = 'https://newsapi.org/v2/everything?q=${category}&apiKey=e393bfe227be476a85dd71970a414b22';
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryModel.fromJson(body);

    }
    throw Exception('Error fech data');


  }
}