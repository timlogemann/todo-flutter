class Task {
  int _id;
  // final int publicId;
  final String todo;
  final String project;
  final DateTime dueDate;
  final String note;

  Task(this.todo, this.project, this.dueDate, [this.note = '', this._id]) {
    if (this._id == null) {
      this._id = DateTime.now().millisecondsSinceEpoch;
    }
  }

  int get id => _id;

  set id(int id) {
    this._id = id;
  }
}
