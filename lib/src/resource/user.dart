part of '../resource.dart';

/// A user on a booru.
final class User extends Resource {
  /// The username of the user.
  final String username;

  /// Whether the user is active.
  final int active;

  /// Whether the user is active.
  bool get isActive => active == 1;

  /// Create a [User].
  const User(this.username, this.active, super.id);

  /// Create a [User] from a map.
  @override
  User.fromMap(super.map)
      : username = map['username'],
        active = map['active'],
        super.fromMap();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.username == username &&
        other.active == active;
  }

  @override
  User copyWith({
    int? id,
    String? username,
    int? active,
  }) {
    return User(
      username ?? this.username,
      active ?? this.active,
      id ?? this.id,
    );
  }

  @override
  int get hashCode => super.hashCode ^ username.hashCode ^ active.hashCode;

  @override
  String toString() {
    return 'User(username: $username, active: $active)';
  }
}
