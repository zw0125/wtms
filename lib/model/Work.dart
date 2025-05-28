class Work {
  final int id;
  final String title;
  final String description;
  final int assignedTo;
  final DateTime dateAssigned;
  final DateTime dueDate;
  final String status;

  Work({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.dateAssigned,
    required this.dueDate,
    required this.status,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      description: json['description'],
      assignedTo: int.parse(json['assigned_to'].toString()),
      dateAssigned: DateTime.parse(json['date_assigned']),
      dueDate: DateTime.parse(json['due_date']),
      status: json['status'],
    );
  }
}
