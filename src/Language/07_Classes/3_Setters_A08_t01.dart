/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  It is a static warning if a class declares a static setter named v=
 * and also has a non-static member named v.
 * @description Checks that it is a static warning if a class declares a static
 * setter named v= and also has a non-static field named v.
 * @static-warning
 * @author kaigorodov
 */
import "../../Utils/expect.dart";

class C {
  String foo;
  
  static String foo2 = "foo";
  static set foo(String s) {
    foo2=s; 
  }
  static String get foo {
    return foo2; 
  }
  
}

main() {
  C.foo = "foo";
  Expect.equals(C.foo, "foo");
}
