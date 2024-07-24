WITH 
  service_agg AS (
    SELECT
      member_id, service_id, disease_case_id, sed.case_event_id,

      MAX_BY(uuid, services_date) AS uuid,

      MAX_BY(services_date, services_date) AS services_date,
      MAX_BY(caseevent_date, services_date) AS caseevent_date,
      MAX_BY(diseasecase_date, services_date) AS diseasecase_date,
      MAX_BY(med_note_date, services_date) AS med_note_date,

      MAX_BY(diagnosis, services_date) AS diagnosis,
      MAX_BY(disease_origin_diagnosis_icd, services_date) AS disease_origin_diagnosis_icd,
      MAX_BY(diagnosis_icd, services_date) AS diagnosis_icd,
      MAX_BY(diagnosis_description, services_date) AS diagnosis_description,
      MAX_BY(case_event_origin_diagnosis_icd, services_date) AS case_event_origin_diagnosis_icd,
      MAX_BY(cie_codes, services_date) AS cie_codes,
      MAX_BY(cie_descriptions, services_date) AS cie_descriptions,
      MAX_BY(cpt_codes, services_date) AS cpt_codes,
      MAX_BY(cpt_descriptions, services_date) AS cpt_descriptions,
      MAX_BY(cpt, services_date) AS cpt,
      MAX_BY(evaluation_cie_keys, services_date) AS evaluation_cie_keys,
      MAX_BY(evaluation_diagnostics, services_date) AS evaluation_diagnostics,
      MAX_BY(evaluation_diagnostic_impression, services_date) AS evaluation_diagnostic_impression,
      MAX_BY(specialization, services_date) AS specialization,

      MAX_BY(diseasecase_description, services_date) AS diseasecase_description,

      MAX_BY(service_description, services_date) AS service_description,
      MAX_BY(services_comments, services_date) AS services_comments,
      MAX_BY(specification, services_date) AS specification,
      MAX_BY(servicecomment_comments, services_date) AS servicecomment_comments,

      MAX_BY(caseevent_category, services_date) AS caseevent_category,
      MAX_BY(event_class, services_date) AS event_class,
      MAX_BY(caseevent_description, services_date) AS caseevent_description,
      MAX_BY(eventcomment_comments, services_date) AS eventcomment_comments,
      MAX_BY(caseeventsummary_category, services_date) AS caseeventsummary_category,

      MAX_BY(medical_description, services_date) AS medical_description,
      MAX_BY(medical_recommendation_notes, services_date) AS medical_recommendation_notes,
      MAX_BY(observations, services_date) AS observations,
      MAX_BY(interrogation_system, services_date) AS interrogation_system,
      MAX_BY(interrogation_system_name, services_date) AS interrogation_system_name,
      MAX_BY(exam_notes, services_date) AS exam_notes,
      MAX_BY(health_summary, services_date) AS health_summary,
      MAX_BY(suffering, services_date) AS suffering,
      MAX_BY(med_note_type, services_date) AS med_note_type,
      MAX_BY(med_note_motive, services_date) AS med_note_motive,
      MAX_BY(med_explo_notes, services_date) AS med_explo_notes,
      MAX_BY(therapy_notes, services_date) AS therapy_notes,
      MAX_BY(pathologies_notes, services_date) AS pathologies_notes,
      MAX_BY(surgeries_notes, services_date) AS surgeries_notes,
      MAX_BY(vaccines_notes, services_date) AS vaccines_notes,
      MAX_BY(hospitalizations_notes, services_date) AS hospitalizations_notes,
      MAX_BY(allergies_notes, services_date) AS allergies_notes,
      MAX_BY(malformations_notes, services_date) AS malformations_notes,
      MAX_BY(medicines_notes, services_date) AS medicines_notes,
      MAX_BY(evaluation_notes, services_date) AS evaluation_notes,

      MAX_BY(sed.state, services_date) AS sed_state,
      MAX_BY(emr.state, services_date) AS emr_state,

      MAX_BY(discharge_ruling_notes, services_date) AS discharge_ruling_notes,
      MAX_BY(administrative_ruling_notes, services_date) AS administrative_ruling_notes,
      MAX_BY(internal_notes, services_date) AS internal_notes,
      MAX_BY(relevant_history, services_date) AS relevant_history,

      MAX_BY(medical_procedure_ruling_notes, services_date) AS medical_procedure_ruling_notes,
      MAX_BY(quote_and_scheduling_ruling_notes, services_date) AS quote_and_scheduling_ruling_notes,
      MAX_BY(discharge_reason, services_date) AS discharge_reason,

    FROM
      `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
    LEFT JOIN 
      `sofia-data-305018.cadena_cuidado.emr_socios` AS emr 
    USING(member_id, service_id, disease_case_id) 
    WHERE
      process_state != 'CANCELLED'
    GROUP BY member_id, service_id, disease_case_id, case_event_id
  ),
  service_agg_set_event AS (
    SELECT
      member_id, service_id, disease_case_id, 
      
      MAX_BY(case_event_id, caseevent_date) AS case_event_id,
      MAX_BY(uuid, caseevent_date) AS uuid,

      MAX_BY(services_date, caseevent_date) AS services_date,
      MAX_BY(caseevent_date, caseevent_date) AS caseevent_date,
      MAX_BY(diseasecase_date, caseevent_date) AS diseasecase_date,
      MAX_BY(med_note_date, caseevent_date) AS med_note_date,

      MAX_BY(diagnosis, caseevent_date) AS diagnosis,
      MAX_BY(disease_origin_diagnosis_icd, caseevent_date) AS disease_origin_diagnosis_icd,
      MAX_BY(diagnosis_icd, caseevent_date) AS diagnosis_icd,
      MAX_BY(diagnosis_description, caseevent_date) AS diagnosis_description,
      MAX_BY(case_event_origin_diagnosis_icd, caseevent_date) AS case_event_origin_diagnosis_icd,
      MAX_BY(cie_codes, caseevent_date) AS cie_codes,
      MAX_BY(cie_descriptions, caseevent_date) AS cie_descriptions,
      MAX_BY(cpt_codes, caseevent_date) AS cpt_codes,
      MAX_BY(cpt_descriptions, caseevent_date) AS cpt_descriptions,
      MAX_BY(cpt, caseevent_date) AS cpt,
      MAX_BY(evaluation_cie_keys, caseevent_date) AS evaluation_cie_keys,
      MAX_BY(evaluation_diagnostics, caseevent_date) AS evaluation_diagnostics,
      MAX_BY(evaluation_diagnostic_impression, caseevent_date) AS evaluation_diagnostic_impression,
      MAX_BY(specialization, caseevent_date) AS specialization,

      MAX_BY(diseasecase_description, caseevent_date) AS diseasecase_description,

      MAX_BY(service_description, caseevent_date) AS service_description,
      MAX_BY(services_comments, caseevent_date) AS services_comments,
      MAX_BY(specification, caseevent_date) AS specification,
      MAX_BY(servicecomment_comments, caseevent_date) AS servicecomment_comments,

      MAX_BY(caseevent_category, caseevent_date) AS caseevent_category,
      MAX_BY(event_class, caseevent_date) AS event_class,
      MAX_BY(caseevent_description, caseevent_date) AS caseevent_description,
      MAX_BY(eventcomment_comments, caseevent_date) AS eventcomment_comments,
      MAX_BY(caseeventsummary_category, caseevent_date) AS caseeventsummary_category,

      MAX_BY(medical_description, caseevent_date) AS medical_description,
      MAX_BY(medical_recommendation_notes, caseevent_date) AS medical_recommendation_notes,
      MAX_BY(observations, caseevent_date) AS observations,
      MAX_BY(interrogation_system, caseevent_date) AS interrogation_system,
      MAX_BY(interrogation_system_name, caseevent_date) AS interrogation_system_name,
      MAX_BY(exam_notes, caseevent_date) AS exam_notes,
      MAX_BY(health_summary, caseevent_date) AS health_summary,
      MAX_BY(suffering, caseevent_date) AS suffering,
      MAX_BY(med_note_type, caseevent_date) AS med_note_type,
      MAX_BY(med_note_motive, caseevent_date) AS med_note_motive,
      MAX_BY(med_explo_notes, caseevent_date) AS med_explo_notes,
      MAX_BY(therapy_notes, caseevent_date) AS therapy_notes,
      MAX_BY(pathologies_notes, caseevent_date) AS pathologies_notes,
      MAX_BY(surgeries_notes, caseevent_date) AS surgeries_notes,
      MAX_BY(vaccines_notes, caseevent_date) AS vaccines_notes,
      MAX_BY(hospitalizations_notes, caseevent_date) AS hospitalizations_notes,
      MAX_BY(allergies_notes, caseevent_date) AS allergies_notes,
      MAX_BY(malformations_notes, caseevent_date) AS malformations_notes,
      MAX_BY(medicines_notes, caseevent_date) AS medicines_notes,
      MAX_BY(evaluation_notes, caseevent_date) AS evaluation_notes,

      MAX_BY(sed_state, caseevent_date) AS sed_state,
      MAX_BY(emr_state, caseevent_date) AS emr_state,

      MAX_BY(discharge_ruling_notes, caseevent_date) AS discharge_ruling_notes,
      MAX_BY(administrative_ruling_notes, caseevent_date) AS administrative_ruling_notes,
      MAX_BY(internal_notes, caseevent_date) AS internal_notes,
      MAX_BY(relevant_history, caseevent_date) AS relevant_history,

      MAX_BY(medical_procedure_ruling_notes, caseevent_date) AS medical_procedure_ruling_notes,
      MAX_BY(quote_and_scheduling_ruling_notes, caseevent_date) AS quote_and_scheduling_ruling_notes,
      MAX_BY(discharge_reason, caseevent_date) AS discharge_reason,

    FROM
      service_agg
    GROUP BY member_id, service_id, disease_case_id
  ),
  ErrorCases AS (
  -- Error Cases for disease_case_id
  SELECT
    'disease_case_id NULL value' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE disease_case_id IS NULL

  UNION ALL

  SELECT
    'disease_case_id with member_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE member_id IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  -- Error Cases for case_event_id
  SELECT
    'case_event_id with more than one disease_case_id' AS error_type,
    'case_event_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(case_event_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE case_event_id IS NOT NULL
  GROUP BY case_event_id
  HAVING count(DISTINCT disease_case_id) > 1

  UNION ALL

  SELECT
    'case_event_id with more than one member_id' AS error_type,
    'case_event_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(case_event_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE case_event_id IS NOT NULL
  GROUP BY case_event_id
  HAVING count(DISTINCT member_id) > 1

  UNION ALL

  SELECT
    'case_event_id with service_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE service_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'case_event_id with disease_case_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE disease_case_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'case_event_id with member_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE member_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  -- Error Cases for service_id
  SELECT
    'service_id NULL value' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE service_id IS NULL

  UNION ALL

  SELECT
    'service_id with more than one event id' AS error_type,
    'service_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(service_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE service_id IS NOT NULL
  GROUP BY service_id
  HAVING count(DISTINCT case_event_id) > 1

  UNION ALL

  SELECT
    'service_id with more than one member_id' AS error_type,
    'service_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(service_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE service_id IS NOT NULL
  GROUP BY service_id
  HAVING count(DISTINCT member_id) > 1

  UNION ALL

  SELECT
    'service_id with more than one disease_case_id' AS error_type,
    'service_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(service_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE service_id IS NOT NULL
  GROUP BY service_id
  HAVING count(DISTINCT disease_case_id) > 1

  UNION ALL

  SELECT
    'service_id with disease_case_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE disease_case_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  SELECT
    'service_id with member_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE member_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  -- Error Cases for member_id
  SELECT
    'member_id NULL value' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE member_id IS NULL

  UNION ALL

  SELECT
    'member_id with service_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    service_agg_set_event
  WHERE service_id IS NULL AND member_id IS NOT NULL

)

SELECT
  error_type,
  error_id,
  ARRAY_CONCAT_AGG(error_id_list) AS error_id_list
FROM
  ErrorCases
GROUP BY 
  error_type,
  error_id
ORDER BY
  ARRAY_LENGTH(error_id_list) DESC
