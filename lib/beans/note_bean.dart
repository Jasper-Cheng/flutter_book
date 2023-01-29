class NoteBean extends Object{
  int? id;
  String? title;
  String? content;
  String? color;

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, color: $color}';
  }
}