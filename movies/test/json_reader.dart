import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('/movies/test')) {
    dir = dir.replaceAll('/movies/test', '');
  }
  return File('$dir/movies/test/$name').readAsStringSync();
}
