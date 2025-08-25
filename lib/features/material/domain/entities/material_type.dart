enum MaterialType { VIDEO, QUIZ, ARTICLE }

final materialTypeValues = EnumValues({
  "ARTICLE": MaterialType.ARTICLE,
  "QUIZ": MaterialType.QUIZ,
  "VIDEO": MaterialType.VIDEO,
});

class EnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverseMap;

  EnumValues(this.map) {
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse => reverseMap;
}
