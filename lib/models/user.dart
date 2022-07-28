class User {
  User({required this.username, required this.name,});
  final String username, name;
}

class SingleUser {
  SingleUser({required this.name, required this.email, required this.phone, required this.website, required this.address, required this.working, });
  final String name, email, phone, website, address;
  final Map working;
}