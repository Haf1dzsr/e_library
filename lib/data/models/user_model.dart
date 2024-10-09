class UserModel {
  int? id;
  String name;
  String email;
  int? age;
  String? profession;
  String? cityAddress;
  String? photo;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.age,
    this.profession,
    this.cityAddress,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'profession': profession,
      'city_address': cityAddress,
      'photo': photo,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      profession: map['profession'],
      cityAddress: map['city_address'],
      photo: map['photo'],
    );
  }
}
