import 'package:flutter/material.dart';

//import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:bloc/bloc.dart';
// import './bloc/blocs.dart';
// import './bloc/auth_bloc/bloc.dart';
// import './resources/repository.dart';
// import './resources/file_stroage.dart';

// import 'ui/login.dart';
// import 'ui/main.dart';


import './ui/sample_todo.dart';
import './ui/sample_list_section.dart';

void main() {
  //BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(SampleListSection());
}

