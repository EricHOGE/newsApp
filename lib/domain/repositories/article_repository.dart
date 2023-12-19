import 'package:dartz/dartz.dart';
import 'package:news_api/core/params/params.dart';
import 'package:news_api/domain/entities/article_entity.dart';

import '../../core/errors/failure.dart';

abstract class ArticleRepository {
  Future<Either<Failure, List<ArticleEntity>>> getArticles(SearchParams params);
}
