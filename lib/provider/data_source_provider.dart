import 'package:dio/dio.dart';
import 'package:news_api/data/datasources/article_remote_data_source_impl.dart';

import '../data/datasources/article_remote_data_source.dart';

class DataSourceProvider {
  static final ArticleRemoteDataSource articles = ArticleRemoteDataSourceImpl(
    dio: Dio(),
  );
}
