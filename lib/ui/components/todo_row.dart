import 'package:flutter/material.dart';

Widget TodoRowView(int index, Color color, Color colorDepp, double width) {
  var icon = Icons.work;
  
  switch(index){
    case 1:
      icon = Icons.local_play;
      break;
    case 2:
      icon = Icons.local_library;
      break;
    case 3:
      icon = Icons.local_library;
      break;
  }

  final leftSide = Container(
    height: 100,
    width: 80,
    //padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8.0),
        bottomLeft: Radius.circular(8.0),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: colorDepp,
          child: Icon(icon, color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Today',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '5월 29일',
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        )
      ],
    ),
  );

  final centerSide = Expanded(
    flex: 1,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(index == 0 ? "오늘은 집에서 놀고먹고.. 자고 눕고 하하하하 aslkdlaksdlk laskd sdfl fgkf dfklss" : "타티르",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 5),
              Text(
                '집 -> 한강까지 왕복',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(Icons.local_offer, color: color, size: 16),
              SizedBox(width: 5,),
              Text(
                '공부, 일, 여가, 모임, 재미, 휴식',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  var checked = false;

  final rightSide = Center(
    child: Checkbox(
      value: checked,
    ),
  );

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Container(
      //transform: Matrix4.rotationZ(0.1),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.start,
        //verticalDirection: VerticalDirection.up,
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          leftSide,
          centerSide,
          //rightSide
        ],
      ),
    ),
  );
}
