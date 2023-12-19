import 'package:equatable/equatable.dart';
import 'package:news_api/domain/entities/article_entity.dart';

import '../../../core/errors/failure.dart';

enum ArticlesStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class ArticlesState extends Equatable {
  final ArticlesStateStatus status;
  final List<ArticleEntity> articles;
  final Failure? failure;

  const ArticlesState({
    required this.status,
    required this.articles,
    this.failure,
  });

  @override
  List<Object?> get props => [status, articles, failure];

  ArticlesState copyWith({
    ArticlesStateStatus? status,
    List<ArticleEntity>? articles,
    Failure? failure,
  }) {
    return ArticlesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      failure: failure ?? this.failure,
    );
  }

  factory ArticlesState.initial() {
    return const ArticlesState(
      status: ArticlesStateStatus.initial,
      articles: [],
    );
  }
}
