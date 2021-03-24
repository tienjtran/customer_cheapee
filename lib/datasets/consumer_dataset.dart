class ConsumerDataset {
  final String email;
  final String name;
  final String phone;
  final String address;

  ConsumerDataset({this.email, this.name, this.phone, this.address});

  factory ConsumerDataset.fromJson(Map<String, dynamic> json) {
    return ConsumerDataset(
        email: json['emailAddress'] as String,
        name: json['name'] as String,
        phone: json['phoneNumber'] as String,
        address: json['address'] as String);
  }
}
