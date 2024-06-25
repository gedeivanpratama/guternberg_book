import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:guternberg_book/features/home/data/models/book_response.dart';

import '../../../../helper/fixture.dart';

void main() {
  final jsonData = jsonDecode(fixture('book_response.json'));
  final tModel = BookResponse.fromJson(jsonData);

  test(
    "verify model to json",
    () {
      expect(tModel.toJson(), jsonData);
    },
  );
}
