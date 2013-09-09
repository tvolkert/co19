/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Local variables are added to the innermost enclosing scope.
 * They do not induce getters and setters.  A local variable may only be
 * referenced at a source code location that is after the variable declaration
 * is complete, or a compile-time error occurs.
 * @description Checks that local variable getters and setters are not
 * accessible before that variable's declaration.
 * @static-warning
 * @author kaigorodov
 * @reviewer rodionov
 * @issue 7481
 */
import "../../Utils/expect.dart";
 
void test1() {
  var v = w; /// static type warning - unresolved identifier w
  var w;
}

void test2() {
  v = 1; /// static type warning - unresolved identifier v (12.30)
  var v;
}

main() {
  Expect.throws(test1, (e) => e is NoSuchMethodError);
  Expect.throws(test2, (e) => e is NoSuchMethodError);
}
