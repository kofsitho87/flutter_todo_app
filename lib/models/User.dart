import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class User extends Equatable {
  String uid;
  String name;

  User(this.uid, this.name);

  static User fromJson(Map<String, Object> json) {
    return User(
      json["uid"] as String,
      json["name"] as String,
    );
  }

  Map<String, Object> toJson() {
    return {
      "uid": this.uid,
      "name": this.name
    };
  }

  @override
  String toString() {
    return 'User { uid: $uid, name: $name }';
  }
}