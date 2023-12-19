import 'package:dartz/dartz.dart';
import 'package:news_api/core/errors/failure.dart';
import 'package:news_api/core/params/params.dart';
import 'package:news_api/domain/entities/article_entity.dart';
import 'package:news_api/domain/repositories/article_repository.dart';

import '../datasources/article_remote_data_source.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource articleRemoteDataSource;

  ArticleRepositoryImpl({required this.articleRemoteDataSource});

  @override
  Future<Either<Failure, List<ArticleEntity>>> getArticles(
      SearchParams params) async {
    try {
      final response =
          await articleRemoteDataSource.getArticles(params: params);
      print('repo : response.articles ${response.articles}');
      // Conversion des articles en entités de domaine et renvoi d'un Right
      return Right(
          response.articles.map((article) => article.toDomain()).toList());
    } catch (e) {
      return Left(ServerFailure(errorMessage: 'erreur serveur '));
    }
  }
}
