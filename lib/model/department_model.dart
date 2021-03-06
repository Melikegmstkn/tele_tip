import 'dart:convert';

List<Department> departmentFromJson(String str) =>
    List<Department>.from(json.decode(str).map((x) => Department.fromJson(x)));

String departmentToJson(List<Department> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Department {
  Department({
    this.id,
    this.departmentName,
  });

  int? id;
  String? departmentName;

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
      };
}
