import 'package:news_api/data/repositories/article_repository_impl.dart';
import 'package:news_api/domain/repositories/article_repository.dart';

import 'data_source_provider.dart';

class BaseRepositoryProvider {
  static final ArticleRepository articles = ArticleRepositoryImpl(
    articleRemoteDataSource: DataSourceProvider.articles,
  );
}
