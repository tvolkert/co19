/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion bool requestClientCertificate
 * final
 *
 * @description Checks that property requestClientCertificate returns a default
 * value false, if the corresponding parameter of bind method was not set.
 * @author ngl@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

check(InternetAddress address) {
  asyncStart();
  SecurityContext sc = new SecurityContext(withTrustedRoots: true);
  RawSecureServerSocket.bind(address, 0, sc).then((server) {
    Expect.isFalse(server.requestClientCertificate);
    server.close();
    asyncEnd();
  });
}

main() {
  check(InternetAddress.ANY_IP_V4);
  check(InternetAddress.ANY_IP_V6);
  check(InternetAddress.LOOPBACK_IP_V4);
  check(InternetAddress.LOOPBACK_IP_V6);
}
