import 'dart:convert';

List<ProfessionSearch> professionSearchFromJson(String str) =>
    List<ProfessionSearch>.from(
        json.decode(str).map((x) => ProfessionSearch.fromJson(x)));
String professionSearchToJson(List<ProfessionSearch> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfessionSearch {
  ProfessionSearch({
    this.name,
    this.email,
    this.professionName,
    this.gender,
  });

  String? name;
  String? email;
  String? professionName;
  GenderProfession? gender;

  factory ProfessionSearch.fromJson(Map<String, dynamic> json) =>
      ProfessionSearch(
        name: json["name"],
        gender: genderValues.map![json["gender"]],
        email: json["email"],
        professionName: json["professionName"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "gender": genderValues.reverse[gender],
        "email": email,
        "professionName": professionName,
      };
}

enum GenderProfession { MAN, WOMAN }

final genderValues =
    EnumValues({"man": GenderProfession.MAN, "woman": GenderProfession.WOMAN});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
