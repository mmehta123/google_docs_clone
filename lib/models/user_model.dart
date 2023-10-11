import 'dart:convert';

class User {
  final String name;
  final String email;
  final String profilePic;
  final String uid;
  final String token;

  User(
      {required this.name,
      required this.email,
      required this.profilePic,
      required this.uid,
      required this.token});

// toMap Method: The toMap method is used to convert the User object into a Map<String, dynamic>.
// This is typically used when you want to store the user object in a database or send it over the network.
// The resulting map can be easily serialized into a JSON string.
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "profilePic": profilePic,
      "uid": uid,
      "token": token,
    };
  }

  String toJson() => json.encode(toMap());

  //fromMap Factory Constructor: The User.fromMap is a factory constructor that takes a Map<String, dynamic>
  // as its argument and returns a new User object. This is the reverse of the toMap method and is used to recreate a User object from a map.
  // This is especially useful when retrieving user data from a database or from a network response.
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map["name"] ?? '',
      email: map["email"] ?? '',
      profilePic: map["profilePic"] ?? '',
      uid: map["_id"] ?? '',
      token: map["token"] ?? '',
    );
  }
  factory User.fromJson(String source) => User.fromMap(json.decode(source));

//sometime we need to change profilepic name etc. fields but they are declared final
//so can't be changed that why we need to create copy of User type object and set new
//variable in our copy object if not found any variable in args than it will be same as Main USER class's
  User copyWith({
    String? email,
    String? name,
    String? profilePic,
    String? uid,
    String? token,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      token: token ?? this.token,
    );
  }
}
