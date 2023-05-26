import 'package:book_hunt/models/bookModel.dart';
import 'package:book_hunt/models/categoryTiles.dart';
import 'package:book_hunt/utils/service/http_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class BookService {
  final GetIt getIt = GetIt.instance;
  late HTTPService _httpService;

  BookService(){
    _httpService = getIt.get<HTTPService>();
  }

  Future<List<Results>> fetchBooks({required int page, required String category}) async{
    Response? bookResponse = await _httpService.get(page, customQuery: {
      'topic' : category,
    });
    if(bookResponse!.statusCode == 200){
      var bookData = bookResponse.data;
      List<Results> booksList = bookData['results'].map<Results>((bookData){
        return Results.fromJson(bookData);
      }).toList();
      return booksList;
    }else {
      throw Exception('Couldn\'t load books.');
    }
  }

  Future<List<Results>> searchBooks({required int page, required searchQuery, required String category}) async{
    Response? searchResponse = await _httpService.get(page,customQuery:{
      'topic' : category,
      'search' : searchQuery,
    });
    if(searchResponse!.statusCode == 200){
      var searchData = searchResponse.data;
      List<Results> booksList = searchData['results'].map<Results>((bookData){
        return Results.fromJson(bookData);
      }).toList();
      return booksList;
    }else {
      throw Exception('Couldn\'t load books.');
    }
  }
}