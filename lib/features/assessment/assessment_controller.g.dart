// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$assessmentControllerHash() =>
    r'ef1eabe634e4bca47d023da0617ffa79168e91bd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$AssessmentController
    extends BuildlessAutoDisposeAsyncNotifier<AssessmentModel> {
  late final String seniorId;

  FutureOr<AssessmentModel> build(String seniorId);
}

/// See also [AssessmentController].
@ProviderFor(AssessmentController)
const assessmentControllerProvider = AssessmentControllerFamily();

/// See also [AssessmentController].
class AssessmentControllerFamily extends Family<AsyncValue<AssessmentModel>> {
  /// See also [AssessmentController].
  const AssessmentControllerFamily();

  /// See also [AssessmentController].
  AssessmentControllerProvider call(String seniorId) {
    return AssessmentControllerProvider(seniorId);
  }

  @override
  AssessmentControllerProvider getProviderOverride(
    covariant AssessmentControllerProvider provider,
  ) {
    return call(provider.seniorId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'assessmentControllerProvider';
}

/// See also [AssessmentController].
class AssessmentControllerProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          AssessmentController,
          AssessmentModel
        > {
  /// See also [AssessmentController].
  AssessmentControllerProvider(String seniorId)
    : this._internal(
        () => AssessmentController()..seniorId = seniorId,
        from: assessmentControllerProvider,
        name: r'assessmentControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$assessmentControllerHash,
        dependencies: AssessmentControllerFamily._dependencies,
        allTransitiveDependencies:
            AssessmentControllerFamily._allTransitiveDependencies,
        seniorId: seniorId,
      );

  AssessmentControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.seniorId,
  }) : super.internal();

  final String seniorId;

  @override
  FutureOr<AssessmentModel> runNotifierBuild(
    covariant AssessmentController notifier,
  ) {
    return notifier.build(seniorId);
  }

  @override
  Override overrideWith(AssessmentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AssessmentControllerProvider._internal(
        () => create()..seniorId = seniorId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        seniorId: seniorId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AssessmentController, AssessmentModel>
  createElement() {
    return _AssessmentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AssessmentControllerProvider && other.seniorId == seniorId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, seniorId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AssessmentControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AssessmentModel> {
  /// The parameter `seniorId` of this provider.
  String get seniorId;
}

class _AssessmentControllerProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          AssessmentController,
          AssessmentModel
        >
    with AssessmentControllerRef {
  _AssessmentControllerProviderElement(super.provider);

  @override
  String get seniorId => (origin as AssessmentControllerProvider).seniorId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
