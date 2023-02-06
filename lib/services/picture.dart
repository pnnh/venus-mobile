import 'package:flutter/cupertino.dart';
import 'package:venus/utils/utils.dart';

import 'database.dart';
import 'models/picture.dart';
import 'models/search.dart';

Future<List<PictureModel>> queryPictures(String a) async {
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

void insertPicture(String title, String path, String icon) {
  try {
    var sqlTextBegin = "begin;";
    var sqlTextInsertFolder = '''
insert into folders(pk, title, path, count, icon, bookmark)
values(?, ?, ?, 0, ?, '');
''';
    var sqlTextInsertSearches = '''
insert into searches(pk, header, body)
values(?, ?, ?);
''';
    var sqlTextCommit = "commit;";
    var pk = generateRandomString(8);

    DBHelper.globalDatabase.execute(sqlTextBegin);
    DBHelper.globalDatabase
        .execute(sqlTextInsertFolder, [pk, title, path, icon]);
    DBHelper.globalDatabase
        .execute(sqlTextInsertSearches, [pk, 'folder', title]);
    DBHelper.globalDatabase.execute(sqlTextCommit);
  } catch (e) {
    debugPrint("insertFolder: $e");
    var sqlTextRollback = "rollback;";
    DBHelper.globalDatabase.execute(sqlTextRollback);
  }
}