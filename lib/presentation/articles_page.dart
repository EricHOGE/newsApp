import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/params/params.dart';
import 'cubit/articles/articles_cubit.dart';
import 'cubit/articles/articles_state.dart';
import 'cubit/articles/widgets/article_card.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final articleCubit = context.read<ArticlesCubit>();
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recherche d\'articles',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Rechercher un article',
                hintText: 'Tapez un mot-clé',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    SearchParams params =
                        SearchParams(name: searchController.text);
                    articleCubit.getArticlesCubit(params);
                  },
                ),
              ),
              onSubmitted: (value) {
                SearchParams params = SearchParams(name: value);
                articleCubit.getArticlesCubit(params);
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<ArticlesCubit, ArticlesState>(
              builder: (context, state) {
                if (state.status == ArticlesStateStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == ArticlesStateStatus.loaded) {
                  return ListView.builder(
                    itemCount: state.articles.length,
                    itemBuilder: (context, index) {
                      final article = state.articles[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ArticleCard(
                          title: article.title,
                          author: article.author,
                          description: article.description,
                          urlToImage: article.urlToImage,
                          publishedAt: article.publishedAt,
                          content: article.content,
                          sourceName: article.sourceName,
                          url: article.url,
                        ),
                      );
                    },
                  );
                } else if (state.status == ArticlesStateStatus.error) {
                  return const Center(
                      child: Text('Erreur lors de la recherche d\'articles'));
                }
                // Vue par défaut quand il n'y a pas de recherche ou en attente de saisie
                return const Center(
                    child: Text('Veuillez rechercher un article'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
