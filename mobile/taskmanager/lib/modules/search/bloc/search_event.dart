part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchOpen extends SearchEvent {
  const SearchOpen();
}

class SearchEnterQuery extends SearchEvent {
  final String query;
  const SearchEnterQuery({required this.query});

  @override
  List<Object> get props => [query];
}

class SearchCancel extends SearchEvent {
  const SearchCancel();
}