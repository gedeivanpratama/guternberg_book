import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guternberg_book/core/errors/error_message.dart';
import 'package:guternberg_book/core/errors/errors_handling.dart';
import 'package:guternberg_book/core/utils/network_info.dart';
import 'package:guternberg_book/features/home/data/datasources/book_remote_datasource.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';
import 'package:guternberg_book/features/home/data/repositories/book_repository_imp.dart';
import 'package:guternberg_book/features/home/domain/params/params_book.dart';
import 'package:mocktail/mocktail.dart';

class MockBookRemoteDatasource extends Mock implements BookRemoteDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockBookRemoteDatasource datasource;
  late MockNetworkInfo networkInfo;

  late BookRepositoryImp repository;
  final params = BookParams(page: "1");
  final response = BookResponse();

  setUpAll(() {
    networkInfo = MockNetworkInfo();
    datasource = MockBookRemoteDatasource();
    repository = BookRepositoryImp(
      datasource: datasource,
      networkInfo: networkInfo,
    );
  });

  test("get books success", () async {
    // Arrage
    when(() => networkInfo.isNotConnected()).thenAnswer((_) async => false);
    when(() => datasource.getBooks(params)).thenAnswer((_) async => response);

    //Act
    final result = await repository.getBooks(params);

    //Assert
    verify(() => datasource.getBooks(params));
    expect(result, Success(response));
  });

  test('get book failure (Server Error)', () async {
    final errorResponse = DioException(requestOptions: RequestOptions());
    // Arrage
    when(() => networkInfo.isNotConnected()).thenAnswer((_) async => false);
    when(() => datasource.getBooks(params)).thenThrow(errorResponse);

    //Act
    final result = await repository.getBooks(params);

    //Assert
    verify(() => datasource.getBooks(params));
    final failure = result as Failure<BookResponse, Exception>;
    expect(result, isA<Failure<BookResponse, Exception>>());
    expect((failure.exception as CustomError).message, equals('Server Error'));
  });

  test('get book failure (not connected to internet)', () async {
    when(() => networkInfo.isNotConnected()).thenAnswer((_) async => true);
    when(() => datasource.getBooks(params)).thenAnswer((_) async => response);

    //Act
    final result = await repository.getBooks(params);

    //Assert
    verifyNever(() => datasource.getBooks(params));
    final failure = result as Failure<BookResponse, Exception>;
    expect(result, isA<Failure<BookResponse, Exception>>());
    expect(
      (failure.exception as CustomError).message,
      equals('Your Device Not Conected To Internet'),
    );
  });

  test('get book failure (Bad request)', () async {
    final errorResponse = DioException(
      requestOptions: RequestOptions(),
      response: Response(statusCode: 400, requestOptions: RequestOptions()),
    );
    // Arrage
    when(() => networkInfo.isNotConnected()).thenAnswer((_) async => false);
    when(() => datasource.getBooks(params)).thenThrow(errorResponse);

    //Act
    final result = await repository.getBooks(params);

    //Assert
    verify(() => datasource.getBooks(params));
    final failure = result as Failure<BookResponse, Exception>;
    expect(result, isA<Failure<BookResponse, Exception>>());
    expect((failure.exception as CustomError).message, equals('Bad request'));
  });

  test(
    'get book failure (Not Found)',
    () async {
      final errorResponse = DioException(
        requestOptions: RequestOptions(),
        response: Response(statusCode: 404, requestOptions: RequestOptions()),
      );
      // Arrage
      when(() => networkInfo.isNotConnected()).thenAnswer((_) async => false);
      when(() => datasource.getBooks(params)).thenThrow(errorResponse);

      //Act
      final result = await repository.getBooks(params);

      //Assert
      verify(() => datasource.getBooks(params));
      final failure = result as Failure<BookResponse, Exception>;
      expect(result, isA<Failure<BookResponse, Exception>>());
      expect(
        (failure.exception as CustomError).message,
        equals('Data Not Found'),
      );
    },
  );
}
