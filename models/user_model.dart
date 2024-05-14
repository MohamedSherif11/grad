class UserModel {
  String? name;
  String? email;
  String? phone;
  String? image;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  UserModel.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    email = data['email'];
    phone = data['phone'];
    image = data['image'];

  }
}