class UserEntity {
  final String uid;
  final String email;
  final String fullName;
  final DateTime dob;
  final String phoneNumber;
  final String gender;
  final String city;
  final String avatarUrl;

  UserEntity({
    required this.uid,
    required this.email,
    this.fullName = '',
    required this.dob,
    this.phoneNumber = '',
    this.gender = 'Other',
    this.city = '',
    this.avatarUrl = '',
  });

  factory UserEntity.fromFirebaseUser({
    required String uid,
    required String email,
    required String fullName,
    required DateTime dob,
    required String phoneNumber,
    required String gender,
    required String city,
    required String avatarUrl,
  }) {
    return UserEntity(
      uid: uid,
      email: email,
      fullName: fullName,
      dob: dob,
      phoneNumber: phoneNumber,
      gender: gender,
      city: city,
      avatarUrl: avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'dob': dob.toIso8601String(),
      'phoneNumber': phoneNumber,
      'gender': gender,
      'city': city,
      'avatarUrl': avatarUrl,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
}
