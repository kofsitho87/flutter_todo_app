import 'package:flutter/material.dart';

Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Oeschinen Lake Campground',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'Kandersteg, Switzerland',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);

class TodoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TodoList();
}

class TodoList extends State<TodoApp> {
  List<String> todos = [];
  String todo;
  bool _autoValidate = false;
  final _formKey = GlobalKey<FormState>();

  void addTodo() {
    print('todo ' + this.todo);
    this.todos.add(this.todo);
    setState(() {
      todos = this.todos;
    });
    Navigator.of(context, rootNavigator: true).pop();
  }

  Widget TodoFormUI() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextFormField(
            decoration: const InputDecoration(labelText: 'Todo'),
            keyboardType: TextInputType.text,
            validator: (String arg) {
              if (arg.length < 3)
                return 'Todo must be more than 2 charater';
              else
                return null;
            },
            onSaved: (String val) {
              todo = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            child: Text("Submitß"),
            onPressed: _validateInputs,
          ),
        )
      ],
    );
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      addTodo();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("할일을 입력해주세요"),
            content: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: TodoFormUI()),
          );
        });
  }

  void _settingModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
                onTap: () => {
                  Navigator.pushReplacementNamed(context, '/detail')
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Video'),
                onTap: () => {
                  
                },
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildTodoList() {
    return new ListView.builder(
        //padding: const EdgeInsets.all(20),
        itemCount: this.todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Delete',
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            key: Key(this.todos[index]),
            //confirmDismiss: true,
            onDismissed: (DismissDirection direction) {
              //if(direction == DismissDirection.endToStart) return false;

              print(direction);
              setState(() {
                todos.removeAt(index);
              });

              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$todo dismissed")));
            },
            child: Column(
              children: <Widget>[_buildRow(this.todos[index]), Divider()],
            ),
          );
        });
  }

  Widget _buildRow(todo) {
    return ListTile(
      leading: Icon(Icons.work, size: 40.0, color: Colors.red),
      title: Text(todo),
      subtitle: Text('subtitle'),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        _settingModalBottomSheet();
      },
      //enabled: false,
      //selected: true,
      //dense: true, //small text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new TextFormField(
            decoration: new InputDecoration(labelText: "Todo"),
            validator: (val) => todo = val,
            //onSaved: (val) => _email = val,
          ),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.add),
              onPressed: _showDialog,
            )
          ],
        ),
        body: _buildTodoList());
  }
}
