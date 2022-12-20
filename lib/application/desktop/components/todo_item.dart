import 'package:dream/application/desktop/providers/todo.dart';
import 'package:dream/services/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoItemWidget extends StatefulWidget {
  final Task task;
  final TextEditingController controller;

  const TodoItemWidget({Key? key, required this.task, required this.controller})
      : super(key: key);

  @override
  State<TodoItemWidget> createState() => _TodoItemWidget();
}

class _TodoItemWidget extends State<TodoItemWidget> {
  String content = "啊啊啊啊啊啊";
  final Color hoveredColor = const Color.fromRGBO(248, 249, 255, 100);

  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoProvider>(context);
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(4),
        border: InputBorder.none,
        filled: true,
        fillColor: todoList.currentItem?.task.key == widget.task.key
            ? const Color.fromRGBO(238, 243, 254, 100)
            : Colors.white,
        hoverColor: const Color.fromRGBO(238, 243, 254, 100),
      ),
      controller: widget.controller,
      onTap: () {
        debugPrint("item tap ${widget.task.key}");
        todoList.selectItem(widget.task.key);
      },
      onChanged: (text) {
        // print('First text field: ${widget.task.key} $text');
        // todoList.putItem(widget.task.key, widget.task.title, text);
      },
    );
  }
}
