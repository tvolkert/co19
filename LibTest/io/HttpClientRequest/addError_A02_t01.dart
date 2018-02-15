/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion void addError(
 *  error, [
 *  StackTrace stackTrace
 * ])
 * Passes the error to the target consumer as an error event.
 *
 * This function must not be called when a stream is currently being added using
 * addStream.
 *
 * This operation is non-blocking. See flush or done for how to get any errors
 * generated by this call.
 * @description Checks that this method must not be called when a stream is
 * currently being added using addStream.
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "dart:convert";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

var localhost = InternetAddress.LOOPBACK_IP_V4.address;

test(String method) async {
  Stream<List> stream = new Stream<List>.fromIterable(
      [[1, 2, 3, 4, 5], [12], [3, 14, 15]]);

  asyncStart();
  String helloWorld = "Hello test world!";
  HttpServer server = await HttpServer.bind(localhost, 0);
  server.listen((HttpRequest request) {
    request.toList().then((data) {
      Expect.listEquals([[1, 2, 3, 4, 5, 12, 3, 14, 15]], data);
      request.response.write(helloWorld);
      request.response.close();
      server.close();
    });
  });

  HttpClient client = new HttpClient();
  client.open(method, localhost, server.port, "")
      .then((HttpClientRequest request) {
    request.contentLength = 9;
    Future<HttpClientResponse> f = request.addStream(stream).then(
        (var request) {
          return request.close();
    });
    Expect.throws(() {
      request.addError("Error");
    });
    f.then((HttpClientResponse response) {
      response.transform(UTF8.decoder).listen((content) {});
      asyncEnd();
    });
  });
}

main() {
  test("get");
  test("head");
  test("delete");
  test("put");
  test("post");
  test("patch");
}
