import 'package:bloc/bloc.dart';
import 'package:flutter_news_app/src/api/api_repository.dart';
import 'package:flutter_news_app/src/model/topheadlinesnews/response_top_headlinews_news.dart';

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

// class RefreshData extends DataEvent {
//   final String category;

//   RefreshData({this.category})
//       : assert(category != null),
//         super(category);
// }

class HomeBloc extends Bloc<DataEvent, DataState> {
  @override
  DataState get initialState => DataInitial();

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    yield DataLoading();
    final apiRepository = ApiRepository();
    final categoryLowerCase = event.category.toLowerCase();
    // if (event is RefreshData) {
    //   final data = await apiRepository.fetchTopHeadline(event.category);
    //   if (data.error == null) {
    //     yield DataSuccess(data);
    //   } else {
    //     yield DataFailed('Failed to fetch data');
    //   }
    // }
    switch (categoryLowerCase) {
      case 'all':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed('Failed to fetch data');
        //   }
        // }
        final data = await apiRepository.fetchTopHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed('Failed to fetch data');
        }
        break;
      case 'business':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopBusinessHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed(data.error);
        //   }
        // }
        final data = await apiRepository.fetchTopBusinessHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error);
        }
        break;
      case 'entertainment':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopEntertainmentHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed(data.error);
        //   }
        // }
        final data = await apiRepository.fetchTopEntertainmentHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error);
        }
        break;
      case 'health':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopHealthHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed(data.error);
        //   }
        // }
        final data = await apiRepository.fetchTopHealthHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error);
        }
        break;
      case 'science':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopScienceHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed(data.error);
        //   }
        // }
        final data = await apiRepository.fetchTopScienceHeadlinesNews();
        if (data.error == null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error);
        }
        break;
      case 'sport':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopSportHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed(data.error);
        //   }
        // }
        final data = await apiRepository.fetchTopSportHeadlinesNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error);
        }
        break;
      case 'tech':
        // if (event is RefreshData) {
        //   final data = await apiRepository.fetchTopTechnologyHeadlinesNews();
        //   if (data != null) {
        //     yield DataSuccess(data);
        //   } else {
        //     yield DataFailed(data.error);
        //   }
        // }
        final data = await apiRepository.fetchTopTechnologyHeadlinesNews();
        if (data != null) {
          yield DataSuccess(data);
        } else {
          yield DataFailed(data.error);
        }
        break;
      default:
        yield DataFailed('Unknown category');
    }
  }
}
