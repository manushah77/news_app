
import 'package:news_app/Repositrory/news_repositroy.dart';
import 'package:news_app/model/category_mode.dart';
import 'package:news_app/model/news_channel_headlibes_model.dart';

class NewsViewModel {
  final rep = NewsRepository();

  Future<NewsChannelHeadlineModel> fetchNewsApi (String name) async{
    final response = await rep.fetchNewsHeadlinesApi(name);
    return response;
  }
  Future<CategoryModel> fetchNewsCategoriesApi (String category) async{
    final response =await rep.fetchNewsCategoriesApi(category);
    return response;
  }

}