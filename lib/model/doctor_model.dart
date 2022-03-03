import 'dart:convert';

List<Doctor> doctorFromJson(String str) =>
    List<Doctor>.from(json.decode(str).map((x) => Doctor.fromJson(x)));

String doctorToJson(List<Doctor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doctor {
  Doctor({
    this.id,
    this.email,
    this.name,
    this.gender,
    this.password,
    this.professionName,
    this.departmentName,
  });

  int? id;
  String? email;
  String? name;
  Gender? gender;
  String? password;
  String? professionName;
  String? departmentName;

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["id"],
        email: json["email"],
        name: json["name"],
        gender: genderValues.map![json["gender"]],
        password: json["password"],
        professionName: json["professionName"],
        departmentName: json["department_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "gender": genderValues.reverse[gender],
        "password": password,
        "professionName": professionName,
        "department_name": departmentName,
      };
}

enum Gender { MAN, WOMAN }

final genderValues = EnumValues({"man": Gender.MAN, "woman": Gender.WOMAN});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
