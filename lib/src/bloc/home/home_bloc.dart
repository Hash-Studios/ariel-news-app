import 'package:bloc/bloc.dart';
import 'package:ariel/src/api/api_repository.dart';
import 'package:ariel/src/model/topheadlinesnews/response_top_headlinews_news.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataSuccess extends DataState {
  final ResponseTopHeadlinesNews data;

  DataSuccess(this.data);
}

class DataFailed extends DataState {
  final String errorMessage;

  DataFailed(this.errorMessage);
}

class DataEvent {
  final String category;

  DataEvent(this.category);
}

class RefreshData extends DataEvent {
  final String category;

  RefreshData({this.category})
      : assert(category != null),
        super(category);
}

class HomeBloc extends Bloc<DataEvent, DataState> {
  @override
  DataState get initialState => DataInitial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();
    final apiRepository = ApiRepository();
    final categoryLowerCase = event.category.toLowerCase();
    if (event is RefreshData) {
      final data = await apiRepository.fetchTopHeadline(event.category);
      if (data.error == null) {
        yield DataSuccess(data);
      } else {
        yield DataFailed('Failed to fetch data');
      }
    } else {
      switch (categoryLowerCase) {
        case 'all':
          final data = await apiRepository.fetchTopHeadlinesNews();
          if (data.error == null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed('Failed to fetch data');
          }
          break;
        case 'business':
          final data = await apiRepository.fetchTopBusinessHeadlinesNews();
          if (data.error == null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
          break;
        case 'entertainment':
          final data = await apiRepository.fetchTopEntertainmentHeadlinesNews();
          if (data.error == null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
          break;
        case 'health':
          final data = await apiRepository.fetchTopHealthHeadlinesNews();
          if (data.error == null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
          break;
        case 'science':
          final data = await apiRepository.fetchTopScienceHeadlinesNews();
          if (data.error == null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
          break;
        case 'sport':
          final data = await apiRepository.fetchTopSportHeadlinesNews();
          if (data != null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
          break;
        case 'tech':
          final data = await apiRepository.fetchTopTechnologyHeadlinesNews();
          if (data != null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
          break;
        default:
          final data = await apiRepository.fetchSearchNews(categoryLowerCase);
          if (data != null) {
            yield DataSuccess(data);
          } else {
            yield DataFailed(data.error);
          }
      }
    }
  }
}
