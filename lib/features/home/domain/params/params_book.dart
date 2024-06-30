import 'package:equatable/equatable.dart';

enum BookLanguage { en, ja, fr }

class BookParams extends Equatable {
  final String? page;
  final String? authorYearStart;
  final BookLanguage? languages;
  final bool? copyright;
  final String? ids;
  final String? search;
  final String? topic;
  final bool clear;

  BookParams copyWith({
    String? page,
    String? authorYearStart,
    BookLanguage? languages,
    bool? copyright,
    String? ids,
    String? search,
    String? topic,
    bool? clear,
  }) =>
      BookParams(
        ids: ids ?? this.ids,
        page: page ?? this.page,
        topic: topic ?? this.topic,
        search: search ?? this.search,
        languages: languages ?? this.languages,
        copyright: copyright ?? this.copyright,
        authorYearStart: authorYearStart ?? this.authorYearStart,
        clear: clear ?? this.clear,
      );
  BookParams({
    this.page,
    this.authorYearStart,
    this.languages,
    this.copyright,
    this.ids,
    this.search,
    this.topic,
    this.clear = false,
  });

  Map<String, dynamic> queryParams() {
    Map<String, dynamic> data = {'page': page};

    if (languages != null)
      data['languages'] = BookLanguage.values
          .firstWhere((element) => languages == element)
          .name;
    if (search?.isNotEmpty ?? "".isNotEmpty) data['search'] = search;
    if (topic?.isNotEmpty ?? "".isNotEmpty) data['topic'] = topic;

    return data;
  }

  @override
  List<Object?> get props => [
        this.page,
        this.authorYearStart,
        this.languages,
        this.copyright,
        this.ids,
        this.search,
        this.topic,
        this.clear,
      ];
}
