/*
 * Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion abstract void add(message)
 * Sends an asynchronous message to the linked IsolateStream.
 * The message is copied to the receiving isolate.
 * The content of message can be: primitive values (null, num, bool, double, String),
 * instances of IsolateSinks, and lists and maps whose elements are any of these.
 * @description Checks that various primitive values, as well as an IsolateSink,
 * could be sent properly through an IsolateSink.
 * @author kaigorodov
 */

import "dart:isolate";
import "../../../Utils/async_utils.dart";
import "../../../Utils/expect.dart";
import "add_A01_util.dart";

IsolateSink replyTo=null;
int i = 0;

void readMsg(message) {
  if (replyTo==null) {
    Expect.isTrue(message is IsolateSink);
    replyTo=message;
  } else {
    Expect.equals(messagesList[i], message);
    replyTo.add(message);
    if(++i == messagesList.length) {
      replyTo.close();
    }
  }
}

void main2() {
  stream.listen(readMsg);
}

void main() {
  IsolateSink sink = streamSpawnFunction(main2);
  MessageBox mbox=new MessageBox();
  sink.add(mbox.sink);
  
  int i = 0;
  mbox.stream.listen((message) {
    Expect.equals(messagesList[i], message);
    if(++i == messagesList.length) {
      mbox.sink.close();
    }
    asyncEnd();
  });

  for(var v in messagesList) {
    asyncStart();
    sink.add(v);
  }
}

