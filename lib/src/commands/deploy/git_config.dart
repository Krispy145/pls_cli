/// Model holding the the user git config
class GitConfig {
  /// Git config user.email
  final String email;

  /// Git config user.name
  final String name;

  /// Model holding the the user git config
  GitConfig({required this.email, required this.name});

  /// Create a copy of [GitConfig]
  GitConfig copyWith({String? email, String? name}) => GitConfig(
        email: email ?? this.email,
        name: name ?? this.name,
      );

  @override
  String toString() {
    return "email: $email, name: $name";
  }
}
