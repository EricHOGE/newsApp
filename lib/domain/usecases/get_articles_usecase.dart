import 'package:dartz/dartz.dart';

import '../../core/errors/failure.dart';
import '../../core/params/params.dart';
import '../entities/article_entity.dart';
import '../repositories/article_repository.dart';

class GetArticlesUseCase {
  final ArticleRepository repository;

  GetArticlesUseCase(this.repository);

  Future<Either<Failure, List<ArticleEntity>>> call(SearchParams params) async {
    return await repository.getArticles(params);
  }
}
