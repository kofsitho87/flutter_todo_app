class Todo {
  String id;
  String title;
  String category;

  DateTime completeDate;
  bool completed;
  String note;

  Todo(this.title, this.category, {this.completed = false, String note, String id = '', DateTime completeDate}) 
    : this.id = id,
      this.note = note ?? '',
      this.completeDate = completeDate ?? null
      ;

  Todo copyWith({String id, String title, String category, bool completed}) {
    return Todo(
      title ?? this.title,
      category ?? this.title,

      id: id ?? this.id,
      completed: completed ?? this.completed,
      note: note ?? this.note,
    );
  }

  toMap(){
    Map<String, dynamic> data = {
      "title"       : this.title,
      "category"    : this.category,
      "completeDate": this.completeDate,
      "completed"   : this.completed,
      "note"        : this.note,
    };
    return data; 
  }
}