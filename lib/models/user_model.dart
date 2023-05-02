class UserModel{
  final int id;
  final String email;
  final String firstname;
  final String lastname;
  final String avatar;

  UserModel({required this.id,required this.email,required this.firstname,required this.lastname,required this.avatar});
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(id: json['id'], email: json['email'], firstname: json['firstname']??'firstname', lastname: json['lastname']??'lastname', avatar: json['avatar']);

  }
}