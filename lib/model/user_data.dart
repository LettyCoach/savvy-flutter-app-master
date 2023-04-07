// ignore_for_file: non_constant_identifier_names

class User {
  User({
    required this.id,
    required this.name,
    required this.full_name,
    required this.email,
    required this.email_verified_at,
    required this.password,
    required this.zip_code,
    required this.address,
    required this.phone_number,
    required this.role_id,
    required this.profile_url,
    required this.settings,
    required this.status,
  });

  late int id;
  late String name;
  late String full_name;
  late String email;
  late String email_verified_at;
  late String password;
  late String zip_code;
  late String address;
  late String phone_number;
  late int role_id;
  late String profile_url;
  late String settings;
  late String status;

  factory User.fromJson(Map<String, dynamic> data) {
    final id = data['id'];
    final name = data['name'];
    final full_name = data['full_name'];
    final email = data['email'];
    final email_verified_at = data['email_verified_at'];
    final password = data['password'];
    final zip_code = data['zip_code'];
    final address = data['address'];
    final phone_number = data['phone_number'];
    final role_id = data['role_id'];
    final profile_url = data['profile_url'];
    final settings = data['settings'];
    final status = data['status'];

    return User(
      id: id ?? 0,
      name: name ?? '',
      full_name: full_name ?? '',
      email: email ?? '',
      email_verified_at: email_verified_at ?? '',
      password: password ?? '',
      zip_code: zip_code ?? '',
      address: address ?? '',
      phone_number: phone_number ?? '',
      role_id: role_id ?? 0,
      profile_url: profile_url ?? '',
      settings: settings ?? '',
      status: status ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['full_name'] = full_name;
    data['email'] = email;
    data['email_verified_at'] = email_verified_at;
    data['password'] = password;
    data['zip_code'] = zip_code;
    data['address'] = address;
    data['phone_number'] = phone_number;
    data['role_id'] = role_id;
    data['profile_url'] = profile_url;
    data['settings'] = settings;
    data['status'] = status;
    return data;
  }
}
