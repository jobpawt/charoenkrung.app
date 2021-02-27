import 'package:charoenkrung_app/data/bookData.dart';
import 'package:flutter/foundation.dart';

class BookProvider extends ChangeNotifier {
  List<BookData> books = new List();

  void add(BookData book) {
    books.add(book);
    notifyListeners();
  }

  void remove(BookData book) {
    var index = books.indexWhere((element) => element.book_id == book.book_id);
    books.removeAt(index);
    notifyListeners();
  }

  void addAll(List<BookData> bookList) {
    books.addAll(bookList);
    notifyListeners();
  }

  void edit(BookData book) {
    var index = books.indexWhere((element) => element.book_id == book.book_id);
    books[index] = book;
    notifyListeners();
  }
}