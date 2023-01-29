class TaskBean extends Object{
  int? id;
  String? description;
  String? dueDate;
  String? completed = "false";

  @override
  String toString() {
    return 'TaskBean{id: $id, description: $description, dueDate: $dueDate, completed: $completed}';
  }
}