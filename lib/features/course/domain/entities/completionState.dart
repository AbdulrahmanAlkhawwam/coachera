
enum CompletionState { COMPLETE, COMPLETE_FAIL, COMPLETE_PASS, INCOMPLETE }

final completionStateValues = EnumValues({
  "COMPLETE": CompletionState.COMPLETE,
  "COMPLETE_FAIL": CompletionState.COMPLETE_FAIL,
  "COMPLETE_PASS": CompletionState.COMPLETE_PASS,
  "INCOMPLETE": CompletionState.INCOMPLETE
});

enum TriggerType { AUTOMATIC, GRADE, MANUAL, VIEWING }

final triggerTypeValues = EnumValues({
  "AUTOMATIC": TriggerType.AUTOMATIC,
  "GRADE": TriggerType.GRADE,
  "MANUAL": TriggerType.MANUAL,
  "VIEWING": TriggerType.VIEWING
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
