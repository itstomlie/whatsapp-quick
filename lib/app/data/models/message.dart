class Message {
  final int id;
  final String number;
  final String? body;
  final DateTime createdAt;

  Message(this.id, this.number, this.body, this.createdAt);

  Message.create(this.number, this.body, this.createdAt) : id = 0;

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      map['id'] as int,
      map['number'] as String,
      map['body'] as String?,
      DateTime.parse(map['created_at'] as String),
    );
  }
}
