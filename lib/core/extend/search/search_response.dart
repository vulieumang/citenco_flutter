// import 'package:uuid/uuid.dart';

// class Name {
//   final String id;
//   final String name;

//   Name({this.name, this.id});
// }

// enum ResultType { hasData, hasError }
// enum ResponseType { init, completed, loading }

// class ListItem {
//   List items;
//   final ResultType resultType;
//   final String errorMessage;

//   ListItem({this.items, this.resultType, this.errorMessage});

//   factory ListItem.fromHasError(String errorMessage) {
//     return ListItem(
//         items: [], resultType: ResultType.hasError, errorMessage: errorMessage);
//   }

//   factory ListItem.fromItems(List items) {
//     List result = List.from(items).toList();
//     return ListItem(items: result, resultType: ResultType.hasData);
//   }

//   get isError => resultType == ResultType.hasError;
// }

// class SearchResponse {
//   final ListItem result;
//   final ResponseType loadingType;

//   SearchResponse({this.result, this.loadingType});

//   factory SearchResponse.init() => new SearchResponse(
//       result: new ListItem.fromItems(List()), loadingType: ResponseType.init);

//   factory SearchResponse.loading() => new SearchResponse(
//       result: new ListItem.fromItems(List()),
//       loadingType: ResponseType.loading);

//   factory SearchResponse.fromError(String errorMessage) => new SearchResponse(
//       result: new ListItem.fromHasError(errorMessage),
//       loadingType: ResponseType.completed);

//   factory SearchResponse.fromItems(List items) {
//     ListItem _result = ListItem.fromItems(items);
//     return SearchResponse(result: _result, loadingType: ResponseType.completed);
//   }

//   bool get isLoading => loadingType == ResponseType.loading;

//   bool get isInit => loadingType == ResponseType.init;

//   static factories<T>(dynamic data) =>
//       {Name: () => Name(id: Uuid().v4(), name: data)}[T]();
// }
