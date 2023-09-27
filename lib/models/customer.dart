class CustomerModel {
  String email;
  String first_name;
  String last_name;
  String password;

  CustomerModel(
      {required this.email,
      required this.first_name,
      required this.last_name,
      required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.addAll({
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
      'username': email,
    });

    return map;
  }
}
