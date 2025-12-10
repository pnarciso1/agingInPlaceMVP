import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment_model.freezed.dart';
part 'assessment_model.g.dart';

@freezed
class AssessmentModel with _$AssessmentModel {
  const factory AssessmentModel({
    required AssessmentMetadata metadata,
    @JsonKey(name: 'inputs_fwb') required InputsFWB inputsFwb,
    @JsonKey(name: 'inputs_ct') required InputsCT inputsCt,
    @JsonKey(name: 'inputs_es') required InputsES inputsEs,
    @JsonKey(name: 'calculated_results') required CalculatedResults calculatedResults,
  }) = _AssessmentModel;

  factory AssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$AssessmentModelFromJson(json);
}

@freezed
class AssessmentMetadata with _$AssessmentMetadata {
  const factory AssessmentMetadata({
    @JsonKey(name: 'assessment_id') required String assessmentId,
    @JsonKey(name: 'senior_id') required String seniorId,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    // Humanizing fields
    @JsonKey(name: 'subject_name') String? subjectName,
    @JsonKey(name: 'subject_age') int? subjectAge,
    @JsonKey(name: 'subject_gender') String? subjectGender,
    @JsonKey(name: 'living_situation') String? livingSituation,
  }) = _AssessmentMetadata;

  factory AssessmentMetadata.fromJson(Map<String, dynamic> json) =>
      _$AssessmentMetadataFromJson(json);
}

@freezed
class InputsFWB with _$InputsFWB {
  const factory InputsFWB({
    @Default(ADLs()) ADLs adls,
    @Default(IADLs()) IADLs iadls,
    @JsonKey(name: 'gait_speed_score') @Default(5) int gaitSpeedScore,
    @JsonKey(name: 'mobility_device_score') @Default(4) int mobilityDeviceScore,
    @JsonKey(name: 'grip_strength_score') @Default(4) int gripStrengthScore,
    @JsonKey(name: 'falls_history_score') @Default(3) int fallsHistoryScore,
  }) = _InputsFWB;

  factory InputsFWB.fromJson(Map<String, dynamic> json) =>
      _$InputsFWBFromJson(json);
}

@freezed
class ADLs with _$ADLs {
  const factory ADLs({
    @Default(2) int bathing,
    @Default(2) int dressing,
    @Default(2) int toileting,
    @Default(2) int transferring,
    @Default(2) int continence,
    @Default(2) int feeding,
  }) = _ADLs;

  factory ADLs.fromJson(Map<String, dynamic> json) => _$ADLsFromJson(json);
}

@freezed
class IADLs with _$IADLs {
  const factory IADLs({
    @JsonKey(name: 'managing_finances') @Default(2) int managingFinances,
    @JsonKey(name: 'handling_transportation') @Default(2) int handlingTransportation,
    @Default(2) int shopping,
    @JsonKey(name: 'preparing_meals') @Default(2) int preparingMeals,
    @JsonKey(name: 'using_telephone') @Default(2) int usingTelephone,
    @JsonKey(name: 'managing_medication') @Default(2) int managingMedication,
    @Default(2) int housekeeping,
  }) = _IADLs;

  factory IADLs.fromJson(Map<String, dynamic> json) => _$IADLsFromJson(json);
}

@freezed
class InputsCT with _$InputsCT {
  const factory InputsCT({
    @JsonKey(name: 'coverage_days_per_week') @Default(7) int coverageDaysPerWeek,
    @JsonKey(name: 'reliability_percent') @Default(100.0) double reliabilityPercent,
    @JsonKey(name: 'continuity_percent') @Default(100.0) double continuityPercent,
    @Default(Coordination()) Coordination coordination,
  }) = _InputsCT;

  factory InputsCT.fromJson(Map<String, dynamic> json) =>
      _$InputsCTFromJson(json);
}

@freezed
class Coordination with _$Coordination {
  const factory Coordination({
    @JsonKey(name: 'careplan_up_to_date') @Default(true) bool careplanUpToDate,
    @JsonKey(name: 'communication_rating') @Default(5) int communicationRating,
  }) = _Coordination;

  factory Coordination.fromJson(Map<String, dynamic> json) =>
      _$CoordinationFromJson(json);
}

@freezed
class InputsES with _$InputsES {
  const factory InputsES({
    @JsonKey(name: 'fall_hazards_level') @Default(4) int fallHazardsLevel,
    @JsonKey(name: 'bathroom_safety_level') @Default(4) int bathroomSafetyLevel,
    @JsonKey(name: 'kitchen_safety_level') @Default(4) int kitchenSafetyLevel,
    @JsonKey(name: 'home_layout_level') @Default(4) int homeLayoutLevel,
  }) = _InputsES;

  factory InputsES.fromJson(Map<String, dynamic> json) =>
      _$InputsESFromJson(json);
}

@freezed
class CalculatedResults with _$CalculatedResults {
  const factory CalculatedResults({
    @JsonKey(name: 'score_fwb') @Default(100.0) double scoreFwb,
    @JsonKey(name: 'score_ct') @Default(100.0) double scoreCt,
    @JsonKey(name: 'score_es') @Default(100.0) double scoreEs,
    @JsonKey(name: 'score_ics') @Default(100.0) double scoreIcs,
    @JsonKey(name: 'score_bls') @Default(100.0) double scoreBls,
    @JsonKey(name: 'score_final_aip') @Default(100.0) double scoreFinalAip,
  }) = _CalculatedResults;

  factory CalculatedResults.fromJson(Map<String, dynamic> json) =>
      _$CalculatedResultsFromJson(json);
}
