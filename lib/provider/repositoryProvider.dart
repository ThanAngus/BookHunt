import 'package:book_hunt/utils/service/bookService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../models/bookModel.dart';

final repositoryProvider = Provider((ref) {
  GetIt getIt = GetIt.instance;

  return RepositoryProvider(
    getIt: getIt,
  );
});

class RepositoryProvider {
  final GetIt getIt;

  RepositoryProvider({
    required this.getIt,
  });

  final BookService _bookService = GetIt.instance.get<BookService>();

  Future<List<Results>?> getBooks(
      {required String category, required int page}) async {
    try {
      return _bookService.fetchBooks(
        category: category,
        page: page,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<List<Results>?> searchData(
      {required String query, required int page, required String category}) async {
    try {
      return _bookService.searchBooks(
        page: page,
        searchQuery: query,
        category : category,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }
}
