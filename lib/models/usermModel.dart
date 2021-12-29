class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  UserModel({this.uid, this.email, this.firstName, this.lastName});
  //data from the server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['first name'],
      lastName: map['last name'],
    );
    // data to the server
  }
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'first name': firstName,
      'last name': lastName,
      'email': email
    };
  }
}
