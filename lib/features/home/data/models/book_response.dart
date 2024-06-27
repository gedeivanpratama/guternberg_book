import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_response.g.dart';

@JsonSerializable(explicitToJson: true)
class BookResponse extends Equatable {
  final int count;
  final String next;
  final String previous;
  @JsonKey(name: "results")
  final List<Book> books;

  BookResponse copyWith({
    int? count,
    String? next,
    String? previous,
    List<Book>? books,
  }) =>
      BookResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        books: books ?? this.books,
      );

  const BookResponse({
    this.count = 0,
    this.next = "",
    this.previous = "",
    this.books = const [],
  });
  factory BookResponse.fromJson(Map<String, dynamic> json) =>
      _$BookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookResponseToJson(this);

  @override
  List<Object?> get props => [count, next, previous, books];
}

@JsonSerializable(explicitToJson: true)
class Book extends Equatable {
  final int id;
  final String title;
  final List<Author> authors;
  final List<Author> translators;
  final List<String> subjects;
  final List<String> bookshelves;
  final List<String> languages;
  final bool copyright;
  @JsonKey(name: "media_type")
  final String mediaType;
  @JsonKey(name: "download_count")
  final int downloadCount;

  Book({
    this.id = 0,
    this.title = "",
    this.authors = const [],
    this.translators = const [],
    this.subjects = const [],
    this.bookshelves = const [],
    this.languages = const [],
    this.copyright = true,
    this.mediaType = "",
    this.downloadCount = 0,
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        translators,
        subjects,
        bookshelves,
        languages,
        copyright,
        mediaType,
        downloadCount,
      ];
}

@JsonSerializable(explicitToJson: true)
class Author extends Equatable {
  final String name;
  @JsonKey(name: "birth_year")
  final int birthYear;
  @JsonKey(name: "death_year")
  final int deathYear;

  Author({
    this.name = "",
    this.birthYear = 0,
    this.deathYear = 0,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);

  @override
  List<Object?> get props => [name, birthYear, deathYear];
}
