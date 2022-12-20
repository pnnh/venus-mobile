import 'package:dream/application/web/pages/partial/not_found.dart';
import 'package:dream/application/web/pages/partial/page_loading.dart';
import 'package:dream/config.dart';
import 'package:dream/services/articles.dart';
import 'package:dream/services/models/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:validators/validators.dart';
import '../partial/header.dart';

class TocItem {
  String title = "";
  int header = 0;
}

class ArticleReadPage extends StatefulWidget {
  final Map<String, String> queryParameters;
  const ArticleReadPage(this.queryParameters, {Key? key}) : super(key: key);

  @override
  State<ArticleReadPage> createState() => _ArticleReadPageState();
}

class _ArticleReadPageState extends State<ArticleReadPage> {
  @override
  Widget build(BuildContext context) {
    if (!widget.queryParameters.containsKey("pk")) {
      return const NotFoundWidget();
    }
    var pk = widget.queryParameters["pk"] as String;
    if (pk.isEmpty) {
      return const NotFoundWidget();
    }

    return FutureBuilder<ArticleFindResult?>(
        future: findArticle(pk),
        builder:
            (BuildContext context, AsyncSnapshot<ArticleFindResult?> snapshot) {
          if (snapshot.hasError) {
            return Text("加载出错1 ${snapshot.error}");
          }

          if (!snapshot.hasData) {
            return PageLoadingWidget();
          }
          //debugPrint("result ${result.data}");
          var model = snapshot.data?.data;
          if (model == null) {
            return Center(
              child: Text("文章不存在"),
            );
          }
          var tocList = <TocItem>[];
          var tocItem = TocItem()
            ..header = 0
            ..title = model.title;
          tocList.add(tocItem);
          Widget articleBody;

          if (model.markLang == 1) {
            articleBody = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: MarkdownGenerator(data: model.markText).widgets ?? [],
            );
          } else {
            articleBody =
                Container(child: buildBody(context, tocList, model.bodyJson()));
          }

          return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                child: Container(
                  //color: const Color(0xfff6f6f6),
                  child: Column(
                    children: [
                      const HeaderWidget(),
                      const SizedBox(height: 16),
                      Container(
                        width: 1200,
                        height: 240,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4)),
                        child: Image.network(
                          AppHelper.filesUrl(model.cover),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                          width: 1200,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 160,
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    model.title,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Container(
                                                    height: 40,
                                                    child: Text(
                                                      model.description,
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                  buildKeywordsList(
                                                      model.keywordsList)
                                                ]),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              margin: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                child: articleBody,
                                              )),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 32,
                                    )
                                  ],
                                ),
                              )),
                              SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 320,
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Column(children: [
                                      Container(
                                        width: 320,
                                        height: 36,
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xffd8d8d8),
                                                width: 1),
                                          ),
                                        ),
                                        child: Text(
                                          "目录",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.only(top: 16),
                                              height: 256,
                                              child: buildTocList(tocList),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                                  )
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ));
        });
  }

  Widget buildBody(BuildContext context, List<TocItem> tocList,
      Map<String, dynamic> bodyJson) {
    if (bodyJson["children"] is! List<dynamic>) {
      return const Center(
        child: Text("无效正文"),
      );
    }
    var children = bodyJson["children"] as List<dynamic>;
    var list = <Widget>[];
    children.forEach((element) {
      list.add(buildNode(context, tocList, element));
    });
    var widget = Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(list.length, (index) => list[index])),
    );
    return widget;
  }

  Widget buildNode(BuildContext context, List<TocItem> tocList,
      Map<String, dynamic> nodeJson) {
    var name = nodeJson["name"] as String;
    switch (name) {
      case "paragraph":
        return buildParagraph(context, nodeJson);
      case "header":
        return buildHeader(context, tocList, nodeJson);
      case "code-block":
        return buildCodeBlock(context, nodeJson);
    }
    return Text("未知节点");
  }

  Widget buildParagraph(BuildContext context, Map<String, dynamic> nodeJson) {
    var children = nodeJson["children"] as List<dynamic>;
    var list = <Widget>[];
    var text = "";
    children.forEach((element) {
      text += buildText(context, element);
    });

    var widget = Container(
      margin: EdgeInsets.only(bottom: 8, top: 8),
      child: Text(text),
    );
    return widget;
  }

  String buildText(BuildContext context, Map<String, dynamic> nodeJson) {
    var text = nodeJson["text"] as String;
    return text;
  }

  Widget buildHeader(BuildContext context, List<TocItem> tocList,
      Map<String, dynamic> nodeJson) {
    if (nodeJson["header"] is! int) {
      return Container(
        child: Text("无效标题"),
      );
    }
    var header = nodeJson["header"] as int;

    var children = nodeJson["children"] as List<dynamic>;
    var list = <Widget>[];
    var text = "";
    children.forEach((element) {
      text += buildText(context, element);
    });

    var tocItem = TocItem()
      ..header = header
      ..title = text;
    tocList.add(tocItem);
    var widget = Container(
      margin: EdgeInsets.only(bottom: 8, top: 8),
      child: Text(text, style: TextStyle(fontSize: header * 8)),
    );
    return widget;
  }

  Widget buildCodeBlock(BuildContext context, Map<String, dynamic> nodeJson) {
    var children = nodeJson["children"] as List<dynamic>;
    var language = nodeJson["language"] as String;
    var list = <Widget>[];
    var text = "";
    children.forEach((element) {
      text += buildText(context, element);
    });

    var widget = Container(
      margin: EdgeInsets.only(bottom: 8, top: 8),
      child: HighlightView(
        // The original code to be highlighted
        text,

        // Specify language
        // It is recommended to give it a value for performance
        language: 'dart',

        // Specify highlight theme
        // All available themes are listed in `themes` folder
        theme: githubTheme,

        // Specify padding
        padding: EdgeInsets.all(12),

        // Specify text style
        textStyle: TextStyle(
          fontSize: 16,
        ),
      ),
    );
    return Row(
      children: [Expanded(child: widget)],
    );
  }

  Widget buildKeywordsList(List<String> keywordsList) {
    return Container(
      padding: EdgeInsets.only(
        top: 16,
      ),
      child: Row(
          children: List.generate(keywordsList.length, (index) {
        var keywordText = keywordsList[index];
        if (keywordText.isEmpty) {
          return Container();
        }
        return Container(
          padding: EdgeInsets.all(4),
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              color: Color(0xffefefef), borderRadius: BorderRadius.circular(4)),
          child: Text(
            keywordsList[index],
            style: TextStyle(fontSize: 12),
          ),
        );
      })),
    );
  }

  Widget buildTocList(List<TocItem> tocList) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(tocList.length, (index) {
          var item = tocList[index];
          return Container(
            padding: EdgeInsets.only(left: item.header * 8, bottom: 8),
            child: Text(tocList[index].title),
          );
        }));
  }
}
