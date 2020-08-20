import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citycollection/exceptions/DataFetchException.dart';
import 'package:citycollection/models/article.dart';
import 'package:citycollection/networking/data_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final DataRepository _dataRepository;
  final Logger logger = Logger("ArticlesBloc");
  ArticlesBloc(this._dataRepository);

  @override
  ArticlesState get initialState => ArticlesInitial();

  @override
  Stream<ArticlesState> mapEventToState(
    ArticlesEvent event,
  ) async* {
    if (event is FetchArticles) {
      yield* _fetchArticles();
    }
  }

  Stream<ArticlesState> _fetchArticles() async* {
    try {
      yield ArticlesFetchingLoading();
      logger.info("Articles Fetching...");
      //List<Article> articles = await _dataRepository.fetchArticles();
      // yield ArticlesFetchedSuccess(articles);
    } on DataFetchException catch (e) {
      logger.severe(e);
      yield ArticlesFetchingFailed(e.errorMsg);
    }
  }
}
