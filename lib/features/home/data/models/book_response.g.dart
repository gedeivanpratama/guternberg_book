// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 1;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      id: fields[0] as int,
      title: fields[1] as String,
      authors: (fields[2] as List).cast<Author>(),
      translators: (fields[3] as List).cast<Author>(),
      subjects: (fields[4] as List).cast<String>(),
      bookshelves: (fields[5] as List).cast<String>(),
      languages: (fields[6] as List).cast<String>(),
      copyright: fields[7] as bool,
      mediaType: fields[8] as String,
      downloadCount: fields[9] as int,
      formats: fields[10] as Formats?,
      disLike: fields[12] as bool,
      like: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.translators)
      ..writeByte(4)
      ..write(obj.subjects)
      ..writeByte(5)
      ..write(obj.bookshelves)
      ..writeByte(6)
      ..write(obj.languages)
      ..writeByte(7)
      ..write(obj.copyright)
      ..writeByte(8)
      ..write(obj.mediaType)
      ..writeByte(9)
      ..write(obj.downloadCount)
      ..writeByte(10)
      ..write(obj.formats)
      ..writeByte(11)
      ..write(obj.like)
      ..writeByte(12)
      ..write(obj.disLike);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthorAdapter extends TypeAdapter<Author> {
  @override
  final int typeId = 2;

  @override
  Author read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Author(
      name: fields[1] as String,
      birthYear: fields[2] as int,
      deathYear: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Author obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.birthYear)
      ..writeByte(3)
      ..write(obj.deathYear);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FormatsAdapter extends TypeAdapter<Formats> {
  @override
  final int typeId = 3;

  @override
  Formats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Formats(
      image: fields[1] as String,
      webviewUrl: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Formats obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.webviewUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      disLike: json['disLike'] as bool? ?? false,
      like: json['like'] as bool? ?? false,
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
      'like': instance.like,
      'disLike': instance.disLike,
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
