import 'package:dream/application/web/route.dart';
import 'package:dream/config.dart';
import 'package:dream/services/models/article.dart';
import 'package:dream/services/models/resource.dart';
import 'package:flutter/material.dart';

class ResourceItemWidget extends StatelessWidget {
  final ResourceModel model;

  const ResourceItemWidget(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routerDelegate = WebRouterDelegate.of(context);
    //var hasDesc = model.description != null && model.description!.isNotEmpty;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Image.network(
                      AppHelper.filesUrl(model.cover ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: TextButton(
                  style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent)),
                  onPressed: () async {
                    routerDelegate.go("/article/read?pk=" + model.pk);
                  },
                  child: Text(model.title,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16))),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(model.description ?? "",
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500))),
          ),
          Expanded(
              flex: 4,
              child: Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(model.updateAt.toIso8601String(),
                          style: TextStyle(
                              fontSize: 13, color: Color(0xFF86909C))),
                    ],
                  )))
        ]);
  }
}
