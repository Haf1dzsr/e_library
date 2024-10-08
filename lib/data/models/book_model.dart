class BookModel {
  int? id;
  String bookFile;
  String title;
  String bookCover;
  String author;
  String genre;
  int pageTotal;
  String synopsis;
  int publishedYear;
  bool isFavorited;

  BookModel({
    this.id,
    required this.bookFile,
    required this.bookCover,
    required this.title,
    required this.author,
    required this.genre,
    required this.pageTotal,
    required this.synopsis,
    required this.publishedYear,
    required this.isFavorited,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'book_file': bookFile,
      'book_cover': bookCover,
      'title': title,
      'author': author,
      'genre': genre,
      'page_total': pageTotal,
      'synopsis': synopsis,
      'published_year': publishedYear,
      'is_favorited': isFavorited ? 1 : 0,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      bookFile: map['book_file'],
      title: map['title'],
      bookCover: map['book_cover'],
      author: map['author'],
      genre: map['genre'],
      pageTotal: map['page_total'],
      synopsis: map['synopsis'],
      publishedYear: map['published_year'],
      isFavorited: map['is_favorited'] == 1,
    );
  }
}
