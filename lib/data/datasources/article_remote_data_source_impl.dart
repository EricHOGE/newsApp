import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import '../../core/params/params.dart';
import '../models/articles_response_model.dart';
import 'article_remote_data_source.dart';

class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio dio;

  ArticleRemoteDataSourceImpl({required this.dio});

  @override
  Future<ArticlesResponseModel> getArticles(
      {required SearchParams params}) async {
    DateTime now = DateTime.now();
    DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);
    String formattedDate = DateFormat('yyyy-MM-dd').format(oneMonthAgo);

    String url = dotenv.env['BASEURL'] as String;
    Map<String, dynamic> queryParams = {
      'q': params.name,
      'from': formattedDate,
      'sortBy': 'publishedAt',
      'apiKey': dotenv.env['APIKEY'] as String,
    };

    // Afficher l'URL et les paramètres de requête
    print('Requesting: $url with parameters $queryParams');

    try {
      final response = await dio.get(
        url,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        return ArticlesResponseModel.fromJson(
            response.data as Map<String, dynamic>);
      } else {
        throw Exception('Failed to load article');
      }
    } on DioException catch (e) {
      // Gestion des erreurs spécifiques à Dio
      throw Exception('Failed to load article: ${e.message}');
    } catch (e) {
      // Autres erreurs
      throw Exception('Unexpected error: ${e.toString()}');
    }
  }
}
