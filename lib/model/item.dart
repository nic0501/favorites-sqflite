// This is my model class of the items which get stored as favorites

class TestItems {
  String name;
  int id;

  TestItems({required this.name, required this.id});

  factory TestItems.fromJson(Map<String, dynamic> json) {
    return TestItems(
      name: json['name'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
