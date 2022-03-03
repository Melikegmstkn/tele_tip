import 'dart:convert';

List<Profession> doctorFromJson(String str) =>
    List<Profession>.from(json.decode(str).map((x) => Profession.fromJson(x)));

String doctorToJson(List<Profession> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profession {
  Profession({
    this.id,
    this.name,
    this.departmentName,
  });

  int? id;
  String? name;
  String? departmentName;

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        id: json["id"],
        name: json["name"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department_name": departmentName,
      };
}
