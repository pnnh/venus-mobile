import 'package:dream/application/desktop/components/todo_item.dart';
import 'package:dream/application/desktop/components/work_body.dart';
import 'package:dream/application/desktop/providers/todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_view/split_view.dart';

import 'empty.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListWidget();
}

class _TodoListWidget extends State<TodoListWidget> {
  final Color selectedColor = const Color.fromRGBO(238, 243, 254, 100);
  final Color defaultColor = Colors.white;
  final Color iconColor = const Color.fromRGBO(153, 153, 153, 100);
  final contentController = TextEditingController(text: "啊啊啊啊啊啊");
  FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final todoListModel = Provider.of<TodoProvider>(context);
    var items = todoListModel.items.values.toList();
    debugPrint("TodoListWidget build ${items.length}");
    final currentItem = todoListModel.currentItem;

    return Expanded(
        child: SplitView(
      viewMode: SplitViewMode.Horizontal,
      indicator: const SplitIndicator(viewMode: SplitViewMode.Horizontal),
      gripSize: 2,
      gripColor: const Color(0XFFEEEEEE),
      gripColorActive: const Color(0XFFEEEEEE),
      activeIndicator: const SplitIndicator(
        viewMode: SplitViewMode.Horizontal,
        isActive: true,
      ),
      controller: SplitViewController(
          limits: [WeightLimit(min: 0.2, max: 0.5), WeightLimit(min: 0.1)]),
      onWeightChanged: (w) => debugPrint("Horizontal $w"),
      children: [
        Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(
              color: Color.fromRGBO(229, 229, 229, 100),
              width: 1,
            ))),
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                    height: 40,
                    child: TextField(
                      autofocus: true,
                      focusNode: myFocusNode,
                      minLines: 1,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                          hintText: "回车创建笔记",
                          contentPadding: const EdgeInsets.only(
                              left: 8, right: 8, top: 8, bottom: 8),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              )),
                          filled: true,
                          fillColor: const Color.fromRGBO(242, 242, 242, 100),
                          hoverColor: const Color.fromRGBO(242, 242, 242, 100)),
                      keyboardType: TextInputType.number,
                      controller: contentController,
                      onSubmitted: (text) {
                        debugPrint("Go button is clicked $text");
                        todoListModel.addItem(text, "");
                        contentController.text = "";
                        myFocusNode.requestFocus();
                      },
                      onChanged: (text) {
                        debugPrint("onChanged $text");
                      },
                    )),
                const SizedBox(height: 16),
                Expanded(
                    child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    if (items.length <= index) {
                      throw Exception("找不到item");
                    }
                    var item = items[index];
                    return TodoItemWidget(
                      task: item.task,
                      controller: item.controller,
                    );
                  },
                ))
              ],
            )),
        Container(
            color: Colors.white,
            child: currentItem != null
                ? WorkBodyWidget(
                    task: currentItem.task, controller: currentItem.controller)
                : const EmptyWidget(message: "点击左侧标题查看详情"))
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    myFocusNode.dispose();
  }
}
