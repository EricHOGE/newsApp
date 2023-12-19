import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_api/core/params/params.dart';
import 'package:news_api/data/datasources/article_remote_data_source_impl.dart';
import 'package:news_api/data/models/articles_response_model.dart';

void main() {
  test('Test ArticleRemoteDataSourceImpl', () async {
    final dio = Dio();
    final articleDataSource = ArticleRemoteDataSourceImpl(dio: dio);
    const searchParams = SearchParams(name: 'flutter');

    try {
      final articlesResponse =
          await articleDataSource.getArticles(params: searchParams);
      expect(articlesResponse, isA<ArticlesResponseModel>());
    } catch (e) {
      fail('Failed to load articles: $e');
    }
  });
}
