class HistoryType {
  final String dateCreated;
  final List<Map<String, double>> yearsToBigGoal;

  HistoryType({required this.dateCreated, required this.yearsToBigGoal});

  toJson() {
    return {
      'dateCreated': dateCreated,
      'yearsToBigGoal': yearsToBigGoal,
    };
  }

  factory HistoryType.fromJson(Map<String, dynamic> json) {
    return HistoryType(
      dateCreated: json['dateCreated'],
      yearsToBigGoal: json['yearsToBigGoal'],
    );
  }
}
