import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillow/pillow.dart';

import 'partial/header.dart';

class RandomPage extends StatefulWidget {
  const RandomPage({Key? key}) : super(key: key);

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  bool hasLetter = true;
  bool hasUppercaseLetter = true;
  bool hasNumber = true;
  bool hasSymbol = false;
  int length = 16;
  String password = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const HeaderWidget(),
            const SizedBox(height: 16),
            Container(
                width: 1024,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [
                          Text(
                            "随机密码生成器",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "随机密码生成器",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'WenQuanYi Micro Hei Light'),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: const [Text("本页生成的密码不会保持，刷新或关闭页面后消失")],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasLetter,
                            onChanged: (bool? value) {
                              setState(() {
                                hasLetter = value!;
                              });
                            },
                          ),
                          const Text(
                            "小写字母",
                            style: TextStyle(fontSize: 14, height: 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasUppercaseLetter,
                            onChanged: (bool? value) {
                              setState(() {
                                hasUppercaseLetter = value!;
                              });
                            },
                          ),
                          const Text(
                            "大写字母",
                            style: TextStyle(fontSize: 14, height: 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasNumber,
                            onChanged: (bool? value) {
                              setState(() {
                                hasNumber = value!;
                              });
                            },
                          ),
                          const Text(
                            "数字",
                            style: TextStyle(fontSize: 14, height: 1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            hoverColor: Colors.transparent,
                            splashRadius: 0,
                            value: hasSymbol,
                            onChanged: (bool? value) {
                              setState(() {
                                hasSymbol = value!;
                              });
                            },
                          ),
                          const Text(
                            "特殊符号",
                            style: TextStyle(fontSize: 14, height: 1),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: 48,
                          height: 32,
                          child: TextField(
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.teal))),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LimitRangeTextInputFormatter(4, 64),
                            ],
                            controller:
                                TextEditingController(text: length.toString()),
                            onChanged: (text) {
                              setState(() {
                                length = int.parse(text);
                              });
                            },
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 32)),
                        onPressed: () async {
                          //var result = await promiseToFuture(sayHello());
                          var result = await Pillow.randomString(
                              length: length,
                              hasNumber: hasNumber,
                              hasLetter: hasLetter,
                              hasUppercaseLetter: hasUppercaseLetter,
                              hasSymbol: hasSymbol);
                          // var result = await promiseToFuture(
                          //     randomString(length, false, false, false, false));
                          debugPrint("--> $result");
                          setState(() {
                            password = result;
                          });
                        },
                        child: const Text(
                          "生成密码",
                          style: TextStyle(
                              fontSize: 14,
                              height: 1,
                              fontFamily: 'WenQuanYi Micro Hei Light'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        password,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }
}

class LimitRangeTextInputFormatter extends TextInputFormatter {
  LimitRangeTextInputFormatter(this.min, this.max) : assert(min < max);

  final int min;
  final int max;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = int.parse(newValue.text);
    if (value < min) {
      return TextEditingValue(text: min.toString());
    } else if (value > max) {
      return TextEditingValue(text: max.toString());
    }
    return newValue;
  }
}
