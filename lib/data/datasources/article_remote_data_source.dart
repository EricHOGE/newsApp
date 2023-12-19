import 'package:news_api/data/models/articles_response_model.dart';

import '../../core/params/params.dart';

abstract class ArticleRemoteDataSource {
  Future<ArticlesResponseModel> getArticles({required SearchParams params});
}
