/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  Future<List> wait(Iterable<Future> futures)
 * Wait for all the given futures to complete and collect their values.
 * Returns a future which will complete once all the futures in a list are complete.
 * @description Checks that the returned future is completed when all futures in the list
 * are completed.
 * @author kaigorodov
 */

import "dart:async";

const N=5;
const N2=3;

main() {
  List<Completer> completers=new List<Completer>(N);
  for (int k=0; k<N; k++) {
    completers[k] = new Completer();
  }
  List<Future> futures=new List<Future>(N);
  for (int k=0; k<N; k++) {
    futures[k] = completers[k].future;
  }

  Future f = Future.wait(futures);

  bool visited = false;
  f.then((value) {
    visited = true;
    Expect.listEquals([0,1,2,3,4], value);
  });

  // complete first half of the futures
  for (int k=0; k<N2; k++) {
    completers[k].complete(k);
  }

  // future f is not completed
  new Future.delayed(0, (){
    Expect.isFalse(visited);
    
    // complete second half of the futures
    for (int k=N2; k<N; k++) {
      completers[k].complete(k);
    }

    // future f is now completed
    new Future.delayed(0, (){
      Expect.isTrue(visited);
  });
  });

}
