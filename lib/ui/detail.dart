import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/todos_repository.dart';
import '../bloc/todo_bloc/bloc.dart';
import '../models/Todo.dart';

class DetailApp extends StatefulWidget {
  final String title;
  DetailApp({@required this.title});

  @override
  State<StatefulWidget> createState() => _DetailApp(title: title);
}

class _DetailApp extends State<DetailApp> {
  final String title;
  _DetailApp({@required this.title});

  TodosBloc todosBloc;

  //String _todoTitle;
  DateTime _completeDate;
  String _category;
  final categories = ['일', '개인', '공부', '여가'];

  final todoTitleController = TextEditingController();

  @override
  void initState() {
    
    todosBloc = BlocProvider.of<TodosBloc>(context);

    super.initState();
  }

  void addTodo(String title, String category, DateTime completeDate) async {
    final todo = Todo(title, category, completeDate: completeDate);
    final result = await todosBloc.dispatch(AddTodo(todo));
    //print(result);
    setState(() {
      todoTitleController.text = '';
      _category = null;
      _completeDate = null;
    });
  }

  void _showTimePicker(){
    DatePicker.showDatePicker(context, 
      showTitleActions: true,
      currentTime: DateTime.now(),
      theme: DatePickerTheme(
        //backgroundColor: Theme.of(context).primaryColor
      ),
      locale: LocaleType.ko,
      minTime: DateTime.now(),
      onConfirm: (date) {
        print('confirm $date');
        setState(() {
          _completeDate = date;
        });
      },
      // onChanged: (date) {
      //   print('confirm $date');
      // }
    );
  }

  void _saveTodoAction(){
    if( todoTitleController.text.length < 3 ){
      //final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
      //Scaffold.of(context).showSnackBar(snackBar);
      return;
    }else if ( _category == null ){
      return;
    }
    this.addTodo(todoTitleController.text, _category, _completeDate);
  }

  Widget get _todoTitleRow {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(45, 58, 66, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: todoTitleController,
        decoration: InputDecoration(
          icon: Icon(Icons.work, color: Colors.white),
          labelText: '할일',
          labelStyle: TextStyle(color: Colors.white),
          //hintText: '청소하기',
          border: InputBorder.none,
        ),
        validator: (String arg) {
          if (arg.length < 1)
            return '1글자 이상 입력해주세요!';
          else
            return null;
        },
        // onSaved: (String value) {
        //   print(value);
        //   _todoTitle = value;
        // },
        // onFieldSubmitted: (String value) {
        //   _todoTitle = value;
        //   print('onFieldSubmitted $value');
        // },
      ),
    );
  }

  Widget get _completeDateRow {
    final _completeDateStr = _completeDate != null ? DateFormat('yyyy-MM-dd').format(_completeDate) : '';
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(45, 58, 66, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            top: 10,
            child: Icon(Icons.calendar_today, color: Colors.white),
          ),
          Positioned(
            left: 42,
            top: 16,
            child: Text('완료설정', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          Positioned(
            right: 20,
            top: 16,
            child: Text(_completeDateStr, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          MaterialButton(
            //textTheme: ButtonTextTheme.primary,
            textColor: Colors.white,
            minWidth: double.infinity,
            onPressed: _showTimePicker,
            //child: Text('완료일 설정', style: TextStyle()),
          )
        ],
      ),
    );
  }

  Widget get _categoryRow {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(45, 58, 66, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.category, color: Colors.white),
          SizedBox(width: 20),
          Expanded(
            child: DropdownButtonFormField(
              value: _category,
              hint: Text('카테고리를 선택해주세요', style: TextStyle(color: Colors.white)),
              decoration: const InputDecoration(
                // filled: true,
                // fillColor: Colors.black,
                // hintStyle: TextStyle(color: Colors.white),
                // labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none)
              ),
              items: categories.map((String value) {
                return DropdownMenuItem(value: value, child: Text(value, style: TextStyle(color: Colors.grey)));
              }).toList(),
              onChanged: (value) {
                print(value);
                setState(() {
                    _category = value;
                });
              }
            ),
          )
        ],
      ),
    );
  }

  Widget get _formView {
    return Form(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Column(
              children: <Widget>[
                _todoTitleRow,
                _completeDateRow,
                _categoryRow,
              ],
            ),
            MaterialButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              minWidth: double.infinity,
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              child: Text('생성'),
              onPressed: _saveTodoAction,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Center(child: Text('aa'));

    return BlocBuilder(
      bloc: todosBloc,
      builder: (BuildContext context, TodosState state) {
        return ModalProgressHUD(
          child: Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            appBar: AppBar(
              elevation: 0,
              bottomOpacity: 0,
              centerTitle: true,
              title: Text(title),
            ),
            body: SingleChildScrollView(
              child: _formView,
            ),
          ),
          inAsyncCall: !(state is TodosLoaded),
        );
      }
    );
  }
}
