import 'dart:io';

String fixture(String name) {
  var currentDirectory = Directory.current.toString().replaceAll('\'', '');
  var lastDirectory =
      currentDirectory.split('/')[currentDirectory.split('/').length - 1];
  if (lastDirectory == 'test') {
    return File('json/$name').readAsStringSync();
  } else {
    return File('test/json/$name').readAsStringSync();
  }
}
