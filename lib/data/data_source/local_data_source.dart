import 'package:udemy_flutter_mvvm/data/network/error_handler.dart';
import 'package:udemy_flutter_mvvm/data/responses/responses.dart';

const cacheHomeKey = 'CACHE_HOME_KEY';
const cacheHomeInterval = 60 * 1000; // 1 minute in milliseconds

const cacheStoreDetailsKey = 'CACHE_STORE_DETAILS_KEY';
const cacheStoreDetailsInterval = 30 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  Future<StoreDetailsResponse> getStoreDetails();

  Future<void> saveStoreDetailToCache(StoreDetailsResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  final Map<String, CachedItem> _cacheMap = {};

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = _cacheMap[cacheHomeKey];

    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return error that cache is not valid
      throw ErrorHandler.handle(HttpStatus.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    _cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  Future<StoreDetailsResponse> getStoreDetails() async {
    CachedItem? cachedItem = _cacheMap[cacheStoreDetailsKey];

    if (cachedItem != null && cachedItem.isValid(cacheStoreDetailsInterval)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return error that cache is not valid
      throw ErrorHandler.handle(HttpStatus.cacheError);
    }
  }

  @override
  Future<void> saveStoreDetailToCache(
      StoreDetailsResponse storeDetailsReponse) async {
    _cacheMap[cacheStoreDetailsKey] = CachedItem(storeDetailsReponse);
  }

  @override
  void clearCache() {
    _cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    _cacheMap.remove(key);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemX on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMilliseconds = DateTime.now().millisecondsSinceEpoch;
    bool isCacheValid = currentTimeInMilliseconds - expirationTime < cacheTime;
    return isCacheValid;
  }
}
