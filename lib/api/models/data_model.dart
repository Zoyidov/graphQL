class DataModel {
  DataModel({
    required this.name,
    required this.id,
    required this.image,
    required this.status,
    required this.type,
    required this.roles,
    required this.yearBuilt,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        name: json['name'] as String? ?? '',
        id: json['id'] as String? ?? "",
        image: json['image'] as String? ?? '',
        status: json['status'] as String? ?? '',
        type: json['type'] as String? ?? '',
        roles: json['roles'] as List? ?? [],
        yearBuilt: json['year_built'] as int? ?? 0,
      );

  final String id;
  final String name;
  final String image;
  final String status;
  final String type;
  final List<dynamic> roles;
  final int yearBuilt;
}
