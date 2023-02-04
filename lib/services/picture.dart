import 'package:flutter/cupertino.dart';

import 'database.dart';
import 'models/picture.dart';
import 'models/search.dart';

Future<List<PictureModel>> queryFolders(String a) async {
  var sqlText = '''select pk, header, body, 
    simple_highlight(searches, 3, '[', ']') as highlight 
    from searches where body match jieba_query('国');''';

  var list = DBHelper.globalDatabase.select(sqlText);

  debugPrint("list ${list.length}");

  var searchList = List.generate(list.length, (i) {
    return SearchModel.fromJson(list[i]);
  });

  return List.empty();
}
