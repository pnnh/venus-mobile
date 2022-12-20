@JS()
library pillow_js; //Not avoid the library annotation

import 'dart:html';

import 'package:js/js.dart';

@JS('console.log') // annotates `log` function to call `console.log`
external void log(dynamic str);

@JS()
external sayHello();

@JS()
external String randomString(int length, bool hasNumber, bool hasLetter,
    bool hasUppercase, bool hasSymbol);

@JS()
external Future<String> getFontData(String fontName);

@JS()
external Future<Blob> getFontData2(String fontName);
