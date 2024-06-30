// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookResponse _$BookResponseFromJson(Map<String, dynamic> json) => BookResponse(
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String? ?? "",
      previous: json['previous'] as String? ?? "",
      books: (json['results'] as List<dynamic>?)
              ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BookResponseToJson(BookResponse instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.books.map((e) => e.toJson()).toList(),
    };

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? "",
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      translators: (json['translators'] as List<dynamic>?)
              ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      subjects: (json['subjects'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bookshelves: (json['bookshelves'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      copyright: json['copyright'] as bool? ?? true,
      mediaType: json['media_type'] as String? ?? "",
      downloadCount: (json['download_count'] as num?)?.toInt() ?? 0,
      formats: json['formats'] == null
          ? null
          : Formats.fromJson(json['formats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authors': instance.authors.map((e) => e.toJson()).toList(),
      'translators': instance.translators.map((e) => e.toJson()).toList(),
      'subjects': instance.subjects,
      'bookshelves': instance.bookshelves,
      'languages': instance.languages,
      'copyright': instance.copyright,
      'media_type': instance.mediaType,
      'download_count': instance.downloadCount,
      'formats': instance.formats?.toJson(),
    };

Author _$AuthorFromJson(Map<String, dynamic> json) => Author(
      name: json['name'] as String? ?? "",
      birthYear: (json['birth_year'] as num?)?.toInt() ?? 0,
      deathYear: (json['death_year'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'name': instance.name,
      'birth_year': instance.birthYear,
      'death_year': instance.deathYear,
    };

Formats _$FormatsFromJson(Map<String, dynamic> json) => Formats(
      image: json['image/jpeg'] as String? ?? "",
      webviewUrl: json['text/html'] as String? ?? "",
    );

Map<String, dynamic> _$FormatsToJson(Formats instance) => <String, dynamic>{
      'image/jpeg': instance.image,
      'text/html': instance.webviewUrl,
    };
