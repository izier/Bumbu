class UserProfile {
  final String id;
  final String email;
  final String username;
  final String displayName;

  const UserProfile({
    required this.id,
    required this.email,
    required this.username,
    required this.displayName,
  });

  factory UserProfile.fromMap(String id, Map<String, dynamic> map) {
    final email = map['email']?.toString() ?? '';
    final username = map['username']?.toString() ?? '';
    return UserProfile(
      id: id,
      email: email,
      username: username,
      displayName: map['displayName']?.toString().trim().isNotEmpty == true
          ? map['displayName'].toString()
          : username,
    );
  }
}
