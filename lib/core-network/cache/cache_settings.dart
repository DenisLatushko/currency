import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

enum CacheRule {
  noCache, forceCache
}

///A [CachePolicy] wrapper
final class CacheSettings {
  final CacheRule? _cacheRule;
  final Duration? _maxStale;

  CacheSettings(this._cacheRule, this._maxStale);

  Options toOptions() => CacheOptions(
        store: HiveCacheStore(null),
        policy: _getCachePolicy(),
        maxStale: _maxStale,
        priority: CachePriority.high,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false
    ).toOptions();

  CachePolicy _getCachePolicy() => switch(_cacheRule) {
      CacheRule.noCache => CachePolicy.noCache,
      CacheRule.forceCache => CachePolicy.forceCache,
      _ => CachePolicy.request
    };
}
