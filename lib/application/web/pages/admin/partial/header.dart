import 'dart:math';

import 'package:dream/application/web/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminHeaderWidget extends StatelessWidget {
  const AdminHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routerDelegate = WebRouterDelegate.of(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Color(0xffececec),
            width: 1,
          ))),
      child: Center(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ConstrainedBox(
            constraints:
                BoxConstraints.tightFor(width: min(1600, constraints.maxWidth)),
            child: Container(
                height: 48,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: const [
                                    Image(
                                      height: 32,
                                      width: 32,
                                      image:
                                          AssetImage("static/images/brand.png"),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "泛涵",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )),
                            SizedBox(
                              width: 16,
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Color(0xffdedede),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              "static/images/icons/grid.svg",
                              color: Color(0xff4f4f4f),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              onPressed: () async {
                                routerDelegate.go("/");
                              },
                              child: const Text(
                                "控制台",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16),
                              ),
                            ),
                          ]),
                    ),
                  ],
                )), // your column
          );
        }),
      ),
    );
  }
}
