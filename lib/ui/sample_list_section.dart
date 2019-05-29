import 'package:flutter/material.dart';
import '../ui/colors.dart';
import '../ui/components/components.dart';

class SampleListSection extends StatelessWidget {

  Widget get listView {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index){
        
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            //color: Colors.deepOrangeAccent,
            border: Border(bottom: BorderSide(color: Colors.black)),
          ),
          child: ListTile(
            title: Text('title'),
            subtitle: Text('subtitle'),
            //isThreeLine: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        primaryColorDark: Colors.deepPurple
      ),
      home: Scaffold(
        body: listView,
      ),
    );
  }
}