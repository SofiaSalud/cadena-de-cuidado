CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.chronic_services_events_diseases_socios` AS 

WITH
	icd_10_with_class_db AS (
		SELECT
			icd_10.id AS cie_10_code,
			icd_10.letter AS cie_10_letter,
			icd_10.grouping AS cie_10_grouping,
			icd_10.description AS cie_10_description,
			CASE  
				WHEN avg_duration_time_days IS NULL AND ABS(acute_probability - chronic_probability) > 0.4 THEN FALSE
				ELSE TRUE
			END AS is_acute
		FROM
			`sofia-data-305018.common_20240702.icd_10` AS icd_10
		LEFT JOIN
			`sofia-data-305018.cadena_cuidado.icd_10_with_class_and_time` AS icd_10_with_class
		ON icd_10.id = icd_10_with_class.cie_10_code
	),
  base AS (
		SELECT DISTINCT
			sed.member_id,
			sed.service_id,

			sed.case_event_id,
			sed.disease_case_id,

			services_related_service_id,
			services_health_plan_id,

      services_cpt,
			services_diagnosis_icd,
			services_provided_by_object_id,
			services_provided_by_content_type_id,
			
			disease_origin_diagnosis_icd,

			caseeventfinalletterdata_cie_codes,
			caseeventfinalletterdata_cie_descriptions,
			caseeventfinalletterdata_cpt_codes,
			caseeventfinalletterdata_cpt_descriptions,
			caseeventfinalletterdata_observations,

			diseasecase_medical_description,
			diseasecase_description,

			services_diagnosis_description,
			services_service_description,
			services_specification,

			services_medical_recommendation_notes,
			caseevent_discharge_ruling_notes,
			caseevent_administrative_ruling_notes,
			caseevent_description,
			caseevent_medical_pre_dictamination_notes,
			caseevent_internal_notes,
			caseevent_requested_partner_doctor_info,
			caseevent_relevant_history,    
			caseevent_discharge_reason,
			caseevent_quote_and_scheduling_ruling_notes,
			caseevent_medical_procedure_ruling_notes,

			services_created_date,
			services_occurrence_date,
			servicecomment_created_date,
			caseevent_created_date,
			eventcomment_created_date,
			caseeventsummary_created_date,
			caseeventfinalletterdata_created_date,
			caseevent_occurrence_date,
			caseevent_pause_start_date,
			diseasecase_created_date,

			caseevent_state,
			caseevent_step,
			caseevent_medically_justified,

			caseevent_stage,
			caseevent_member_stage,
			caseevent_admission_source,
			caseevent_category,
			caseevent_class,

			services_comments,
			servicecomment_comments,
			eventcomment_comments,

			servicecomment_author_id,
			eventcomment_author_id,
			caseeventsummary_author_id,
			
			caseeventsummary_category,
			caseeventsummary_assessment,

			services_process_state,
			services_evidence_state_flags,

			services_service_type_value,
			services_scheduled,
			services_assigned_to_id,
			services_coverage_tag,

      emr.diagnosis,
      emr.evaluation_cie_keys,
      emr.evaluation_diagnostics,
      emr.evaluation_diagnostic_impression,
      emr.specialization,
      emr.interrogation_system,
      emr.interrogation_system_name,
      emr.interrogation_notes,
      emr.exam_notes,
      emr.med_note_date,
      emr.exam_physical_date,
      emr.exam_date,
      emr.exam_obstetric_date,
      emr.addendum_date,
      emr.interrogation_date,
      emr.scheduledprocedure_date,
      emr.dischargeinfo_date,
      emr.discharge_date,
      emr.evaluation_date,
      emr.medical_procedure_date,
      emr.consult_prescription_date,
      emr.med_history_date,
      emr.med_note_type,
      emr.med_note_motive,
      emr.state,
      emr.med_explo_segment_name,
      emr.med_explo_segment,
      emr.scheduledprocedure_procedure_name,
      emr.medical_procedure_name,
      emr.medical_procedure,
      emr.pathologies_state,
      emr.surgeries_state,
      emr.vaccines_state,
      emr.hospitalizations_state,
      emr.allergies_state,
      emr.malformations_state,
      emr.family_pathologies_state,
      emr.mental_health_psychology_state,
      emr.mental_health_psychiatry_state,
      emr.signed,
      emr.doctor_specialization,
      emr.has_gynecological_exams,
      emr.has_been_pregnant,
      emr.has_menstrual_cycle,
      emr.has_birth_control,
      emr.has_therapy,
      emr.has_antibiotics,
      emr.scheduledprocedure_is_urgent,
      emr.scheduledprocedure_in_hospital,
      emr.scheduledprocedure_has_extra_requirements,
      emr.dischargeinfo_visits_amount,
      emr.health_summary,
      emr.recommendations,
      emr.suffering,
      emr.med_explo_notes,
      emr.exam_physical_notes,
      emr.addendum_notes,
      emr.therapy_notes,
      emr.pathologies_notes,
      emr.surgeries_notes,
      emr.vaccines_notes,
      emr.hospitalizations_notes,
      emr.allergies_notes,
      emr.malformations_notes,
      emr.family_pathologies_notes,
      emr.mental_health_psychology_notes,
      emr.mental_health_psychiatry_notes,
      emr.medicines_notes,
      emr.evaluation_notes,
      emr.scheduledprocedure_medical_reason,
      emr.scheduledprocedure_extra_requirements,
      emr.dischargeinfo_stay_summary,
      emr.dischargeinfo_evolution,
      emr.dischargeinfo_discharge_reason,
      emr.medical_procedure_description,
      emr.procedurecategory_name,
      emr.procedurecategory_description,
      emr.procedurecategory_is_scheduled,
      emr.procedurecategory_type,
      emr.procedurecategory_cpt_key,
      emr.providers_medicalspecialization_name,
      emr.providers_medicalspecialization_description,
      emr.providers_medicalspecialization_type,
      emr.providers_medicalspecialization_is_primary_care,
      emr.last_huli_sync_snapshot,
      emr.prescription_items_json,
      emr.prescription_items_member_checks,
      emr.medical_procedure_pathology_sending_required,
      emr.references_check,
      emr.checkups_check,
      emr.labs_check,
      emr.medicines_check,
      emr.urgencies_check,

		FROM
			`sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
		LEFT JOIN 
			`sofia-data-305018.cadena_cuidado.emr_socios` AS emr
		USING(member_id, service_id)
  ),
  acute_services AS (
    SELECT
      member_id,
      service_id,

      disease_case_id,

      services_related_service_id,
      services_health_plan_id,

    FROM
      base
    LEFT JOIN	
      icd_10_with_class_db
    ON regexp_replace(UPPER(icd_10_with_class_db.cie_10_code), 'X$', '') IN UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(REPLACE(regexp_replace(UPPER(disease_origin_diagnosis_icd), 'X$', ''), '\'', ''), ' ', ''), ']', ''), '[', ''), ','))
    WHERE
      case_event_id IS NULL
    GROUP BY
      member_id,
      service_id,
      disease_case_id,
      services_related_service_id,
      services_health_plan_id
    HAVING
      NOT(MIN(is_acute))
  )


