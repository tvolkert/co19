#! script tag
/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A script is a library with a top level function main().
 * scriptDefinition:
 *   scriptTag? libraryName? libraryImport* partDirective* topLevelDefinition*
 * ;
 * @description Checks that it is a compile-time error when a script (with a script tag)
 * includes an export directive.
 * @compile-error
 * @author rodionov
 * @issue 6293
 */
library Scripts_A01_t21;
export "4_Library1.dart";

main() {
}
