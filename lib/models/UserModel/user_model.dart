class UserModel {
  dynamic email;
  dynamic password;
  dynamic firstname;
  dynamic lastname;
  dynamic phone;
  dynamic uId;
  dynamic image;

  UserModel({
    this.email,
    this.password,
    this.firstname,
    this.lastname,
    this.phone,
    this.uId,
    this.image,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
      'uId': uId,
      'image': image,
    };
  }
}
