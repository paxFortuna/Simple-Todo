import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final _items = <Todo>[];
  final _todoController = TextEditingController();

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('남은 할일'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0,top: 2, right: 5, bottom: 2),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        enabledBorder: _genOutLineInputer(),
                        // TextField height 설정과 borderLine 유지하기
                        contentPadding:
                            const EdgeInsets.fromLTRB(12.0, 0.1, 0.0, 0.1),
                        focusedBorder: _genOutLineInputer(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTodo(Todo(_todoController.text));
                    // 키보드 닫기 이벤트 처리
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: const Text('추가'),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: _items.map((todo) => _buildItemWidget(todo)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder _genOutLineInputer() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 1,
      ),
    );
  }

  Widget _buildItemWidget(Todo todo) {
    return ListTile(
      onTap: () => _toggleTodo(todo),
      title: Text(
        todo.title!,
        style: todo.isDone
            ? const TextStyle(
                decoration: TextDecoration.lineThrough,
                fontStyle: FontStyle.italic,
              )
            : null,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete_forever, size: 30),
        onPressed: () {
          _deleteTodo(todo);}
      ),
    );
  }

  void _addTodo(Todo todo) {
    setState(() {
      _items.add(todo);
      _todoController.text = '';
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _items.remove(todo);
    });
  }

  void _toggleTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }
}
