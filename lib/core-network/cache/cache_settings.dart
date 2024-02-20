import 'dart:io';

import 'package:currency/core-utils/directory_provider.dart';
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
  final DirectoryProvider _directoryProvider;

  CacheSettings(this._cacheRule, this._maxStale, this._directoryProvider);

  Future<Options> toOptions() async {
    Directory tempDir = await _directoryProvider.tempDirectory;
    return CacheOptions(
        store: HiveCacheStore(tempDir.path),
        policy: _getCachePolicy(),
        maxStale: _maxStale,
        priority: CachePriority.high,
        keyBuilder: CacheOptions.defaultCacheKeyBuilder,
        allowPostMethod: false
    ).toOptions();
  }

  CachePolicy _getCachePolicy() => switch(_cacheRule) {
      CacheRule.noCache => CachePolicy.noCache,
      CacheRule.forceCache => CachePolicy.forceCache,
      _ => CachePolicy.request
    };
}
