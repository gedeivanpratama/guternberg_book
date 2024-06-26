import 'package:flutter_test/flutter_test.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';

void main() {
  group('BookParams', () {
    test('should correctly create queryParams map', () {
      final bookParams = BookParams(
        page: '1',
        authorYearStart: '1990',
        languages: BookLanguage.en,
        copyright: true,
        ids: '123',
        search: 'test',
        topic: 'science',
      );

      final expectedMap = {
        'page': '1',
        'author_year_start': '1990',
        'languages': BookLanguage.en,
        'copyright': true,
        'ids': '123',
        'search': 'test',
        'topic': 'science',
      };

      expect(bookParams.queryParams(), equals(expectedMap));
    });

    test('should handle null values correctly in queryParams map', () {
      final bookParams = BookParams();

      final expectedMap = {'page': null};

      expect(bookParams.queryParams(), equals(expectedMap));
    });

    test('should be equatable', () {
      final bookParams1 = BookParams(
        page: '1',
        authorYearStart: '1990',
        languages: BookLanguage.en,
        copyright: true,
        ids: '123',
        search: 'test',
        topic: 'science',
      );

      final bookParams2 = BookParams(
        page: '1',
        authorYearStart: '1990',
        languages: BookLanguage.en,
        copyright: true,
        ids: '123',
        search: 'test',
        topic: 'science',
      );

      expect(bookParams1, equals(bookParams2));
    });

    test('should not be equal if properties differ', () {
      final bookParams1 = BookParams(
        page: '1',
        authorYearStart: '1990',
        languages: BookLanguage.en,
        copyright: true,
        ids: '123',
        search: 'test',
        topic: 'science',
      );

      final bookParams2 = BookParams(
        page: '2',
        authorYearStart: '2000',
        languages: BookLanguage.ja,
        copyright: false,
        ids: '456',
        search: 'example',
        topic: 'math',
      );

      expect(bookParams1, isNot(equals(bookParams2)));
    });
  });
}
