class SliderObject {
  final String title;
  final String subTitle;
  final String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer {
  final String id;
  final String name;
  final int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contact {
  final String phone;
  final String link;
  final String email;

  Contact(this.phone, this.link, this.email);
}

class Authentication {
  Customer customer;
  Contact contact;

  Authentication(this.customer, this.contact);
}
