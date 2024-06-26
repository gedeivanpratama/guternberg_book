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

  BookParams({
    this.page,
    this.authorYearStart,
    this.languages,
    this.copyright,
    this.ids,
    this.search,
    this.topic,
  });

  Map<String, dynamic> queryParams() {
    Map<String, dynamic> data = {'page': page};

    if (authorYearStart != null) data['author_year_start'] = authorYearStart;
    if (languages != null) data['languages'] = languages;
    if (copyright != null) data['copyright'] = copyright;
    if (ids != null) data['ids'] = ids;
    if (search != null) data['search'] = search;
    if (topic != null) data['topic'] = topic;

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
      ];
}
