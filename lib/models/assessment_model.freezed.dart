// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assessment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AssessmentModel _$AssessmentModelFromJson(Map<String, dynamic> json) {
  return _AssessmentModel.fromJson(json);
}

/// @nodoc
mixin _$AssessmentModel {
  AssessmentMetadata get metadata => throw _privateConstructorUsedError;
  @JsonKey(name: 'inputs_fwb')
  InputsFWB get inputsFwb => throw _privateConstructorUsedError;
  @JsonKey(name: 'inputs_ct')
  InputsCT get inputsCt => throw _privateConstructorUsedError;
  @JsonKey(name: 'inputs_es')
  InputsES get inputsEs => throw _privateConstructorUsedError;
  @JsonKey(name: 'calculated_results')
  CalculatedResults get calculatedResults => throw _privateConstructorUsedError;

  /// Serializes this AssessmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentModelCopyWith<AssessmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentModelCopyWith<$Res> {
  factory $AssessmentModelCopyWith(
    AssessmentModel value,
    $Res Function(AssessmentModel) then,
  ) = _$AssessmentModelCopyWithImpl<$Res, AssessmentModel>;
  @useResult
  $Res call({
    AssessmentMetadata metadata,
    @JsonKey(name: 'inputs_fwb') InputsFWB inputsFwb,
    @JsonKey(name: 'inputs_ct') InputsCT inputsCt,
    @JsonKey(name: 'inputs_es') InputsES inputsEs,
    @JsonKey(name: 'calculated_results') CalculatedResults calculatedResults,
  });

  $AssessmentMetadataCopyWith<$Res> get metadata;
  $InputsFWBCopyWith<$Res> get inputsFwb;
  $InputsCTCopyWith<$Res> get inputsCt;
  $InputsESCopyWith<$Res> get inputsEs;
  $CalculatedResultsCopyWith<$Res> get calculatedResults;
}

