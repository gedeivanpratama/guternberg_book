import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:guternberg_book/features/home/data/datasources/book_remote_datasource.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helper/fixture.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late BookRemoteDatasourceImp datasource;
  late MockDio mockDio;
  final jsonData = jsonDecode(fixture('book_response.json'));

  setUp(() {
    mockDio = MockDio();
    datasource = BookRemoteDatasourceImp(dio: mockDio);
  });

  group(
    'getBooks',
    () {
      final tBookParams = BookParams(page: '1');
      final tBookResponse = BookResponse.fromJson(jsonData);
      Future<Response<dynamic>> requestBook() => mockDio.get(
            "https://gutendex.com/books",
            queryParameters: tBookParams.queryParams(),
          );

      test(
        'should perform a GET request with the correct URL and query parameters',
        () async {
          // Arrange
          when(requestBook).thenAnswer((_) async => _successResponse(jsonData));

          // Act
          await datasource.getBooks(tBookParams);

          // Assert
          verify(
            () => mockDio.get(
              "https://gutendex.com/books",
              queryParameters: tBookParams.queryParams(),
            ),
          );
        },
      );

      test(
        'should return BookResponse when the response code is 200 (success)',
        () async {
          // Arrange
          when(requestBook).thenAnswer((_) async => _successResponse(jsonData));

          // Act
          final result = await datasource.getBooks(tBookParams);

          // Assert
          expect(result, tBookResponse);
        },
      );

      test(
        'should throw an exception when the call to remote data source is unsuccessful',
        () async {
          // Arrange
          when(requestBook).thenThrow(
            DioException(
              requestOptions: RequestOptions(
                path: 'https://gutendex.com/books',
              ),
            ),
          );

          // Act
          final call = datasource.getBooks;

          // Assert
          expect(() => call(tBookParams), throwsA(isA<DioException>()));
        },
      );
    },
  );
}

Response<dynamic> _successResponse(jsonData) => Response(
      data: jsonData,
      statusCode: 200,
      requestOptions: RequestOptions(
        path: 'https://gutendex.com/books',
      ),
    );
