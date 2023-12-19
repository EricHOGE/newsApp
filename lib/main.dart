import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_api/presentation/articles_page.dart';
import 'package:news_api/provider/repository_provider.dart';

import 'domain/usecases/get_articles_usecase.dart';
import 'presentation/cubit/articles/articles_cubit.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getArticlesUseCase =
        GetArticlesUseCase(BaseRepositoryProvider.articles);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            ArticlesCubit(getArticlesUseCase: getArticlesUseCase),
        child: const ArticlesPage(),
      ),
    );
  }
}
