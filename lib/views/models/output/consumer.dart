class ConsumerOutputModel {
  String email;
  String name;
  String phone;
  String address;

  ConsumerOutputModel(this.email, this.name, this.phone, this.address);

  set setEmail(String email) => this.email = email;

  get getEmail => this.email;

  set setName(String name) => this.name = name;

  get getName => this.name;

  set setPhone(String phone) => this.phone = phone;

  get getPhone => this.phone;

  set setAddress(String address) => this.address = address;

  get getAddress => this.address;
}
