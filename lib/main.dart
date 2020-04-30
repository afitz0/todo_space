import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO Space',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _itemCount = 100;

  var _finishedCount = 0;

  List<Widget> _items;

  @override
  void initState() {
    _items = List.generate(
        _itemCount,
        (i) => TodoItem(
              onChecked: (checked) {
                if (checked != null)
                  setState(() {
                    checked ? _finishedCount++ : _finishedCount--;
                  });
              },
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Space Planner"),
      ),
      body: Column(
        children: <Widget>[
          Text(
              "Progress: ${(_finishedCount / _itemCount) * 100}% towards Launch!",
              style: TextStyle(fontSize: 42)),
          Expanded(
            child: ListView.builder(
              itemCount: _itemCount,
              itemBuilder: (BuildContext context, int index) {
                return _items[index];
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          _items.add(TodoItem(
            title: Text("New Item"),
            onChecked: () => null,
          ));
          _itemCount = _items.length;
        }),
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Function onChecked;
  final Text title;

  const TodoItem({
    Key key,
    @required this.onChecked,
    this.title,
  }) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Checkbox(
          onChanged: (newValue) => setState(() {
            widget.onChecked(newValue);
            _checked = newValue;
          }),
          tristate: true,
          value: _checked,
        ),
        title: widget.title);
  }
}
