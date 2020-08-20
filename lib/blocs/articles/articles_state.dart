part of 'articles_bloc.dart';

abstract class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

class ArticlesInitial extends ArticlesState {}

class ArticlesFetchedSuccess extends ArticlesState {
  final List<Article> articles;

  ArticlesFetchedSuccess(this.articles);
}

class ArticlesFetchingFailed extends ArticlesState {
  final String errorMsg;

  ArticlesFetchingFailed(this.errorMsg);
}

class ArticlesFetchingLoading extends ArticlesState {}
