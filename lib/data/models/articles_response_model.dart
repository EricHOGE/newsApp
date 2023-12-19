import 'package:equatable/equatable.dart';

import 'article_model.dart';

class ArticlesResponseModel extends Equatable {
  final String status;
  final List<ArticleModel> articles;

  const ArticlesResponseModel({
    required this.status,
    required this.articles,
  });

  factory ArticlesResponseModel.fromJson(Map<String, dynamic> json) {
    return ArticlesResponseModel(
      status: json['status'] as String,
      articles: (json['articles'] as List<dynamic>)
          .map((articleJson) =>
              ArticleModel.fromJson(articleJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [status, articles];
}
