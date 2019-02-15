/*
 * Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Since the spread is unpacked and its individual elements added to
 * the containing collection, we don't require the spread expression itself to
 * be assignable to the collection's type. For example, this is allowed:
 *
 *    var numbers = <num>[1, 2, 3];
 *    var ints = <int>[...numbers];
 *
 * This works because the individual elements in numbers do happen to have the
 * right type even though the list that contains them does not. As long as the
 * spread object is "spreadable" — it implements [Iterable] — there is no
 * static error.
 * @description Checks that it's possible to have the spread expression which is
 * not assignable to the collection type for the map.
 * @author iarkh@unipro.ru
 */
// SharedOptions=--enable-experiment=spread-collections

import "../../Utils/expect.dart";

main() {
  var numbers = <num, num>{1: 1, 2: 2, 3: 3};
  Expect.mapEquals({1: 1, 2: 2, 3: 3}, <int, int>{...numbers});

  var objects = <Object, Object>{2: 22, 7: 77, 9: 99};
  Expect.mapEquals({2: 22, 7: 77, 9: 99}, <int, int>{...numbers});

  var a;
  Expect.throws(() => a = <String, int>{...objects});

  var strings = <String>[];
  Expect.mapEquals({11: 12}, <int, int>{11: 12, ...Strings});
}
