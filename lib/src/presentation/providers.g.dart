// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherDataSourceHash() => r'c5c4c998d450a05e7c363e4fc176734149eb3dbe';

/// See also [weatherDataSource].
@ProviderFor(weatherDataSource)
final weatherDataSourceProvider =
    AutoDisposeProvider<IWeatherDataSource>.internal(
  weatherDataSource,
  name: r'weatherDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeatherDataSourceRef = AutoDisposeProviderRef<IWeatherDataSource>;
String _$weatherRepositoryHash() => r'9ed48adfa3b3fd7e4d0da5370a11c70d33de8b6b';

/// See also [weatherRepository].
@ProviderFor(weatherRepository)
final weatherRepositoryProvider =
    AutoDisposeProvider<WeatherRepository>.internal(
  weatherRepository,
  name: r'weatherRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$weatherRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WeatherRepositoryRef = AutoDisposeProviderRef<WeatherRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
