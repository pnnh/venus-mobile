--创建文件夹表
create table main.folders
(
    pk    TEXT primary key,
    title TEXT,
    path  TEXT,
    count integer,
    icon  text,
    bookmark text
);

create virtual table main.searches
using fts5(
    pk unindexed,
    type unindexed,
    header,
    body, tokenize = 'simple'
);