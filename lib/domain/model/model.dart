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
  Customer? customer;
  Contact? contact;

  Authentication(this.customer, this.contact);
}

class DeviceInfo {
  final String name;
  final String identifier;
  final String version;

  const DeviceInfo(
    this.name,
    this.identifier,
    this.version,
  );
}

class Service {
  final String id;
  final String title;
  final String image;

  const Service(
    this.id,
    this.title,
    this.image,
  );
}

class Store {
  final String id;
  final String title;
  final String image;

  const Store(
    this.id,
    this.title,
    this.image,
  );
}

class Banner {
  final String id;
  final String title;
  final String image;
  final String link;

  const Banner(
    this.id,
    this.title,
    this.image,
    this.link,
  );
}

class HomeData {
  final List<Service> services;
  final List<Store> stores;
  final List<Banner> banners;

  const HomeData(
    this.services,
    this.stores,
    this.banners,
  );
}

class Home {
  final HomeData data;

  const Home(
    this.data,
  );
}
