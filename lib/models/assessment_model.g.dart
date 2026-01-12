// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AssessmentModelImpl _$$AssessmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AssessmentModelImpl(
  metadata: AssessmentMetadata.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
  inputsFwb: InputsFWB.fromJson(json['inputs_fwb'] as Map<String, dynamic>),
  inputsCt: InputsCT.fromJson(json['inputs_ct'] as Map<String, dynamic>),
  inputsEs: InputsES.fromJson(json['inputs_es'] as Map<String, dynamic>),
  calculatedResults: CalculatedResults.fromJson(
    json['calculated_results'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$$AssessmentModelImplToJson(
  _$AssessmentModelImpl instance,
) => <String, dynamic>{
  'metadata': instance.metadata.toJson(),
  'inputs_fwb': instance.inputsFwb.toJson(),
  'inputs_ct': instance.inputsCt.toJson(),
  'inputs_es': instance.inputsEs.toJson(),
  'calculated_results': instance.calculatedResults.toJson(),
};

_$AssessmentMetadataImpl _$$AssessmentMetadataImplFromJson(
  Map<String, dynamic> json,
) => _$AssessmentMetadataImpl(
  assessmentId: json['assessment_id'] as String,
  seniorId: json['senior_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  createdBy: json['created_by'] as String?,
  subjectName: json['subject_name'] as String?,
  subjectAge: (json['subject_age'] as num?)?.toInt(),
  subjectGender: json['subject_gender'] as String?,
  livingSituation: json['living_situation'] as String?,
);

Map<String, dynamic> _$$AssessmentMetadataImplToJson(
  _$AssessmentMetadataImpl instance,
) => <String, dynamic>{
  'assessment_id': instance.assessmentId,
  'senior_id': instance.seniorId,
  'created_at': instance.createdAt.toIso8601String(),
  'created_by': instance.createdBy,
  'subject_name': instance.subjectName,
  'subject_age': instance.subjectAge,
  'subject_gender': instance.subjectGender,
  'living_situation': instance.livingSituation,
};

_$InputsFWBImpl _$$InputsFWBImplFromJson(Map<String, dynamic> json) =>
    _$InputsFWBImpl(
      adls: json['adls'] == null
          ? const ADLs()
          : ADLs.fromJson(json['adls'] as Map<String, dynamic>),
      iadls: json['iadls'] == null
          ? const IADLs()
          : IADLs.fromJson(json['iadls'] as Map<String, dynamic>),
      gaitSpeedScore: (json['gait_speed_score'] as num?)?.toInt() ?? 5,
      mobilityDeviceScore:
          (json['mobility_device_score'] as num?)?.toInt() ?? 4,
      gripStrengthScore: (json['grip_strength_score'] as num?)?.toInt() ?? 4,
      fallsHistoryScore: (json['falls_history_score'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$InputsFWBImplToJson(_$InputsFWBImpl instance) =>
    <String, dynamic>{
      'adls': instance.adls.toJson(),
      'iadls': instance.iadls.toJson(),
      'gait_speed_score': instance.gaitSpeedScore,
      'mobility_device_score': instance.mobilityDeviceScore,
      'grip_strength_score': instance.gripStrengthScore,
      'falls_history_score': instance.fallsHistoryScore,
    };

_$ADLsImpl _$$ADLsImplFromJson(Map<String, dynamic> json) => _$ADLsImpl(
  bathing: (json['bathing'] as num?)?.toInt() ?? 2,
  dressing: (json['dressing'] as num?)?.toInt() ?? 2,
  toileting: (json['toileting'] as num?)?.toInt() ?? 2,
  transferring: (json['transferring'] as num?)?.toInt() ?? 2,
  continence: (json['continence'] as num?)?.toInt() ?? 2,
  feeding: (json['feeding'] as num?)?.toInt() ?? 2,
);

Map<String, dynamic> _$$ADLsImplToJson(_$ADLsImpl instance) =>
    <String, dynamic>{
      'bathing': instance.bathing,
      'dressing': instance.dressing,
      'toileting': instance.toileting,
      'transferring': instance.transferring,
      'continence': instance.continence,
      'feeding': instance.feeding,
    };

_$IADLsImpl _$$IADLsImplFromJson(Map<String, dynamic> json) => _$IADLsImpl(
  managingFinances: (json['managing_finances'] as num?)?.toInt() ?? 2,
  handlingTransportation:
      (json['handling_transportation'] as num?)?.toInt() ?? 2,
  shopping: (json['shopping'] as num?)?.toInt() ?? 2,
  preparingMeals: (json['preparing_meals'] as num?)?.toInt() ?? 2,
  usingTelephone: (json['using_telephone'] as num?)?.toInt() ?? 2,
  managingMedication: (json['managing_medication'] as num?)?.toInt() ?? 2,
  housekeeping: (json['housekeeping'] as num?)?.toInt() ?? 2,
);

Map<String, dynamic> _$$IADLsImplToJson(_$IADLsImpl instance) =>
    <String, dynamic>{
      'managing_finances': instance.managingFinances,
      'handling_transportation': instance.handlingTransportation,
      'shopping': instance.shopping,
      'preparing_meals': instance.preparingMeals,
      'using_telephone': instance.usingTelephone,
      'managing_medication': instance.managingMedication,
      'housekeeping': instance.housekeeping,
    };

_$InputsCTImpl _$$InputsCTImplFromJson(
  Map<String, dynamic> json,
) => _$InputsCTImpl(
  coverageDaysPerWeek: (json['coverage_days_per_week'] as num?)?.toInt() ?? 7,
  reliabilityPercent:
      (json['reliability_percent'] as num?)?.toDouble() ?? 100.0,
  continuityPercent: (json['continuity_percent'] as num?)?.toDouble() ?? 100.0,
  coordination: json['coordination'] == null
      ? const Coordination()
      : Coordination.fromJson(json['coordination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$InputsCTImplToJson(_$InputsCTImpl instance) =>
    <String, dynamic>{
      'coverage_days_per_week': instance.coverageDaysPerWeek,
      'reliability_percent': instance.reliabilityPercent,
      'continuity_percent': instance.continuityPercent,
      'coordination': instance.coordination.toJson(),
    };

_$CoordinationImpl _$$CoordinationImplFromJson(Map<String, dynamic> json) =>
    _$CoordinationImpl(
      careplanUpToDate: json['careplan_up_to_date'] as bool? ?? true,
      communicationRating: (json['communication_rating'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$$CoordinationImplToJson(_$CoordinationImpl instance) =>
    <String, dynamic>{
      'careplan_up_to_date': instance.careplanUpToDate,
      'communication_rating': instance.communicationRating,
    };

_$InputsESImpl _$$InputsESImplFromJson(Map<String, dynamic> json) =>
    _$InputsESImpl(
      fallHazardsLevel: (json['fall_hazards_level'] as num?)?.toInt() ?? 4,
      bathroomSafetyLevel:
          (json['bathroom_safety_level'] as num?)?.toInt() ?? 4,
      kitchenSafetyLevel: (json['kitchen_safety_level'] as num?)?.toInt() ?? 4,
      homeLayoutLevel: (json['home_layout_level'] as num?)?.toInt() ?? 4,
    );

Map<String, dynamic> _$$InputsESImplToJson(_$InputsESImpl instance) =>
    <String, dynamic>{
      'fall_hazards_level': instance.fallHazardsLevel,
      'bathroom_safety_level': instance.bathroomSafetyLevel,
      'kitchen_safety_level': instance.kitchenSafetyLevel,
      'home_layout_level': instance.homeLayoutLevel,
    };

_$CalculatedResultsImpl _$$CalculatedResultsImplFromJson(
  Map<String, dynamic> json,
) => _$CalculatedResultsImpl(
  scoreFwb: (json['score_fwb'] as num?)?.toDouble() ?? 100.0,
  scoreCt: (json['score_ct'] as num?)?.toDouble() ?? 100.0,
  scoreEs: (json['score_es'] as num?)?.toDouble() ?? 100.0,
  scoreIcs: (json['score_ics'] as num?)?.toDouble() ?? 100.0,
  scoreBls: (json['score_bls'] as num?)?.toDouble() ?? 100.0,
  scoreFinalAip: (json['score_final_aip'] as num?)?.toDouble() ?? 100.0,
);

Map<String, dynamic> _$$CalculatedResultsImplToJson(
  _$CalculatedResultsImpl instance,
) => <String, dynamic>{
  'score_fwb': instance.scoreFwb,
  'score_ct': instance.scoreCt,
  'score_es': instance.scoreEs,
  'score_ics': instance.scoreIcs,
  'score_bls': instance.scoreBls,
  'score_final_aip': instance.scoreFinalAip,
};
