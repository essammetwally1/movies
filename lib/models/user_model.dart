class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final int avaterId;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avaterId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      avaterId: json['avaterId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
