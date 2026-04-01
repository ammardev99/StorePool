class xxxModel {
  final String id;
  final String name;
  final String description;

  xxxModel({required this.id, required this.name, required this.description});

  factory xxxModel.fromJson(Map<String, dynamic> json) {
    return xxxModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }
}
