import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WPQuickActionWidget extends ConsumerWidget {
  const WPQuickActionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 20,
      color: Color(0xf0ffffff),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  "static/images/icons/shoucang.svg",
                  color: Color(0xffBABABA),
                  height: 12,
                  width: 12,
                  //    fit: BoxFit.fitWidth
                ),
              )),
          Container(
              padding: EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  "static/images/icons/hao.svg",
                  color: Color(0xffBABABA),
                  height: 12,
                  width: 12,
                  //    fit: BoxFit.fitWidth
                ),
              )),
          Container(
              padding: EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  "static/images/icons/cha.svg",
                  color: Color(0xffBABABA),
                  height: 12,
                  width: 12,
                  //    fit: BoxFit.fitWidth
                ),
              )),
          Container(
              padding: EdgeInsets.only(left: 0, right: 8, top: 0, bottom: 0),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(
                  "static/images/icons/lajitong.svg",
                  color: Color(0xffBABABA),
                  height: 12,
                  width: 12,
                  //    fit: BoxFit.fitWidth
                ),
              ))
        ],
      ),
    );
  }
}
