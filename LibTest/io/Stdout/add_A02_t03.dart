/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion void add(List<int> data)
 * Adds byte data to the target consumer, ignoring [encoding].
 * The [encoding] does not apply to this method, and the [data] list is passed
 * directly to the target consumer as a stream event.
 * @description Checks that if [stdout] encoding is set to [null] then number
 * more than 256 are converted to some ASCII codes.
 * Maybe this test should be corrected, see issue #31670 for more details.
 * @author iarkh@unipro.ru
 */

import "../../../Utils/expect.dart";
import "dart:convert";
import "dart:io";
import "dart:typed_data";

bool called = false;
Int32List aList = new Int32List.fromList([254, 255, 256, 257, 1000]);
Int32List expected = new Int32List.fromList([254, 255, 0, 1, 232]);

run_process(IOSink sink) { sink.add(aList); }

run_main(String mode, Encoding enc) async {
  String executable = Platform.resolvedExecutable;
  String eScript = Platform.script.toString();

  await Process.run(executable, [eScript, mode],
      stdoutEncoding: enc, stderrEncoding: enc).
        then((ProcessResult results) {
        Expect.listEquals(
            expected, mode == "err" ? results.stderr : results.stdout);
    called = true;
  });
  Expect.isTrue(called);
}

main(List<String> args) {
  if(args.length > 0)
    run_process(args[0] == "err" ? stderr : stdout);
  else {
    run_main("out", null);
    run_main("err", null);
  }
}
