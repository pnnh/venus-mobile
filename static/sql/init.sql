--创建文件夹表
create table if not exists main.folders
(
    pk    TEXT primary key,
    title TEXT,
    path  TEXT,
    count integer,
    icon  text,
    bookmark text
);

create virtual table if not exists main.searches
using fts5(
    pk unindexed,
    header unindexed,
    body, tokenize = 'simple'
);