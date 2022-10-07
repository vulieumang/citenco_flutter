// import 'dart:async';

// import 'package:rxdart/rxdart.dart';

// import 'search_api.dart';
// import 'search_request.dart';
// import 'search_response.dart';

// class SearchStream {
//   StreamController<SearchRequest> ctrl;
//   Stream<SearchResponse> state;

//   SearchStream(SearchAPI api, {void Function(SearchResponse data) doOnData}) {
//     ctrl = new StreamController<SearchRequest>();
//     state = ctrl.stream
//         .distinct()
//         .debounceTime(const Duration(milliseconds: 300))
//         .switchMap(searchWith(api))
//         .doOnData(doOnData ?? (r) => {})
//         .startWith(new SearchResponse.init())
//         .asBroadcastStream();
//   }

//   Stream<SearchResponse> Function(SearchRequest) searchWith(SearchAPI api) {
//     return (SearchRequest payload) {
//       return new Stream<List>.fromFuture(api.search(payload))
//           .map<SearchResponse>((List listItem) {
//             return new SearchResponse.fromItems(listItem);
//           })
//           .startWith(SearchResponse.loading())
//           .onErrorReturn(new SearchResponse.fromError("Something wrong..."));
//     };
//   }
// }
