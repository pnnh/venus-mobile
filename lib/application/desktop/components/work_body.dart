import 'package:dream/application/desktop/providers/todo.dart';
import 'package:dream/services/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkBodyWidget extends StatefulWidget {
  final Task task;
  final TextEditingController controller;

  const WorkBodyWidget({Key? key, required this.task, required this.controller})
      : super(key: key);

  @override
  State<WorkBodyWidget> createState() => _WorkBodyWidgetState();
}

class _WorkBodyWidgetState extends State<WorkBodyWidget> {
  final Color selectedColor = const Color.fromRGBO(0, 119, 212, 100);
  final Color defaultColor = const Color.fromRGBO(146, 148, 152, 100);
  final bodyController = TextEditingController();
  double sourceHeight = 240;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    bodyController.text = widget.task.body;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(4),
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hoverColor: Colors.white,
                hintText: "任务标题",
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              controller: widget.controller,
              onChanged: (text) {
                todoProvider.putItem(widget.task.key, text, widget.task.body);
              },
            ),
            const SizedBox(height: 24),
            Expanded(
                child: Container(
              color: Colors.white,
              child: TextField(
                keyboardType: TextInputType.multiline,
                minLines: null,
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(4),
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  hoverColor: Colors.white,
                  hintText: "任务正文",
                ),
                controller: bodyController,
                onChanged: (text) {
                  debugPrint("WorkBodyWidget body update $text");
                  todoProvider.putItem(
                      widget.task.key, widget.task.title, text);
                },
                onTap: () {
                  debugPrint('Editing stated $widget');
                },
              ),
            ))
          ]),
        ],
      ),
    );
  }
}
