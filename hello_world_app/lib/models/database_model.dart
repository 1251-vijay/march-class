class EmployeeData {
  final String name;
  final String age;
  final String location;
  final dynamic id;

  const EmployeeData(
      {required this.name,
      required this.age,
      required this.location,
      required this.id});

  Map<String, dynamic> tojson() =>
      {"name": name, "age": age, "location": location, "id": id};
}
