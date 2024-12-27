class TeamModel {
  String name;
  int points;

  TeamModel({required this.name, this.points = 0});

  TeamModel copyWith({String? name, int? points}) {
    return TeamModel(
      name: name ?? this.name,
      points: points ?? this.points,
    );
  }
}
