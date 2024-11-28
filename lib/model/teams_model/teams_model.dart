
class Team {
  final int id;
  final String name;
  final String designation;
  final String image;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Team({
    required this.id,
    required this.name,
    required this.designation,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      designation: json['designation'],
      image: json['image'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'designation': designation,
      'image': image,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
// Model class for the response containing a list of teams
class TeamsResponse {
  final bool status;
  final String message;
  final TeamsData data;

  TeamsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TeamsResponse.fromJson(Map<String, dynamic> json) {
    return TeamsResponse(
      status: json['status'],
      message: json['message'],
      data: TeamsData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class TeamsData {
  final List<Team> teams;

  TeamsData({
    required this.teams,
  });

  factory TeamsData.fromJson(Map<String, dynamic> json) {
    return TeamsData(
      teams: (json['teams'] as List)
          .map((teamJson) => Team.fromJson(teamJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teams': teams.map((team) => team.toJson()).toList(),
    };
  }
}
