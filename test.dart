import 'dart:core';
import 'dart:async';
import 'dart:io';

main() async {
  var server = await HttpServer.bind('localhost', 8080);
  server.listen((HttpRequest request) {
    request.response.write('Hello, World!');
    request.response.close();
  });
}