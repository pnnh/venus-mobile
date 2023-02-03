import 'package:dream/services/database.dart';
import 'package:dream/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'folder.g.dart';

@JsonSerializable()
class PictureFolder {
  String pk;
  String title;
  int count;
  String icon;
  String path;
  String bookmark = "";

  PictureFolder(this.pk,
      {this.title = "",
      this.count = 0,
      this.icon = "static/images/icons/folder.svg",
      required this.path,
      this.bookmark = ""});

  factory PictureFolder.fromJson(Map<String, dynamic> json) =>
      _$PictureFolderFromJson(json);

  Map<String, dynamic> toJson() => _$PictureFolderToJson(this);
}

void queryFolders() {
  var sqlText = '''select pk, header, body, 
    simple_highlight(searches, 3, '[', ']') as highlight 
    from searches where body match jieba_query('国');''';

  var list = DBHelper.globalDatabase.select(sqlText);

  debugPrint("list ${list.length}");
}

void addFolder(String title, String path, String icon) {
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
    DBHelper.globalDatabase.execute(sqlTextInsertFolder, [pk, title, path, icon]);
    DBHelper.globalDatabase.execute(sqlTextInsertSearches, [pk, 'folder', title]);
    DBHelper.globalDatabase.execute(sqlTextCommit);

  }
  catch(e) {
    debugPrint("insertFolder: $e");
    var sqlTextRollback = "rollback;";
    DBHelper.globalDatabase.execute(sqlTextRollback);
  }
}