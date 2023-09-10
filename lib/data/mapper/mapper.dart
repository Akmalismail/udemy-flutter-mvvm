// mapper - convert response to non nullable object (model)

import 'package:udemy_flutter_mvvm/data/responses/responses.dart';
import 'package:udemy_flutter_mvvm/domain/model/model.dart';

const empty = '';
const zero = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id ?? empty,
      this?.name ?? empty,
      this?.numOfNotifications ?? zero,
    );
  }
}

extension ContactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(
      this?.phone ?? empty,
      this?.link ?? empty,
      this?.email ?? empty,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contact.toDomain(),
    );
  }
}

extension ResetPasswordResponseMapper on ResetPasswordResponse? {
  String toDomain() {
    return this?.support ?? empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id ?? zero,
      this?.title ?? empty,
      this?.image ?? empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id ?? zero,
      this?.title ?? empty,
      this?.image ?? empty,
    );
  }
}

extension BannerResponseMapper on BannerResponse? {
  Banner toDomain() {
    return Banner(
      this?.id ?? zero,
      this?.title ?? empty,
      this?.image ?? empty,
      this?.link ?? empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    List<Service> mappedServices =
        (this?.data?.services?.map((service) => service.toDomain()) ??
                const Iterable.empty())
            .cast<Service>()
            .toList();
    List<Store> mappedStores =
        (this?.data?.stores?.map((store) => store.toDomain()) ??
                const Iterable.empty())
            .cast<Store>()
            .toList();
    List<Banner> mappedBanners =
        (this?.data?.banners?.map((banner) => banner.toDomain()) ??
                const Iterable.empty())
            .cast<Banner>()
            .toList();

    return Home(
      HomeData(
        mappedServices,
        mappedStores,
        mappedBanners,
      ),
    );
  }
}