SELECT
  member_id,
	service_id,

	base.case_event_id,
	disease_case_id,

	base.services_related_service_id,
	services_health_plan_id,

	services_cpt,
	services_diagnosis_icd,
	services_provided_by_object_id,
	services_provided_by_content_type_id,
	
	disease_origin_diagnosis_icd,

	caseeventfinalletterdata_cie_codes,
	caseeventfinalletterdata_cie_descriptions,
	caseeventfinalletterdata_cpt_codes,
	caseeventfinalletterdata_cpt_descriptions,
	caseeventfinalletterdata_observations,

	diseasecase_medical_description,
	diseasecase_description,

	services_diagnosis_description,
	services_service_description,
	services_specification,

	services_medical_recommendation_notes,
	caseevent_discharge_ruling_notes,
	caseevent_administrative_ruling_notes,
	caseevent_description,
	caseevent_medical_pre_dictamination_notes,
	caseevent_internal_notes,
	caseevent_requested_partner_doctor_info,
	caseevent_relevant_history,    
	caseevent_discharge_reason,
	caseevent_quote_and_scheduling_ruling_notes,
	caseevent_medical_procedure_ruling_notes,

	services_created_date,
	services_occurrence_date,
	servicecomment_created_date,
	caseevent_created_date,
	eventcomment_created_date,
	caseeventsummary_created_date,
	caseeventfinalletterdata_created_date,
	caseevent_occurrence_date,
	caseevent_pause_start_date,
	diseasecase_created_date,

	caseevent_state,
	caseevent_step,
	caseevent_medically_justified,

	caseevent_stage,
	caseevent_member_stage,
	caseevent_admission_source,
	caseevent_category,
	caseevent_class,

	services_comments,
	servicecomment_comments,
	eventcomment_comments,

	servicecomment_author_id,
	eventcomment_author_id,
	caseeventsummary_author_id,
	
	caseeventsummary_category,
	caseeventsummary_assessment,

	services_process_state,
	services_evidence_state_flags,

	services_service_type_value,
	services_scheduled,
	services_assigned_to_id,
	services_coverage_tag,

	diagnosis,
	evaluation_cie_keys,
	evaluation_diagnostics,
	evaluation_diagnostic_impression,
	specialization,
	interrogation_system,
	interrogation_system_name,
	interrogation_notes,
	exam_notes,
	med_note_date,
	exam_physical_date,
	exam_date,
	exam_obstetric_date,
	addendum_date,
	interrogation_date,
	scheduledprocedure_date,
	dischargeinfo_date,
	discharge_date,
	evaluation_date,
	medical_procedure_date,
	consult_prescription_date,
	med_history_date,
	med_note_type,
	med_note_motive,
	state,
	med_explo_segment_name,
	med_explo_segment,
	scheduledprocedure_procedure_name,
	medical_procedure_name,
	medical_procedure,
	pathologies_state,
	surgeries_state,
	vaccines_state,
	hospitalizations_state,
	allergies_state,
	malformations_state,
	family_pathologies_state,
	mental_health_psychology_state,
	mental_health_psychiatry_state,
	signed,
	doctor_specialization,
	has_gynecological_exams,
	has_been_pregnant,
	has_menstrual_cycle,
	has_birth_control,
	has_therapy,
	has_antibiotics,
	scheduledprocedure_is_urgent,
	scheduledprocedure_in_hospital,
	scheduledprocedure_has_extra_requirements,
	dischargeinfo_visits_amount,
	health_summary,
	recommendations,
	suffering,
	med_explo_notes,
	exam_physical_notes,
	addendum_notes,
	therapy_notes,
	pathologies_notes,
	surgeries_notes,
	vaccines_notes,
	hospitalizations_notes,
	allergies_notes,
	malformations_notes,
	family_pathologies_notes,
	mental_health_psychology_notes,
	mental_health_psychiatry_notes,
	medicines_notes,
	evaluation_notes,
	scheduledprocedure_medical_reason,
	scheduledprocedure_extra_requirements,
	dischargeinfo_stay_summary,
	dischargeinfo_evolution,
	dischargeinfo_discharge_reason,
	medical_procedure_description,
	procedurecategory_name,
	procedurecategory_description,
	procedurecategory_is_scheduled,
	procedurecategory_type,
	procedurecategory_cpt_key,
	providers_medicalspecialization_name,
	providers_medicalspecialization_description,
	providers_medicalspecialization_type,
	providers_medicalspecialization_is_primary_care,
	last_huli_sync_snapshot,
	prescription_items_json,
	prescription_items_member_checks,
	medical_procedure_pathology_sending_required,
	references_check,
	checkups_check,
	labs_check,
	medicines_check,
	urgencies_check
FROM
  base
JOIN
  acute_services
USING(member_id, service_id, disease_case_id, services_health_plan_id)
