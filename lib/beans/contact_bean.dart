class ContactBean extends Object{
  int? id;
  String? name;
  String? phone;
  String? email;
  String? birthday;

  @override
  String toString() {
    return 'ContactBean{id: $id, name: $name, phone: $phone, email: $email, birthday: $birthday}';
  }
}