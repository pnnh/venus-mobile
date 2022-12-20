// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:ffi';
import 'dart:io' show Directory, Platform;

//import 'package:pillow/gen/generated_bindings.dart';
import 'package:ffi/ffi.dart';

void runMarkdown() {
  // final DynamicLibrary nativeLib = Platform.isMacOS
  //     ? DynamicLibrary.process()
  //     : DynamicLibrary.open('libcouch_shared.so');
  //
  // var couchLibrary = CouchLibrary(nativeLib);
  // const input = '"## hello world"';
  // final inputUtf8 = input.toNativeUtf8();
  // var outputInt8 = couchLibrary.markdownToJson(inputUtf8.cast<Int8>());
  // final output = outputInt8.cast<Utf8>().toDartString();
  // print("===========\n $output\n");
  // couchLibrary.releaseString(outputInt8);
  // calloc.free(inputUtf8);
}
