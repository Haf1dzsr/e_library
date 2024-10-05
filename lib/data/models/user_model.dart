class UserModel {
  int? id;
  String name;
  String email;
  String? photo;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photo: map['photo'],
    );
  }
}
