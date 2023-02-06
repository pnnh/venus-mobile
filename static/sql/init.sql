--创建文件夹表
create table if not exists main.folders
(
    pk    TEXT primary key,
    path     TEXT    not null,
    count    integer not null,
    bookmark text
);

--创建图片表
create table if not exists main.pictures
(
    pk   TEXT primary key,
    path TEXT
);

create unique index if not exists pictures_path_index
    on pictures (path);

--创建索引表
create virtual table if not exists main.searches
using fts5(
    pk unindexed,
    header unindexed,
    body, tokenize = 'simple'
);