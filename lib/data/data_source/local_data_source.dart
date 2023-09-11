import 'package:udemy_flutter_mvvm/data/network/error_handler.dart';
import 'package:udemy_flutter_mvvm/data/responses/responses.dart';

const cacheHomeKey = 'CACHE_HOME_KEY';
const cacheHomeInterval = 60 * 1000; // 1 minute in milliseconds

abstract class LocalDataSource {
  Future<HomeResponse> getHome();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
}

class LocalDataSourceImplementer implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHome() async {
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

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
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
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
