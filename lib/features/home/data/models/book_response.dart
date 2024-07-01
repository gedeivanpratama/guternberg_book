import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
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

@HiveType(typeId: 1)
@JsonSerializable(explicitToJson: true)
class Book extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final List<Author> authors;
  @HiveField(3)
  final List<Author> translators;
  @HiveField(4)
  final List<String> subjects;
  @HiveField(5)
  final List<String> bookshelves;
  @HiveField(6)
  final List<String> languages;
  @HiveField(7)
  final bool copyright;
  @HiveField(8)
  @JsonKey(name: "media_type")
  final String mediaType;
  @HiveField(9)
  @JsonKey(name: "download_count")
  final int downloadCount;
  @HiveField(10)
  @JsonKey(name: "formats")
  final Formats? formats;
  @HiveField(11)
  final bool like;
  @HiveField(12)
  final bool disLike;

  Book copyWith({
    int? id,
    String? title,
    List<Author>? authors,
    List<Author>? translators,
    List<String>? subjects,
    List<String>? bookshelves,
    List<String>? languages,
    bool? copyright,
    String? mediaType,
    int? downloadCount,
    Formats? format,
    bool? like,
    bool? disLike,
  }) =>
      Book(
        id: id ?? this.id,
        title: title ?? this.title,
        authors: authors ?? this.authors,
        translators: translators ?? this.translators,
        subjects: subjects ?? this.subjects,
        bookshelves: bookshelves ?? this.bookshelves,
        languages: languages ?? this.languages,
        copyright: copyright ?? this.copyright,
        mediaType: mediaType ?? this.mediaType,
        formats: formats ?? this.formats,
        downloadCount: downloadCount ?? this.downloadCount,
        like: like ?? this.like,
        disLike: disLike ?? this.disLike,
      );

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
    this.formats,
    this.disLike = false,
    this.like = false,
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
        formats,
        like,
        disLike,
      ];
}

@HiveType(typeId: 2)
@JsonSerializable(explicitToJson: true)
class Author extends Equatable {
  @HiveField(1)
  final String name;
  @HiveField(2)
  @JsonKey(name: "birth_year")
  final int birthYear;
  @HiveField(3)
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

@HiveType(typeId: 3)
@JsonSerializable(explicitToJson: true)
class Formats extends Equatable {
  @HiveField(1)
  @JsonKey(name: "image/jpeg")
  final String image;
  @HiveField(2)
  @JsonKey(name: "text/html")
  final String webviewUrl;

  Formats({
    this.image = "",
    this.webviewUrl = "",
  });

  factory Formats.fromJson(Map<String, dynamic> json) =>
      _$FormatsFromJson(json);

  Map<String, dynamic> toJson() => _$FormatsToJson(this);

  @override
  List<Object?> get props => [image, webviewUrl];
}
