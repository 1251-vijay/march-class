class DataBaseModel {
  final String username;
  final String age;
  final String location;
  final String number;
  final dynamic id;
  const DataBaseModel({
    required this.username,
    required this.number,
    required this.location,
    required this.age,
    required this.id,
  });
  Map<String, dynamic> tojson() => {
        "username": username,
        "age": age,
        "location": location,
        "number": number,
        "id": id,
      };
}