/// @nodoc
class _$AssessmentModelCopyWithImpl<$Res, $Val extends AssessmentModel>
    implements $AssessmentModelCopyWith<$Res> {
  _$AssessmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metadata = null,
    Object? inputsFwb = null,
    Object? inputsCt = null,
    Object? inputsEs = null,
    Object? calculatedResults = null,
  }) {
    return _then(
      _value.copyWith(
            metadata: null == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as AssessmentMetadata,
            inputsFwb: null == inputsFwb
                ? _value.inputsFwb
                : inputsFwb // ignore: cast_nullable_to_non_nullable
                      as InputsFWB,
            inputsCt: null == inputsCt
                ? _value.inputsCt
                : inputsCt // ignore: cast_nullable_to_non_nullable
                      as InputsCT,
            inputsEs: null == inputsEs
                ? _value.inputsEs
                : inputsEs // ignore: cast_nullable_to_non_nullable
                      as InputsES,
            calculatedResults: null == calculatedResults
                ? _value.calculatedResults
                : calculatedResults // ignore: cast_nullable_to_non_nullable
                      as CalculatedResults,
          )
          as $Val,
    );
  }

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssessmentMetadataCopyWith<$Res> get metadata {
    return $AssessmentMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InputsFWBCopyWith<$Res> get inputsFwb {
    return $InputsFWBCopyWith<$Res>(_value.inputsFwb, (value) {
      return _then(_value.copyWith(inputsFwb: value) as $Val);
    });
  }

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InputsCTCopyWith<$Res> get inputsCt {
    return $InputsCTCopyWith<$Res>(_value.inputsCt, (value) {
      return _then(_value.copyWith(inputsCt: value) as $Val);
    });
  }

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InputsESCopyWith<$Res> get inputsEs {
    return $InputsESCopyWith<$Res>(_value.inputsEs, (value) {
      return _then(_value.copyWith(inputsEs: value) as $Val);
    });
  }

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CalculatedResultsCopyWith<$Res> get calculatedResults {
    return $CalculatedResultsCopyWith<$Res>(_value.calculatedResults, (value) {
      return _then(_value.copyWith(calculatedResults: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AssessmentModelImplCopyWith<$Res>
    implements $AssessmentModelCopyWith<$Res> {
  factory _$$AssessmentModelImplCopyWith(
    _$AssessmentModelImpl value,
    $Res Function(_$AssessmentModelImpl) then,
  ) = __$$AssessmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    AssessmentMetadata metadata,
    @JsonKey(name: 'inputs_fwb') InputsFWB inputsFwb,
    @JsonKey(name: 'inputs_ct') InputsCT inputsCt,
    @JsonKey(name: 'inputs_es') InputsES inputsEs,
    @JsonKey(name: 'calculated_results') CalculatedResults calculatedResults,
  });

  @override
  $AssessmentMetadataCopyWith<$Res> get metadata;
  @override
  $InputsFWBCopyWith<$Res> get inputsFwb;
  @override
  $InputsCTCopyWith<$Res> get inputsCt;
  @override
  $InputsESCopyWith<$Res> get inputsEs;
  @override
  $CalculatedResultsCopyWith<$Res> get calculatedResults;
}

/// @nodoc
class __$$AssessmentModelImplCopyWithImpl<$Res>
    extends _$AssessmentModelCopyWithImpl<$Res, _$AssessmentModelImpl>
    implements _$$AssessmentModelImplCopyWith<$Res> {
  __$$AssessmentModelImplCopyWithImpl(
    _$AssessmentModelImpl _value,
    $Res Function(_$AssessmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metadata = null,
    Object? inputsFwb = null,
    Object? inputsCt = null,
    Object? inputsEs = null,
    Object? calculatedResults = null,
  }) {
    return _then(
      _$AssessmentModelImpl(
        metadata: null == metadata
            ? _value.metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as AssessmentMetadata,
        inputsFwb: null == inputsFwb
            ? _value.inputsFwb
            : inputsFwb // ignore: cast_nullable_to_non_nullable
                  as InputsFWB,
        inputsCt: null == inputsCt
            ? _value.inputsCt
            : inputsCt // ignore: cast_nullable_to_non_nullable
                  as InputsCT,
        inputsEs: null == inputsEs
            ? _value.inputsEs
            : inputsEs // ignore: cast_nullable_to_non_nullable
                  as InputsES,
        calculatedResults: null == calculatedResults
            ? _value.calculatedResults
            : calculatedResults // ignore: cast_nullable_to_non_nullable
                  as CalculatedResults,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentModelImpl implements _AssessmentModel {
  const _$AssessmentModelImpl({
    required this.metadata,
    @JsonKey(name: 'inputs_fwb') required this.inputsFwb,
    @JsonKey(name: 'inputs_ct') required this.inputsCt,
    @JsonKey(name: 'inputs_es') required this.inputsEs,
    @JsonKey(name: 'calculated_results') required this.calculatedResults,
  });

  factory _$AssessmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentModelImplFromJson(json);

  @override
  final AssessmentMetadata metadata;
  @override
  @JsonKey(name: 'inputs_fwb')
  final InputsFWB inputsFwb;
  @override
  @JsonKey(name: 'inputs_ct')
  final InputsCT inputsCt;
  @override
  @JsonKey(name: 'inputs_es')
  final InputsES inputsEs;
  @override
  @JsonKey(name: 'calculated_results')
  final CalculatedResults calculatedResults;

  @override
  String toString() {
    return 'AssessmentModel(metadata: $metadata, inputsFwb: $inputsFwb, inputsCt: $inputsCt, inputsEs: $inputsEs, calculatedResults: $calculatedResults)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentModelImpl &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.inputsFwb, inputsFwb) ||
                other.inputsFwb == inputsFwb) &&
            (identical(other.inputsCt, inputsCt) ||
                other.inputsCt == inputsCt) &&
            (identical(other.inputsEs, inputsEs) ||
                other.inputsEs == inputsEs) &&
            (identical(other.calculatedResults, calculatedResults) ||
                other.calculatedResults == calculatedResults));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    metadata,
    inputsFwb,
    inputsCt,
    inputsEs,
    calculatedResults,
  );

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentModelImplCopyWith<_$AssessmentModelImpl> get copyWith =>
      __$$AssessmentModelImplCopyWithImpl<_$AssessmentModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentModelImplToJson(this);
  }
}

abstract class _AssessmentModel implements AssessmentModel {
  const factory _AssessmentModel({
    required final AssessmentMetadata metadata,
    @JsonKey(name: 'inputs_fwb') required final InputsFWB inputsFwb,
    @JsonKey(name: 'inputs_ct') required final InputsCT inputsCt,
    @JsonKey(name: 'inputs_es') required final InputsES inputsEs,
    @JsonKey(name: 'calculated_results')
    required final CalculatedResults calculatedResults,
  }) = _$AssessmentModelImpl;

  factory _AssessmentModel.fromJson(Map<String, dynamic> json) =
      _$AssessmentModelImpl.fromJson;

  @override
  AssessmentMetadata get metadata;
  @override
  @JsonKey(name: 'inputs_fwb')
  InputsFWB get inputsFwb;
  @override
  @JsonKey(name: 'inputs_ct')
  InputsCT get inputsCt;
  @override
  @JsonKey(name: 'inputs_es')
  InputsES get inputsEs;
  @override
  @JsonKey(name: 'calculated_results')
  CalculatedResults get calculatedResults;

  /// Create a copy of AssessmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentModelImplCopyWith<_$AssessmentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AssessmentMetadata _$AssessmentMetadataFromJson(Map<String, dynamic> json) {
  return _AssessmentMetadata.fromJson(json);
}

/// @nodoc
mixin _$AssessmentMetadata {
  @JsonKey(name: 'assessment_id')
  String get assessmentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'senior_id')
  String get seniorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AssessmentMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AssessmentMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AssessmentMetadataCopyWith<AssessmentMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssessmentMetadataCopyWith<$Res> {
  factory $AssessmentMetadataCopyWith(
    AssessmentMetadata value,
    $Res Function(AssessmentMetadata) then,
  ) = _$AssessmentMetadataCopyWithImpl<$Res, AssessmentMetadata>;
  @useResult
  $Res call({
    @JsonKey(name: 'assessment_id') String assessmentId,
    @JsonKey(name: 'senior_id') String seniorId,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class _$AssessmentMetadataCopyWithImpl<$Res, $Val extends AssessmentMetadata>
    implements $AssessmentMetadataCopyWith<$Res> {
  _$AssessmentMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AssessmentMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? seniorId = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            assessmentId: null == assessmentId
                ? _value.assessmentId
                : assessmentId // ignore: cast_nullable_to_non_nullable
                      as String,
            seniorId: null == seniorId
                ? _value.seniorId
                : seniorId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AssessmentMetadataImplCopyWith<$Res>
    implements $AssessmentMetadataCopyWith<$Res> {
  factory _$$AssessmentMetadataImplCopyWith(
    _$AssessmentMetadataImpl value,
    $Res Function(_$AssessmentMetadataImpl) then,
  ) = __$$AssessmentMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'assessment_id') String assessmentId,
    @JsonKey(name: 'senior_id') String seniorId,
    @JsonKey(name: 'created_at') DateTime createdAt,
  });
}

/// @nodoc
class __$$AssessmentMetadataImplCopyWithImpl<$Res>
    extends _$AssessmentMetadataCopyWithImpl<$Res, _$AssessmentMetadataImpl>
    implements _$$AssessmentMetadataImplCopyWith<$Res> {
  __$$AssessmentMetadataImplCopyWithImpl(
    _$AssessmentMetadataImpl _value,
    $Res Function(_$AssessmentMetadataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AssessmentMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? assessmentId = null,
    Object? seniorId = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$AssessmentMetadataImpl(
        assessmentId: null == assessmentId
            ? _value.assessmentId
            : assessmentId // ignore: cast_nullable_to_non_nullable
                  as String,
        seniorId: null == seniorId
            ? _value.seniorId
            : seniorId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AssessmentMetadataImpl implements _AssessmentMetadata {
  const _$AssessmentMetadataImpl({
    @JsonKey(name: 'assessment_id') required this.assessmentId,
    @JsonKey(name: 'senior_id') required this.seniorId,
    @JsonKey(name: 'created_at') required this.createdAt,
  });

  factory _$AssessmentMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssessmentMetadataImplFromJson(json);

  @override
  @JsonKey(name: 'assessment_id')
  final String assessmentId;
  @override
  @JsonKey(name: 'senior_id')
  final String seniorId;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'AssessmentMetadata(assessmentId: $assessmentId, seniorId: $seniorId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssessmentMetadataImpl &&
            (identical(other.assessmentId, assessmentId) ||
                other.assessmentId == assessmentId) &&
            (identical(other.seniorId, seniorId) ||
                other.seniorId == seniorId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, assessmentId, seniorId, createdAt);

  /// Create a copy of AssessmentMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AssessmentMetadataImplCopyWith<_$AssessmentMetadataImpl> get copyWith =>
      __$$AssessmentMetadataImplCopyWithImpl<_$AssessmentMetadataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AssessmentMetadataImplToJson(this);
  }
}

abstract class _AssessmentMetadata implements AssessmentMetadata {
  const factory _AssessmentMetadata({
    @JsonKey(name: 'assessment_id') required final String assessmentId,
    @JsonKey(name: 'senior_id') required final String seniorId,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
  }) = _$AssessmentMetadataImpl;

  factory _AssessmentMetadata.fromJson(Map<String, dynamic> json) =
      _$AssessmentMetadataImpl.fromJson;

  @override
  @JsonKey(name: 'assessment_id')
  String get assessmentId;
  @override
  @JsonKey(name: 'senior_id')
  String get seniorId;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of AssessmentMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AssessmentMetadataImplCopyWith<_$AssessmentMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InputsFWB _$InputsFWBFromJson(Map<String, dynamic> json) {
  return _InputsFWB.fromJson(json);
}

/// @nodoc
mixin _$InputsFWB {
  ADLs get adls => throw _privateConstructorUsedError;
  IADLs get iadls => throw _privateConstructorUsedError;
  @JsonKey(name: 'gait_speed_score')
  int get gaitSpeedScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobility_device_score')
  int get mobilityDeviceScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'grip_strength_score')
  int get gripStrengthScore => throw _privateConstructorUsedError;
  @JsonKey(name: 'falls_history_score')
  int get fallsHistoryScore => throw _privateConstructorUsedError;

  /// Serializes this InputsFWB to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InputsFWBCopyWith<InputsFWB> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputsFWBCopyWith<$Res> {
  factory $InputsFWBCopyWith(InputsFWB value, $Res Function(InputsFWB) then) =
      _$InputsFWBCopyWithImpl<$Res, InputsFWB>;
  @useResult
  $Res call({
    ADLs adls,
    IADLs iadls,
    @JsonKey(name: 'gait_speed_score') int gaitSpeedScore,
    @JsonKey(name: 'mobility_device_score') int mobilityDeviceScore,
    @JsonKey(name: 'grip_strength_score') int gripStrengthScore,
    @JsonKey(name: 'falls_history_score') int fallsHistoryScore,
  });

  $ADLsCopyWith<$Res> get adls;
  $IADLsCopyWith<$Res> get iadls;
}

/// @nodoc
class _$InputsFWBCopyWithImpl<$Res, $Val extends InputsFWB>
    implements $InputsFWBCopyWith<$Res> {
  _$InputsFWBCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adls = null,
    Object? iadls = null,
    Object? gaitSpeedScore = null,
    Object? mobilityDeviceScore = null,
    Object? gripStrengthScore = null,
    Object? fallsHistoryScore = null,
  }) {
    return _then(
      _value.copyWith(
            adls: null == adls
                ? _value.adls
                : adls // ignore: cast_nullable_to_non_nullable
                      as ADLs,
            iadls: null == iadls
                ? _value.iadls
                : iadls // ignore: cast_nullable_to_non_nullable
                      as IADLs,
            gaitSpeedScore: null == gaitSpeedScore
                ? _value.gaitSpeedScore
                : gaitSpeedScore // ignore: cast_nullable_to_non_nullable
                      as int,
            mobilityDeviceScore: null == mobilityDeviceScore
                ? _value.mobilityDeviceScore
                : mobilityDeviceScore // ignore: cast_nullable_to_non_nullable
                      as int,
            gripStrengthScore: null == gripStrengthScore
                ? _value.gripStrengthScore
                : gripStrengthScore // ignore: cast_nullable_to_non_nullable
                      as int,
            fallsHistoryScore: null == fallsHistoryScore
                ? _value.fallsHistoryScore
                : fallsHistoryScore // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ADLsCopyWith<$Res> get adls {
    return $ADLsCopyWith<$Res>(_value.adls, (value) {
      return _then(_value.copyWith(adls: value) as $Val);
    });
  }

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $IADLsCopyWith<$Res> get iadls {
    return $IADLsCopyWith<$Res>(_value.iadls, (value) {
      return _then(_value.copyWith(iadls: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InputsFWBImplCopyWith<$Res>
    implements $InputsFWBCopyWith<$Res> {
  factory _$$InputsFWBImplCopyWith(
    _$InputsFWBImpl value,
    $Res Function(_$InputsFWBImpl) then,
  ) = __$$InputsFWBImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    ADLs adls,
    IADLs iadls,
    @JsonKey(name: 'gait_speed_score') int gaitSpeedScore,
    @JsonKey(name: 'mobility_device_score') int mobilityDeviceScore,
    @JsonKey(name: 'grip_strength_score') int gripStrengthScore,
    @JsonKey(name: 'falls_history_score') int fallsHistoryScore,
  });

  @override
  $ADLsCopyWith<$Res> get adls;
  @override
  $IADLsCopyWith<$Res> get iadls;
}

/// @nodoc
class __$$InputsFWBImplCopyWithImpl<$Res>
    extends _$InputsFWBCopyWithImpl<$Res, _$InputsFWBImpl>
    implements _$$InputsFWBImplCopyWith<$Res> {
  __$$InputsFWBImplCopyWithImpl(
    _$InputsFWBImpl _value,
    $Res Function(_$InputsFWBImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adls = null,
    Object? iadls = null,
    Object? gaitSpeedScore = null,
    Object? mobilityDeviceScore = null,
    Object? gripStrengthScore = null,
    Object? fallsHistoryScore = null,
  }) {
    return _then(
      _$InputsFWBImpl(
        adls: null == adls
            ? _value.adls
            : adls // ignore: cast_nullable_to_non_nullable
                  as ADLs,
        iadls: null == iadls
            ? _value.iadls
            : iadls // ignore: cast_nullable_to_non_nullable
                  as IADLs,
        gaitSpeedScore: null == gaitSpeedScore
            ? _value.gaitSpeedScore
            : gaitSpeedScore // ignore: cast_nullable_to_non_nullable
                  as int,
        mobilityDeviceScore: null == mobilityDeviceScore
            ? _value.mobilityDeviceScore
            : mobilityDeviceScore // ignore: cast_nullable_to_non_nullable
                  as int,
        gripStrengthScore: null == gripStrengthScore
            ? _value.gripStrengthScore
            : gripStrengthScore // ignore: cast_nullable_to_non_nullable
                  as int,
        fallsHistoryScore: null == fallsHistoryScore
            ? _value.fallsHistoryScore
            : fallsHistoryScore // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InputsFWBImpl implements _InputsFWB {
  const _$InputsFWBImpl({
    this.adls = const ADLs(),
    this.iadls = const IADLs(),
    @JsonKey(name: 'gait_speed_score') this.gaitSpeedScore = 5,
    @JsonKey(name: 'mobility_device_score') this.mobilityDeviceScore = 4,
    @JsonKey(name: 'grip_strength_score') this.gripStrengthScore = 4,
    @JsonKey(name: 'falls_history_score') this.fallsHistoryScore = 3,
  });

  factory _$InputsFWBImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputsFWBImplFromJson(json);

  @override
  @JsonKey()
  final ADLs adls;
  @override
  @JsonKey()
  final IADLs iadls;
  @override
  @JsonKey(name: 'gait_speed_score')
  final int gaitSpeedScore;
  @override
  @JsonKey(name: 'mobility_device_score')
  final int mobilityDeviceScore;
  @override
  @JsonKey(name: 'grip_strength_score')
  final int gripStrengthScore;
  @override
  @JsonKey(name: 'falls_history_score')
  final int fallsHistoryScore;

  @override
  String toString() {
    return 'InputsFWB(adls: $adls, iadls: $iadls, gaitSpeedScore: $gaitSpeedScore, mobilityDeviceScore: $mobilityDeviceScore, gripStrengthScore: $gripStrengthScore, fallsHistoryScore: $fallsHistoryScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputsFWBImpl &&
            (identical(other.adls, adls) || other.adls == adls) &&
            (identical(other.iadls, iadls) || other.iadls == iadls) &&
            (identical(other.gaitSpeedScore, gaitSpeedScore) ||
                other.gaitSpeedScore == gaitSpeedScore) &&
            (identical(other.mobilityDeviceScore, mobilityDeviceScore) ||
                other.mobilityDeviceScore == mobilityDeviceScore) &&
            (identical(other.gripStrengthScore, gripStrengthScore) ||
                other.gripStrengthScore == gripStrengthScore) &&
            (identical(other.fallsHistoryScore, fallsHistoryScore) ||
                other.fallsHistoryScore == fallsHistoryScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    adls,
    iadls,
    gaitSpeedScore,
    mobilityDeviceScore,
    gripStrengthScore,
    fallsHistoryScore,
  );

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputsFWBImplCopyWith<_$InputsFWBImpl> get copyWith =>
      __$$InputsFWBImplCopyWithImpl<_$InputsFWBImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputsFWBImplToJson(this);
  }
}

abstract class _InputsFWB implements InputsFWB {
  const factory _InputsFWB({
    final ADLs adls,
    final IADLs iadls,
    @JsonKey(name: 'gait_speed_score') final int gaitSpeedScore,
    @JsonKey(name: 'mobility_device_score') final int mobilityDeviceScore,
    @JsonKey(name: 'grip_strength_score') final int gripStrengthScore,
    @JsonKey(name: 'falls_history_score') final int fallsHistoryScore,
  }) = _$InputsFWBImpl;

  factory _InputsFWB.fromJson(Map<String, dynamic> json) =
      _$InputsFWBImpl.fromJson;

  @override
  ADLs get adls;
  @override
  IADLs get iadls;
  @override
  @JsonKey(name: 'gait_speed_score')
  int get gaitSpeedScore;
  @override
  @JsonKey(name: 'mobility_device_score')
  int get mobilityDeviceScore;
  @override
  @JsonKey(name: 'grip_strength_score')
  int get gripStrengthScore;
  @override
  @JsonKey(name: 'falls_history_score')
  int get fallsHistoryScore;

  /// Create a copy of InputsFWB
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputsFWBImplCopyWith<_$InputsFWBImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ADLs _$ADLsFromJson(Map<String, dynamic> json) {
  return _ADLs.fromJson(json);
}

/// @nodoc
mixin _$ADLs {
  int get bathing => throw _privateConstructorUsedError;
  int get dressing => throw _privateConstructorUsedError;
  int get toileting => throw _privateConstructorUsedError;
  int get transferring => throw _privateConstructorUsedError;
  int get continence => throw _privateConstructorUsedError;
  int get feeding => throw _privateConstructorUsedError;

  /// Serializes this ADLs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ADLs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ADLsCopyWith<ADLs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ADLsCopyWith<$Res> {
  factory $ADLsCopyWith(ADLs value, $Res Function(ADLs) then) =
      _$ADLsCopyWithImpl<$Res, ADLs>;
  @useResult
  $Res call({
    int bathing,
    int dressing,
    int toileting,
    int transferring,
    int continence,
    int feeding,
  });
}

/// @nodoc
class _$ADLsCopyWithImpl<$Res, $Val extends ADLs>
    implements $ADLsCopyWith<$Res> {
  _$ADLsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ADLs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bathing = null,
    Object? dressing = null,
    Object? toileting = null,
    Object? transferring = null,
    Object? continence = null,
    Object? feeding = null,
  }) {
    return _then(
      _value.copyWith(
            bathing: null == bathing
                ? _value.bathing
                : bathing // ignore: cast_nullable_to_non_nullable
                      as int,
            dressing: null == dressing
                ? _value.dressing
                : dressing // ignore: cast_nullable_to_non_nullable
                      as int,
            toileting: null == toileting
                ? _value.toileting
                : toileting // ignore: cast_nullable_to_non_nullable
                      as int,
            transferring: null == transferring
                ? _value.transferring
                : transferring // ignore: cast_nullable_to_non_nullable
                      as int,
            continence: null == continence
                ? _value.continence
                : continence // ignore: cast_nullable_to_non_nullable
                      as int,
            feeding: null == feeding
                ? _value.feeding
                : feeding // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ADLsImplCopyWith<$Res> implements $ADLsCopyWith<$Res> {
  factory _$$ADLsImplCopyWith(
    _$ADLsImpl value,
    $Res Function(_$ADLsImpl) then,
  ) = __$$ADLsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int bathing,
    int dressing,
    int toileting,
    int transferring,
    int continence,
    int feeding,
  });
}

/// @nodoc
class __$$ADLsImplCopyWithImpl<$Res>
    extends _$ADLsCopyWithImpl<$Res, _$ADLsImpl>
    implements _$$ADLsImplCopyWith<$Res> {
  __$$ADLsImplCopyWithImpl(_$ADLsImpl _value, $Res Function(_$ADLsImpl) _then)
    : super(_value, _then);

  /// Create a copy of ADLs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bathing = null,
    Object? dressing = null,
    Object? toileting = null,
    Object? transferring = null,
    Object? continence = null,
    Object? feeding = null,
  }) {
    return _then(
      _$ADLsImpl(
        bathing: null == bathing
            ? _value.bathing
            : bathing // ignore: cast_nullable_to_non_nullable
                  as int,
        dressing: null == dressing
            ? _value.dressing
            : dressing // ignore: cast_nullable_to_non_nullable
                  as int,
        toileting: null == toileting
            ? _value.toileting
            : toileting // ignore: cast_nullable_to_non_nullable
                  as int,
        transferring: null == transferring
            ? _value.transferring
            : transferring // ignore: cast_nullable_to_non_nullable
                  as int,
        continence: null == continence
            ? _value.continence
            : continence // ignore: cast_nullable_to_non_nullable
                  as int,
        feeding: null == feeding
            ? _value.feeding
            : feeding // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ADLsImpl implements _ADLs {
  const _$ADLsImpl({
    this.bathing = 2,
    this.dressing = 2,
    this.toileting = 2,
    this.transferring = 2,
    this.continence = 2,
    this.feeding = 2,
  });

  factory _$ADLsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ADLsImplFromJson(json);

  @override
  @JsonKey()
  final int bathing;
  @override
  @JsonKey()
  final int dressing;
  @override
  @JsonKey()
  final int toileting;
  @override
  @JsonKey()
  final int transferring;
  @override
  @JsonKey()
  final int continence;
  @override
  @JsonKey()
  final int feeding;

  @override
  String toString() {
    return 'ADLs(bathing: $bathing, dressing: $dressing, toileting: $toileting, transferring: $transferring, continence: $continence, feeding: $feeding)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ADLsImpl &&
            (identical(other.bathing, bathing) || other.bathing == bathing) &&
            (identical(other.dressing, dressing) ||
                other.dressing == dressing) &&
            (identical(other.toileting, toileting) ||
                other.toileting == toileting) &&
            (identical(other.transferring, transferring) ||
                other.transferring == transferring) &&
            (identical(other.continence, continence) ||
                other.continence == continence) &&
            (identical(other.feeding, feeding) || other.feeding == feeding));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    bathing,
    dressing,
    toileting,
    transferring,
    continence,
    feeding,
  );

  /// Create a copy of ADLs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ADLsImplCopyWith<_$ADLsImpl> get copyWith =>
      __$$ADLsImplCopyWithImpl<_$ADLsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ADLsImplToJson(this);
  }
}

abstract class _ADLs implements ADLs {
  const factory _ADLs({
    final int bathing,
    final int dressing,
    final int toileting,
    final int transferring,
    final int continence,
    final int feeding,
  }) = _$ADLsImpl;

  factory _ADLs.fromJson(Map<String, dynamic> json) = _$ADLsImpl.fromJson;

  @override
  int get bathing;
  @override
  int get dressing;
  @override
  int get toileting;
  @override
  int get transferring;
  @override
  int get continence;
  @override
  int get feeding;

  /// Create a copy of ADLs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ADLsImplCopyWith<_$ADLsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

IADLs _$IADLsFromJson(Map<String, dynamic> json) {
  return _IADLs.fromJson(json);
}

/// @nodoc
mixin _$IADLs {
  @JsonKey(name: 'managing_finances')
  int get managingFinances => throw _privateConstructorUsedError;
  @JsonKey(name: 'handling_transportation')
  int get handlingTransportation => throw _privateConstructorUsedError;
  int get shopping => throw _privateConstructorUsedError;
  @JsonKey(name: 'preparing_meals')
  int get preparingMeals => throw _privateConstructorUsedError;
  @JsonKey(name: 'using_telephone')
  int get usingTelephone => throw _privateConstructorUsedError;
  @JsonKey(name: 'managing_medication')
  int get managingMedication => throw _privateConstructorUsedError;
  int get housekeeping => throw _privateConstructorUsedError;

  /// Serializes this IADLs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of IADLs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $IADLsCopyWith<IADLs> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IADLsCopyWith<$Res> {
  factory $IADLsCopyWith(IADLs value, $Res Function(IADLs) then) =
      _$IADLsCopyWithImpl<$Res, IADLs>;
  @useResult
  $Res call({
    @JsonKey(name: 'managing_finances') int managingFinances,
    @JsonKey(name: 'handling_transportation') int handlingTransportation,
    int shopping,
    @JsonKey(name: 'preparing_meals') int preparingMeals,
    @JsonKey(name: 'using_telephone') int usingTelephone,
    @JsonKey(name: 'managing_medication') int managingMedication,
    int housekeeping,
  });
}

/// @nodoc
class _$IADLsCopyWithImpl<$Res, $Val extends IADLs>
    implements $IADLsCopyWith<$Res> {
  _$IADLsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of IADLs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? managingFinances = null,
    Object? handlingTransportation = null,
    Object? shopping = null,
    Object? preparingMeals = null,
    Object? usingTelephone = null,
    Object? managingMedication = null,
    Object? housekeeping = null,
  }) {
    return _then(
      _value.copyWith(
            managingFinances: null == managingFinances
                ? _value.managingFinances
                : managingFinances // ignore: cast_nullable_to_non_nullable
                      as int,
            handlingTransportation: null == handlingTransportation
                ? _value.handlingTransportation
                : handlingTransportation // ignore: cast_nullable_to_non_nullable
                      as int,
            shopping: null == shopping
                ? _value.shopping
                : shopping // ignore: cast_nullable_to_non_nullable
                      as int,
            preparingMeals: null == preparingMeals
                ? _value.preparingMeals
                : preparingMeals // ignore: cast_nullable_to_non_nullable
                      as int,
            usingTelephone: null == usingTelephone
                ? _value.usingTelephone
                : usingTelephone // ignore: cast_nullable_to_non_nullable
                      as int,
            managingMedication: null == managingMedication
                ? _value.managingMedication
                : managingMedication // ignore: cast_nullable_to_non_nullable
                      as int,
            housekeeping: null == housekeeping
                ? _value.housekeeping
                : housekeeping // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$IADLsImplCopyWith<$Res> implements $IADLsCopyWith<$Res> {
  factory _$$IADLsImplCopyWith(
    _$IADLsImpl value,
    $Res Function(_$IADLsImpl) then,
  ) = __$$IADLsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'managing_finances') int managingFinances,
    @JsonKey(name: 'handling_transportation') int handlingTransportation,
    int shopping,
    @JsonKey(name: 'preparing_meals') int preparingMeals,
    @JsonKey(name: 'using_telephone') int usingTelephone,
    @JsonKey(name: 'managing_medication') int managingMedication,
    int housekeeping,
  });
}

/// @nodoc
class __$$IADLsImplCopyWithImpl<$Res>
    extends _$IADLsCopyWithImpl<$Res, _$IADLsImpl>
    implements _$$IADLsImplCopyWith<$Res> {
  __$$IADLsImplCopyWithImpl(
    _$IADLsImpl _value,
    $Res Function(_$IADLsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of IADLs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? managingFinances = null,
    Object? handlingTransportation = null,
    Object? shopping = null,
    Object? preparingMeals = null,
    Object? usingTelephone = null,
    Object? managingMedication = null,
    Object? housekeeping = null,
  }) {
    return _then(
      _$IADLsImpl(
        managingFinances: null == managingFinances
            ? _value.managingFinances
            : managingFinances // ignore: cast_nullable_to_non_nullable
                  as int,
        handlingTransportation: null == handlingTransportation
            ? _value.handlingTransportation
            : handlingTransportation // ignore: cast_nullable_to_non_nullable
                  as int,
        shopping: null == shopping
            ? _value.shopping
            : shopping // ignore: cast_nullable_to_non_nullable
                  as int,
        preparingMeals: null == preparingMeals
            ? _value.preparingMeals
            : preparingMeals // ignore: cast_nullable_to_non_nullable
                  as int,
        usingTelephone: null == usingTelephone
            ? _value.usingTelephone
            : usingTelephone // ignore: cast_nullable_to_non_nullable
                  as int,
        managingMedication: null == managingMedication
            ? _value.managingMedication
            : managingMedication // ignore: cast_nullable_to_non_nullable
                  as int,
        housekeeping: null == housekeeping
            ? _value.housekeeping
            : housekeeping // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$IADLsImpl implements _IADLs {
  const _$IADLsImpl({
    @JsonKey(name: 'managing_finances') this.managingFinances = 2,
    @JsonKey(name: 'handling_transportation') this.handlingTransportation = 2,
    this.shopping = 2,
    @JsonKey(name: 'preparing_meals') this.preparingMeals = 2,
    @JsonKey(name: 'using_telephone') this.usingTelephone = 2,
    @JsonKey(name: 'managing_medication') this.managingMedication = 2,
    this.housekeeping = 2,
  });

  factory _$IADLsImpl.fromJson(Map<String, dynamic> json) =>
      _$$IADLsImplFromJson(json);

  @override
  @JsonKey(name: 'managing_finances')
  final int managingFinances;
  @override
  @JsonKey(name: 'handling_transportation')
  final int handlingTransportation;
  @override
  @JsonKey()
  final int shopping;
  @override
  @JsonKey(name: 'preparing_meals')
  final int preparingMeals;
  @override
  @JsonKey(name: 'using_telephone')
  final int usingTelephone;
  @override
  @JsonKey(name: 'managing_medication')
  final int managingMedication;
  @override
  @JsonKey()
  final int housekeeping;

  @override
  String toString() {
    return 'IADLs(managingFinances: $managingFinances, handlingTransportation: $handlingTransportation, shopping: $shopping, preparingMeals: $preparingMeals, usingTelephone: $usingTelephone, managingMedication: $managingMedication, housekeeping: $housekeeping)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IADLsImpl &&
            (identical(other.managingFinances, managingFinances) ||
                other.managingFinances == managingFinances) &&
            (identical(other.handlingTransportation, handlingTransportation) ||
                other.handlingTransportation == handlingTransportation) &&
            (identical(other.shopping, shopping) ||
                other.shopping == shopping) &&
            (identical(other.preparingMeals, preparingMeals) ||
                other.preparingMeals == preparingMeals) &&
            (identical(other.usingTelephone, usingTelephone) ||
                other.usingTelephone == usingTelephone) &&
            (identical(other.managingMedication, managingMedication) ||
                other.managingMedication == managingMedication) &&
            (identical(other.housekeeping, housekeeping) ||
                other.housekeeping == housekeeping));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    managingFinances,
    handlingTransportation,
    shopping,
    preparingMeals,
    usingTelephone,
    managingMedication,
    housekeeping,
  );

  /// Create a copy of IADLs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$IADLsImplCopyWith<_$IADLsImpl> get copyWith =>
      __$$IADLsImplCopyWithImpl<_$IADLsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IADLsImplToJson(this);
  }
}

abstract class _IADLs implements IADLs {
  const factory _IADLs({
    @JsonKey(name: 'managing_finances') final int managingFinances,
    @JsonKey(name: 'handling_transportation') final int handlingTransportation,
    final int shopping,
    @JsonKey(name: 'preparing_meals') final int preparingMeals,
    @JsonKey(name: 'using_telephone') final int usingTelephone,
    @JsonKey(name: 'managing_medication') final int managingMedication,
    final int housekeeping,
  }) = _$IADLsImpl;

  factory _IADLs.fromJson(Map<String, dynamic> json) = _$IADLsImpl.fromJson;

  @override
  @JsonKey(name: 'managing_finances')
  int get managingFinances;
  @override
  @JsonKey(name: 'handling_transportation')
  int get handlingTransportation;
  @override
  int get shopping;
  @override
  @JsonKey(name: 'preparing_meals')
  int get preparingMeals;
  @override
  @JsonKey(name: 'using_telephone')
  int get usingTelephone;
  @override
  @JsonKey(name: 'managing_medication')
  int get managingMedication;
  @override
  int get housekeeping;

  /// Create a copy of IADLs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$IADLsImplCopyWith<_$IADLsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InputsCT _$InputsCTFromJson(Map<String, dynamic> json) {
  return _InputsCT.fromJson(json);
}

/// @nodoc
mixin _$InputsCT {
  @JsonKey(name: 'coverage_days_per_week')
  int get coverageDaysPerWeek => throw _privateConstructorUsedError;
  @JsonKey(name: 'reliability_percent')
  double get reliabilityPercent => throw _privateConstructorUsedError;
  @JsonKey(name: 'continuity_percent')
  double get continuityPercent => throw _privateConstructorUsedError;
  Coordination get coordination => throw _privateConstructorUsedError;

  /// Serializes this InputsCT to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InputsCT
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InputsCTCopyWith<InputsCT> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputsCTCopyWith<$Res> {
  factory $InputsCTCopyWith(InputsCT value, $Res Function(InputsCT) then) =
      _$InputsCTCopyWithImpl<$Res, InputsCT>;
  @useResult
  $Res call({
    @JsonKey(name: 'coverage_days_per_week') int coverageDaysPerWeek,
    @JsonKey(name: 'reliability_percent') double reliabilityPercent,
    @JsonKey(name: 'continuity_percent') double continuityPercent,
    Coordination coordination,
  });

  $CoordinationCopyWith<$Res> get coordination;
}

/// @nodoc
class _$InputsCTCopyWithImpl<$Res, $Val extends InputsCT>
    implements $InputsCTCopyWith<$Res> {
  _$InputsCTCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InputsCT
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverageDaysPerWeek = null,
    Object? reliabilityPercent = null,
    Object? continuityPercent = null,
    Object? coordination = null,
  }) {
    return _then(
      _value.copyWith(
            coverageDaysPerWeek: null == coverageDaysPerWeek
                ? _value.coverageDaysPerWeek
                : coverageDaysPerWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            reliabilityPercent: null == reliabilityPercent
                ? _value.reliabilityPercent
                : reliabilityPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            continuityPercent: null == continuityPercent
                ? _value.continuityPercent
                : continuityPercent // ignore: cast_nullable_to_non_nullable
                      as double,
            coordination: null == coordination
                ? _value.coordination
                : coordination // ignore: cast_nullable_to_non_nullable
                      as Coordination,
          )
          as $Val,
    );
  }

  /// Create a copy of InputsCT
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CoordinationCopyWith<$Res> get coordination {
    return $CoordinationCopyWith<$Res>(_value.coordination, (value) {
      return _then(_value.copyWith(coordination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$InputsCTImplCopyWith<$Res>
    implements $InputsCTCopyWith<$Res> {
  factory _$$InputsCTImplCopyWith(
    _$InputsCTImpl value,
    $Res Function(_$InputsCTImpl) then,
  ) = __$$InputsCTImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'coverage_days_per_week') int coverageDaysPerWeek,
    @JsonKey(name: 'reliability_percent') double reliabilityPercent,
    @JsonKey(name: 'continuity_percent') double continuityPercent,
    Coordination coordination,
  });

  @override
  $CoordinationCopyWith<$Res> get coordination;
}

/// @nodoc
class __$$InputsCTImplCopyWithImpl<$Res>
    extends _$InputsCTCopyWithImpl<$Res, _$InputsCTImpl>
    implements _$$InputsCTImplCopyWith<$Res> {
  __$$InputsCTImplCopyWithImpl(
    _$InputsCTImpl _value,
    $Res Function(_$InputsCTImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InputsCT
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coverageDaysPerWeek = null,
    Object? reliabilityPercent = null,
    Object? continuityPercent = null,
    Object? coordination = null,
  }) {
    return _then(
      _$InputsCTImpl(
        coverageDaysPerWeek: null == coverageDaysPerWeek
            ? _value.coverageDaysPerWeek
            : coverageDaysPerWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        reliabilityPercent: null == reliabilityPercent
            ? _value.reliabilityPercent
            : reliabilityPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        continuityPercent: null == continuityPercent
            ? _value.continuityPercent
            : continuityPercent // ignore: cast_nullable_to_non_nullable
                  as double,
        coordination: null == coordination
            ? _value.coordination
            : coordination // ignore: cast_nullable_to_non_nullable
                  as Coordination,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InputsCTImpl implements _InputsCT {
  const _$InputsCTImpl({
    @JsonKey(name: 'coverage_days_per_week') this.coverageDaysPerWeek = 7,
    @JsonKey(name: 'reliability_percent') this.reliabilityPercent = 100.0,
    @JsonKey(name: 'continuity_percent') this.continuityPercent = 100.0,
    this.coordination = const Coordination(),
  });

  factory _$InputsCTImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputsCTImplFromJson(json);

  @override
  @JsonKey(name: 'coverage_days_per_week')
  final int coverageDaysPerWeek;
  @override
  @JsonKey(name: 'reliability_percent')
  final double reliabilityPercent;
  @override
  @JsonKey(name: 'continuity_percent')
  final double continuityPercent;
  @override
  @JsonKey()
  final Coordination coordination;

  @override
  String toString() {
    return 'InputsCT(coverageDaysPerWeek: $coverageDaysPerWeek, reliabilityPercent: $reliabilityPercent, continuityPercent: $continuityPercent, coordination: $coordination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputsCTImpl &&
            (identical(other.coverageDaysPerWeek, coverageDaysPerWeek) ||
                other.coverageDaysPerWeek == coverageDaysPerWeek) &&
            (identical(other.reliabilityPercent, reliabilityPercent) ||
                other.reliabilityPercent == reliabilityPercent) &&
            (identical(other.continuityPercent, continuityPercent) ||
                other.continuityPercent == continuityPercent) &&
            (identical(other.coordination, coordination) ||
                other.coordination == coordination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    coverageDaysPerWeek,
    reliabilityPercent,
    continuityPercent,
    coordination,
  );

  /// Create a copy of InputsCT
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputsCTImplCopyWith<_$InputsCTImpl> get copyWith =>
      __$$InputsCTImplCopyWithImpl<_$InputsCTImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputsCTImplToJson(this);
  }
}

abstract class _InputsCT implements InputsCT {
  const factory _InputsCT({
    @JsonKey(name: 'coverage_days_per_week') final int coverageDaysPerWeek,
    @JsonKey(name: 'reliability_percent') final double reliabilityPercent,
    @JsonKey(name: 'continuity_percent') final double continuityPercent,
    final Coordination coordination,
  }) = _$InputsCTImpl;

  factory _InputsCT.fromJson(Map<String, dynamic> json) =
      _$InputsCTImpl.fromJson;

  @override
  @JsonKey(name: 'coverage_days_per_week')
  int get coverageDaysPerWeek;
  @override
  @JsonKey(name: 'reliability_percent')
  double get reliabilityPercent;
  @override
  @JsonKey(name: 'continuity_percent')
  double get continuityPercent;
  @override
  Coordination get coordination;

  /// Create a copy of InputsCT
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputsCTImplCopyWith<_$InputsCTImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Coordination _$CoordinationFromJson(Map<String, dynamic> json) {
  return _Coordination.fromJson(json);
}

/// @nodoc
mixin _$Coordination {
  @JsonKey(name: 'careplan_up_to_date')
  bool get careplanUpToDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'communication_rating')
  int get communicationRating => throw _privateConstructorUsedError;

  /// Serializes this Coordination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Coordination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoordinationCopyWith<Coordination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoordinationCopyWith<$Res> {
  factory $CoordinationCopyWith(
    Coordination value,
    $Res Function(Coordination) then,
  ) = _$CoordinationCopyWithImpl<$Res, Coordination>;
  @useResult
  $Res call({
    @JsonKey(name: 'careplan_up_to_date') bool careplanUpToDate,
    @JsonKey(name: 'communication_rating') int communicationRating,
  });
}

/// @nodoc
class _$CoordinationCopyWithImpl<$Res, $Val extends Coordination>
    implements $CoordinationCopyWith<$Res> {
  _$CoordinationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Coordination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? careplanUpToDate = null,
    Object? communicationRating = null,
  }) {
    return _then(
      _value.copyWith(
            careplanUpToDate: null == careplanUpToDate
                ? _value.careplanUpToDate
                : careplanUpToDate // ignore: cast_nullable_to_non_nullable
                      as bool,
            communicationRating: null == communicationRating
                ? _value.communicationRating
                : communicationRating // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CoordinationImplCopyWith<$Res>
    implements $CoordinationCopyWith<$Res> {
  factory _$$CoordinationImplCopyWith(
    _$CoordinationImpl value,
    $Res Function(_$CoordinationImpl) then,
  ) = __$$CoordinationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'careplan_up_to_date') bool careplanUpToDate,
    @JsonKey(name: 'communication_rating') int communicationRating,
  });
}

/// @nodoc
class __$$CoordinationImplCopyWithImpl<$Res>
    extends _$CoordinationCopyWithImpl<$Res, _$CoordinationImpl>
    implements _$$CoordinationImplCopyWith<$Res> {
  __$$CoordinationImplCopyWithImpl(
    _$CoordinationImpl _value,
    $Res Function(_$CoordinationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Coordination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? careplanUpToDate = null,
    Object? communicationRating = null,
  }) {
    return _then(
      _$CoordinationImpl(
        careplanUpToDate: null == careplanUpToDate
            ? _value.careplanUpToDate
            : careplanUpToDate // ignore: cast_nullable_to_non_nullable
                  as bool,
        communicationRating: null == communicationRating
            ? _value.communicationRating
            : communicationRating // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CoordinationImpl implements _Coordination {
  const _$CoordinationImpl({
    @JsonKey(name: 'careplan_up_to_date') this.careplanUpToDate = true,
    @JsonKey(name: 'communication_rating') this.communicationRating = 5,
  });

  factory _$CoordinationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoordinationImplFromJson(json);

  @override
  @JsonKey(name: 'careplan_up_to_date')
  final bool careplanUpToDate;
  @override
  @JsonKey(name: 'communication_rating')
  final int communicationRating;

  @override
  String toString() {
    return 'Coordination(careplanUpToDate: $careplanUpToDate, communicationRating: $communicationRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoordinationImpl &&
            (identical(other.careplanUpToDate, careplanUpToDate) ||
                other.careplanUpToDate == careplanUpToDate) &&
            (identical(other.communicationRating, communicationRating) ||
                other.communicationRating == communicationRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, careplanUpToDate, communicationRating);

  /// Create a copy of Coordination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoordinationImplCopyWith<_$CoordinationImpl> get copyWith =>
      __$$CoordinationImplCopyWithImpl<_$CoordinationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoordinationImplToJson(this);
  }
}

abstract class _Coordination implements Coordination {
  const factory _Coordination({
    @JsonKey(name: 'careplan_up_to_date') final bool careplanUpToDate,
    @JsonKey(name: 'communication_rating') final int communicationRating,
  }) = _$CoordinationImpl;

  factory _Coordination.fromJson(Map<String, dynamic> json) =
      _$CoordinationImpl.fromJson;

  @override
  @JsonKey(name: 'careplan_up_to_date')
  bool get careplanUpToDate;
  @override
  @JsonKey(name: 'communication_rating')
  int get communicationRating;

  /// Create a copy of Coordination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoordinationImplCopyWith<_$CoordinationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

InputsES _$InputsESFromJson(Map<String, dynamic> json) {
  return _InputsES.fromJson(json);
}

/// @nodoc
mixin _$InputsES {
  @JsonKey(name: 'fall_hazards_level')
  int get fallHazardsLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'bathroom_safety_level')
  int get bathroomSafetyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'kitchen_safety_level')
  int get kitchenSafetyLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'home_layout_level')
  int get homeLayoutLevel => throw _privateConstructorUsedError;

  /// Serializes this InputsES to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InputsES
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InputsESCopyWith<InputsES> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InputsESCopyWith<$Res> {
  factory $InputsESCopyWith(InputsES value, $Res Function(InputsES) then) =
      _$InputsESCopyWithImpl<$Res, InputsES>;
  @useResult
  $Res call({
    @JsonKey(name: 'fall_hazards_level') int fallHazardsLevel,
    @JsonKey(name: 'bathroom_safety_level') int bathroomSafetyLevel,
    @JsonKey(name: 'kitchen_safety_level') int kitchenSafetyLevel,
    @JsonKey(name: 'home_layout_level') int homeLayoutLevel,
  });
}

/// @nodoc
class _$InputsESCopyWithImpl<$Res, $Val extends InputsES>
    implements $InputsESCopyWith<$Res> {
  _$InputsESCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InputsES
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fallHazardsLevel = null,
    Object? bathroomSafetyLevel = null,
    Object? kitchenSafetyLevel = null,
    Object? homeLayoutLevel = null,
  }) {
    return _then(
      _value.copyWith(
            fallHazardsLevel: null == fallHazardsLevel
                ? _value.fallHazardsLevel
                : fallHazardsLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            bathroomSafetyLevel: null == bathroomSafetyLevel
                ? _value.bathroomSafetyLevel
                : bathroomSafetyLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            kitchenSafetyLevel: null == kitchenSafetyLevel
                ? _value.kitchenSafetyLevel
                : kitchenSafetyLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            homeLayoutLevel: null == homeLayoutLevel
                ? _value.homeLayoutLevel
                : homeLayoutLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InputsESImplCopyWith<$Res>
    implements $InputsESCopyWith<$Res> {
  factory _$$InputsESImplCopyWith(
    _$InputsESImpl value,
    $Res Function(_$InputsESImpl) then,
  ) = __$$InputsESImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'fall_hazards_level') int fallHazardsLevel,
    @JsonKey(name: 'bathroom_safety_level') int bathroomSafetyLevel,
    @JsonKey(name: 'kitchen_safety_level') int kitchenSafetyLevel,
    @JsonKey(name: 'home_layout_level') int homeLayoutLevel,
  });
}

/// @nodoc
class __$$InputsESImplCopyWithImpl<$Res>
    extends _$InputsESCopyWithImpl<$Res, _$InputsESImpl>
    implements _$$InputsESImplCopyWith<$Res> {
  __$$InputsESImplCopyWithImpl(
    _$InputsESImpl _value,
    $Res Function(_$InputsESImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InputsES
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fallHazardsLevel = null,
    Object? bathroomSafetyLevel = null,
    Object? kitchenSafetyLevel = null,
    Object? homeLayoutLevel = null,
  }) {
    return _then(
      _$InputsESImpl(
        fallHazardsLevel: null == fallHazardsLevel
            ? _value.fallHazardsLevel
            : fallHazardsLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        bathroomSafetyLevel: null == bathroomSafetyLevel
            ? _value.bathroomSafetyLevel
            : bathroomSafetyLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        kitchenSafetyLevel: null == kitchenSafetyLevel
            ? _value.kitchenSafetyLevel
            : kitchenSafetyLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        homeLayoutLevel: null == homeLayoutLevel
            ? _value.homeLayoutLevel
            : homeLayoutLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InputsESImpl implements _InputsES {
  const _$InputsESImpl({
    @JsonKey(name: 'fall_hazards_level') this.fallHazardsLevel = 4,
    @JsonKey(name: 'bathroom_safety_level') this.bathroomSafetyLevel = 4,
    @JsonKey(name: 'kitchen_safety_level') this.kitchenSafetyLevel = 4,
    @JsonKey(name: 'home_layout_level') this.homeLayoutLevel = 4,
  });

  factory _$InputsESImpl.fromJson(Map<String, dynamic> json) =>
      _$$InputsESImplFromJson(json);

  @override
  @JsonKey(name: 'fall_hazards_level')
  final int fallHazardsLevel;
  @override
  @JsonKey(name: 'bathroom_safety_level')
  final int bathroomSafetyLevel;
  @override
  @JsonKey(name: 'kitchen_safety_level')
  final int kitchenSafetyLevel;
  @override
  @JsonKey(name: 'home_layout_level')
  final int homeLayoutLevel;

  @override
  String toString() {
    return 'InputsES(fallHazardsLevel: $fallHazardsLevel, bathroomSafetyLevel: $bathroomSafetyLevel, kitchenSafetyLevel: $kitchenSafetyLevel, homeLayoutLevel: $homeLayoutLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InputsESImpl &&
            (identical(other.fallHazardsLevel, fallHazardsLevel) ||
                other.fallHazardsLevel == fallHazardsLevel) &&
            (identical(other.bathroomSafetyLevel, bathroomSafetyLevel) ||
                other.bathroomSafetyLevel == bathroomSafetyLevel) &&
            (identical(other.kitchenSafetyLevel, kitchenSafetyLevel) ||
                other.kitchenSafetyLevel == kitchenSafetyLevel) &&
            (identical(other.homeLayoutLevel, homeLayoutLevel) ||
                other.homeLayoutLevel == homeLayoutLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fallHazardsLevel,
    bathroomSafetyLevel,
    kitchenSafetyLevel,
    homeLayoutLevel,
  );

  /// Create a copy of InputsES
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InputsESImplCopyWith<_$InputsESImpl> get copyWith =>
      __$$InputsESImplCopyWithImpl<_$InputsESImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InputsESImplToJson(this);
  }
}

abstract class _InputsES implements InputsES {
  const factory _InputsES({
    @JsonKey(name: 'fall_hazards_level') final int fallHazardsLevel,
    @JsonKey(name: 'bathroom_safety_level') final int bathroomSafetyLevel,
    @JsonKey(name: 'kitchen_safety_level') final int kitchenSafetyLevel,
    @JsonKey(name: 'home_layout_level') final int homeLayoutLevel,
  }) = _$InputsESImpl;

  factory _InputsES.fromJson(Map<String, dynamic> json) =
      _$InputsESImpl.fromJson;

  @override
  @JsonKey(name: 'fall_hazards_level')
  int get fallHazardsLevel;
  @override
  @JsonKey(name: 'bathroom_safety_level')
  int get bathroomSafetyLevel;
  @override
  @JsonKey(name: 'kitchen_safety_level')
  int get kitchenSafetyLevel;
  @override
  @JsonKey(name: 'home_layout_level')
  int get homeLayoutLevel;

  /// Create a copy of InputsES
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InputsESImplCopyWith<_$InputsESImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CalculatedResults _$CalculatedResultsFromJson(Map<String, dynamic> json) {
  return _CalculatedResults.fromJson(json);
}

/// @nodoc
mixin _$CalculatedResults {
  @JsonKey(name: 'score_fwb')
  double get scoreFwb => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_ct')
  double get scoreCt => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_es')
  double get scoreEs => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_ics')
  double get scoreIcs => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_bls')
  double get scoreBls => throw _privateConstructorUsedError;
  @JsonKey(name: 'score_final_aip')
  double get scoreFinalAip => throw _privateConstructorUsedError;

  /// Serializes this CalculatedResults to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CalculatedResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CalculatedResultsCopyWith<CalculatedResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalculatedResultsCopyWith<$Res> {
  factory $CalculatedResultsCopyWith(
    CalculatedResults value,
    $Res Function(CalculatedResults) then,
  ) = _$CalculatedResultsCopyWithImpl<$Res, CalculatedResults>;
  @useResult
  $Res call({
    @JsonKey(name: 'score_fwb') double scoreFwb,
    @JsonKey(name: 'score_ct') double scoreCt,
    @JsonKey(name: 'score_es') double scoreEs,
    @JsonKey(name: 'score_ics') double scoreIcs,
    @JsonKey(name: 'score_bls') double scoreBls,
    @JsonKey(name: 'score_final_aip') double scoreFinalAip,
  });
}

/// @nodoc
class _$CalculatedResultsCopyWithImpl<$Res, $Val extends CalculatedResults>
    implements $CalculatedResultsCopyWith<$Res> {
  _$CalculatedResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CalculatedResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scoreFwb = null,
    Object? scoreCt = null,
    Object? scoreEs = null,
    Object? scoreIcs = null,
    Object? scoreBls = null,
    Object? scoreFinalAip = null,
  }) {
    return _then(
      _value.copyWith(
            scoreFwb: null == scoreFwb
                ? _value.scoreFwb
                : scoreFwb // ignore: cast_nullable_to_non_nullable
                      as double,
            scoreCt: null == scoreCt
                ? _value.scoreCt
                : scoreCt // ignore: cast_nullable_to_non_nullable
                      as double,
            scoreEs: null == scoreEs
                ? _value.scoreEs
                : scoreEs // ignore: cast_nullable_to_non_nullable
                      as double,
            scoreIcs: null == scoreIcs
                ? _value.scoreIcs
                : scoreIcs // ignore: cast_nullable_to_non_nullable
                      as double,
            scoreBls: null == scoreBls
                ? _value.scoreBls
                : scoreBls // ignore: cast_nullable_to_non_nullable
                      as double,
            scoreFinalAip: null == scoreFinalAip
                ? _value.scoreFinalAip
                : scoreFinalAip // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CalculatedResultsImplCopyWith<$Res>
    implements $CalculatedResultsCopyWith<$Res> {
  factory _$$CalculatedResultsImplCopyWith(
    _$CalculatedResultsImpl value,
    $Res Function(_$CalculatedResultsImpl) then,
  ) = __$$CalculatedResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'score_fwb') double scoreFwb,
    @JsonKey(name: 'score_ct') double scoreCt,
    @JsonKey(name: 'score_es') double scoreEs,
    @JsonKey(name: 'score_ics') double scoreIcs,
    @JsonKey(name: 'score_bls') double scoreBls,
    @JsonKey(name: 'score_final_aip') double scoreFinalAip,
  });
}

/// @nodoc
class __$$CalculatedResultsImplCopyWithImpl<$Res>
    extends _$CalculatedResultsCopyWithImpl<$Res, _$CalculatedResultsImpl>
    implements _$$CalculatedResultsImplCopyWith<$Res> {
  __$$CalculatedResultsImplCopyWithImpl(
    _$CalculatedResultsImpl _value,
    $Res Function(_$CalculatedResultsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CalculatedResults
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scoreFwb = null,
    Object? scoreCt = null,
    Object? scoreEs = null,
    Object? scoreIcs = null,
    Object? scoreBls = null,
    Object? scoreFinalAip = null,
  }) {
    return _then(
      _$CalculatedResultsImpl(
        scoreFwb: null == scoreFwb
            ? _value.scoreFwb
            : scoreFwb // ignore: cast_nullable_to_non_nullable
                  as double,
        scoreCt: null == scoreCt
            ? _value.scoreCt
            : scoreCt // ignore: cast_nullable_to_non_nullable
                  as double,
        scoreEs: null == scoreEs
            ? _value.scoreEs
            : scoreEs // ignore: cast_nullable_to_non_nullable
                  as double,
        scoreIcs: null == scoreIcs
            ? _value.scoreIcs
            : scoreIcs // ignore: cast_nullable_to_non_nullable
                  as double,
        scoreBls: null == scoreBls
            ? _value.scoreBls
            : scoreBls // ignore: cast_nullable_to_non_nullable
                  as double,
        scoreFinalAip: null == scoreFinalAip
            ? _value.scoreFinalAip
            : scoreFinalAip // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CalculatedResultsImpl implements _CalculatedResults {
  const _$CalculatedResultsImpl({
    @JsonKey(name: 'score_fwb') this.scoreFwb = 100.0,
    @JsonKey(name: 'score_ct') this.scoreCt = 100.0,
    @JsonKey(name: 'score_es') this.scoreEs = 100.0,
    @JsonKey(name: 'score_ics') this.scoreIcs = 100.0,
    @JsonKey(name: 'score_bls') this.scoreBls = 100.0,
    @JsonKey(name: 'score_final_aip') this.scoreFinalAip = 100.0,
  });

  factory _$CalculatedResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalculatedResultsImplFromJson(json);

  @override
  @JsonKey(name: 'score_fwb')
  final double scoreFwb;
  @override
  @JsonKey(name: 'score_ct')
  final double scoreCt;
  @override
  @JsonKey(name: 'score_es')
  final double scoreEs;
  @override
  @JsonKey(name: 'score_ics')
  final double scoreIcs;
  @override
  @JsonKey(name: 'score_bls')
  final double scoreBls;
  @override
  @JsonKey(name: 'score_final_aip')
  final double scoreFinalAip;

  @override
  String toString() {
    return 'CalculatedResults(scoreFwb: $scoreFwb, scoreCt: $scoreCt, scoreEs: $scoreEs, scoreIcs: $scoreIcs, scoreBls: $scoreBls, scoreFinalAip: $scoreFinalAip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculatedResultsImpl &&
            (identical(other.scoreFwb, scoreFwb) ||
                other.scoreFwb == scoreFwb) &&
            (identical(other.scoreCt, scoreCt) || other.scoreCt == scoreCt) &&
            (identical(other.scoreEs, scoreEs) || other.scoreEs == scoreEs) &&
            (identical(other.scoreIcs, scoreIcs) ||
                other.scoreIcs == scoreIcs) &&
            (identical(other.scoreBls, scoreBls) ||
                other.scoreBls == scoreBls) &&
            (identical(other.scoreFinalAip, scoreFinalAip) ||
                other.scoreFinalAip == scoreFinalAip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    scoreFwb,
    scoreCt,
    scoreEs,
    scoreIcs,
    scoreBls,
    scoreFinalAip,
  );

  /// Create a copy of CalculatedResults
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculatedResultsImplCopyWith<_$CalculatedResultsImpl> get copyWith =>
      __$$CalculatedResultsImplCopyWithImpl<_$CalculatedResultsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CalculatedResultsImplToJson(this);
  }
}

abstract class _CalculatedResults implements CalculatedResults {
  const factory _CalculatedResults({
    @JsonKey(name: 'score_fwb') final double scoreFwb,
    @JsonKey(name: 'score_ct') final double scoreCt,
    @JsonKey(name: 'score_es') final double scoreEs,
    @JsonKey(name: 'score_ics') final double scoreIcs,
    @JsonKey(name: 'score_bls') final double scoreBls,
    @JsonKey(name: 'score_final_aip') final double scoreFinalAip,
  }) = _$CalculatedResultsImpl;

  factory _CalculatedResults.fromJson(Map<String, dynamic> json) =
      _$CalculatedResultsImpl.fromJson;

  @override
  @JsonKey(name: 'score_fwb')
  double get scoreFwb;
  @override
  @JsonKey(name: 'score_ct')
  double get scoreCt;
  @override
  @JsonKey(name: 'score_es')
  double get scoreEs;
  @override
  @JsonKey(name: 'score_ics')
  double get scoreIcs;
  @override
  @JsonKey(name: 'score_bls')
  double get scoreBls;
  @override
  @JsonKey(name: 'score_final_aip')
  double get scoreFinalAip;

  /// Create a copy of CalculatedResults
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculatedResultsImplCopyWith<_$CalculatedResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
