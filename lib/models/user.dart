class User {
  final String firstName;
  final String lastName;
  final String role;
  final String profileImageUrl;
  final int? points;
  final bool darkMode;

  User({
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profileImageUrl,
    this.points,
    this.darkMode = false,
  });
}
