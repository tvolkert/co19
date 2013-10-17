/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion ListMixin<E> abstract class 
 * Implements List<E>
 * @description Checks that List-specific methods work as specified.
 * @author kaigorodov
 */
import "dart:collection";
import "../../core/List/allListTests.lib.dart" as allListTests;

test(List create([int length])) {
  allListTests.test(create);  
}
