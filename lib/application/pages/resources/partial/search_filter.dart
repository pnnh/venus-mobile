import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WPSearchFilterWidget extends ConsumerWidget {
  WPSearchFilterWidget({Key? key}) : super(key: key);
  final searchBorder = OutlineInputBorder(
    borderSide: const BorderSide(
        width: 0, color: Colors.white, style: BorderStyle.solid),
    borderRadius: BorderRadius.zero,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 144,
      height: 24,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Color(0xffececec), width: 1, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.all(2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
            child: SvgPicture.asset(
              "static/images/icons/search.svg",
              color: Color(0xffCDCDCD),
              height: 16,
              width: 16,
              //    fit: BoxFit.fitWidth
            ),
          ),
          Expanded(
            child: Container(
              height: 24,
              padding: EdgeInsets.zero,
              child: TextField(
                keyboardType: TextInputType.text,
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hoverColor: Colors.white,
                  hintText: '搜索图片',
                  hintStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.only(left: 8, top: 4),
                  enabledBorder: searchBorder,
                  focusedBorder: searchBorder,
                  focusedErrorBorder: searchBorder,
                  filled: true,
                  fillColor: Colors.white,
                  border: searchBorder,
                ),
                controller: TextEditingController(text: ""),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
