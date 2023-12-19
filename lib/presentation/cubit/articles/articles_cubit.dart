import 'package:bloc/bloc.dart';
import 'package:news_api/core/params/params.dart';
import 'package:news_api/presentation/cubit/articles/articles_state.dart';

import '../../../core/errors/failure.dart';
import '../../../domain/usecases/get_articles_usecase.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  ArticlesCubit({required GetArticlesUseCase getArticlesUseCase})
      : _getArticlesUseCase = getArticlesUseCase,
        super(ArticlesState.initial());

  Future<void> getArticlesCubit(SearchParams params) async {
    emit(state.copyWith(status: ArticlesStateStatus.loading));
    try {
      final result = await _getArticlesUseCase(params);
      print('resultat cubit $result');

      // Fonction pour extraire le message d'erreur
      String getFailureMessage(Failure failure) {
        if (failure is ServerFailure) {
          return failure.errorMessage;
        }
        return 'Unknown Failure';
      }

      result.fold(
        (failure) {
          final message = getFailureMessage(failure);
          print('Résultat Cubit: Left, Message: $message');
          emit(
            state.copyWith(
              status: ArticlesStateStatus.error,
              failure: failure,
            ),
          );
        },
        (articles) => emit(
          state.copyWith(
            status: ArticlesStateStatus.loaded,
            articles: articles,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: ArticlesStateStatus.error,
        failure: ServerFailure(errorMessage: 'oupppsss'),
      ));
    }
  }
}
