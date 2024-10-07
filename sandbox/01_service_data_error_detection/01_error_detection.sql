WITH
  services_events_diseases_socios_db AS (
    SELECT DISTINCT
      member_id,
      service_id,

      case_event_id,
      disease_case_id,

      services_related_service_id,
      services_health_plan_id,

      disease_origin_diagnosis_icd,
      services_diagnosis_icd,
      caseeventfinalletterdata_cie_codes,
      diseasecase_description,

      services_date,
      services_occurrence_date,
      servicecomment_date,
      caseevent_date,
      eventcomment_date,
      caseeventsummary_date,
      caseeventfinalletterdata_date,
      caseevent_occurrence_date,
      caseevent_pause_start_date,
      diseasecase_date,

    FROM
      `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  ),
  emr_socios_db AS (
    SELECT DISTINCT
      member_id,
      service_id,
      case_event_id,
      disease_case_id,

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
       
    FROM
      `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  ),
  icd_10_with_class_db AS (
		SELECT
			icd_10.id AS cie_10_code,
			icd_10.letter AS cie_10_letter,
			icd_10.grouping AS cie_10_grouping,
			icd_10.description AS cie_10_description,
		FROM
			`sofia-data-305018.common_20240702.icd_10` AS icd_10
	),
  ErrorCases AS (
  -- services_events_diseases_socios TABLE
  -- Error Cases for disease_case_id
  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id cie-10 not found' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id, ';bad_cie_10:', ARRAY_TO_STRING(list_bad_cie_10_disease_case_id, ',')) IGNORE NULLS) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      disease_case_id,
      ARRAY_AGG(DISTINCT 
      CASE 
        WHEN regexp_replace(UPPER(cie_10_disease_case_id), 'X$', '') NOT IN (SELECT regexp_replace(UPPER(cie_10_code), 'X$', '') FROM icd_10_with_class_db) THEN cie_10_disease_case_id 
        ELSE NULL
      END IGNORE NULLS) AS list_bad_cie_10_disease_case_id
    FROM
      services_events_diseases_socios_db,
    UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(REPLACE(disease_origin_diagnosis_icd, '\'', ''), ' ', ''), ']', ''), '[', ''), ',')) AS cie_10_disease_case_id
    WHERE 
      disease_case_id IS NOT NULL
      AND disease_origin_diagnosis_icd NOT IN ('None', '[]', 'NOAPLICA')
      AND cie_10_disease_case_id NOT IN ('None', '[]', 'NOAPLICA')
    GROUP BY disease_case_id
  )
  WHERE
    list_bad_cie_10_disease_case_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id cie-10 NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE 
    disease_case_id IS NOT NULL
    AND (disease_origin_diagnosis_icd IN ('None', '[]', 'NOAPLICA') OR disease_origin_diagnosis_icd IS NULL)

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id, ';case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE disease_case_id IS NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id without description' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE diseasecase_description IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id with member_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE member_id IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id with service_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE service_id IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'disease_case_id with more than one member_id' AS error_type,
    ARRAY_AGG(CONCAT('disease_case_id:', disease_case_id, ';member_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      disease_case_id,
      ARRAY_AGG(DISTINCT CAST(member_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      services_events_diseases_socios_db
    WHERE disease_case_id IS NOT NULL
    GROUP BY disease_case_id
    HAVING count(DISTINCT member_id) > 1
  )

  UNION ALL

  -- Error Cases for case_event_id
  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id cie-10 not found' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id, ';bad_cie_10:', ARRAY_TO_STRING(list_bad_cie_10_case_event_id, ',')) IGNORE NULLS) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      case_event_id,
      ARRAY_AGG(DISTINCT 
      CASE 
        WHEN regexp_replace(UPPER(cie_10_case_event_id), 'X$', '') NOT IN (SELECT regexp_replace(UPPER(cie_10_code), 'X$', '') FROM icd_10_with_class_db) THEN cie_10_case_event_id 
        ELSE NULL
      END IGNORE NULLS) AS list_bad_cie_10_case_event_id
    FROM
      services_events_diseases_socios_db,
    UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(REPLACE(caseeventfinalletterdata_cie_codes, '\'', ''), ' ', ''), ']', ''), '[', ''), ',')) AS cie_10_case_event_id
    WHERE 
      case_event_id IS NOT NULL
      AND caseeventfinalletterdata_cie_codes NOT IN ('None', '[]', 'NOAPLICA')
      AND cie_10_case_event_id NOT IN ('None', '[]', 'NOAPLICA')      
    GROUP BY case_event_id
  )
  WHERE
    list_bad_cie_10_case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id cie-10 NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE 
    case_event_id IS NOT NULL
    AND (caseeventfinalletterdata_cie_codes IN ('None', '[]', 'NOAPLICA') OR caseeventfinalletterdata_cie_codes IS NULL)

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id with more than one disease_case_id' AS error_type,
    ARRAY_AGG(CONCAT('case_event_id:', case_event_id, ';disease_case_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      case_event_id,
      ARRAY_AGG(DISTINCT CAST(disease_case_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      services_events_diseases_socios_db
    WHERE case_event_id IS NOT NULL
    GROUP BY case_event_id
    HAVING count(DISTINCT disease_case_id) > 1
  )

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id with more than one member_id' AS error_type,
    ARRAY_AGG(CONCAT('case_event_id:', case_event_id, ';member_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      case_event_id,
      ARRAY_AGG(DISTINCT CAST(member_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      services_events_diseases_socios_db
    WHERE case_event_id IS NOT NULL
    GROUP BY case_event_id
    HAVING count(DISTINCT member_id) > 1
  )

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id with service_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE service_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id with disease_case_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE disease_case_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'case_event_id with member_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE member_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  -- Error Cases for service_id
  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id cie-10 not found' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id, ';bad_cie_10:', ARRAY_TO_STRING(list_bad_cie_10_service_id, ',')) IGNORE NULLS) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT 
      CASE 
        WHEN regexp_replace(UPPER(cie_10_service_id), 'X$', '') NOT IN (SELECT regexp_replace(UPPER(cie_10_code), 'X$', '') FROM icd_10_with_class_db) THEN cie_10_service_id 
        ELSE NULL
      END IGNORE NULLS) AS list_bad_cie_10_service_id
    FROM
      services_events_diseases_socios_db,
    UNNEST(SPLIT(REPLACE(REPLACE(REPLACE(REPLACE(services_diagnosis_icd, '\'', ''), ' ', ''), ']', ''), '[', ''), ',')) AS cie_10_service_id
    WHERE 
      service_id IS NOT NULL
      AND services_diagnosis_icd NOT IN ('None', '[]', 'NOAPLICA')
      AND cie_10_service_id NOT IN ('None', '[]', 'NOAPLICA')
    GROUP BY service_id
  )
  WHERE
    list_bad_cie_10_service_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id cie-10 NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE 
    service_id IS NOT NULL
    AND (services_diagnosis_icd IN ('None', '[]', 'NOAPLICA') OR services_diagnosis_icd IS NULL)

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id, ';disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE service_id IS NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id with more than one case_event_id' AS error_type,
    ARRAY_AGG(CONCAT('service_id:', service_id, ';case_event_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT CAST(case_event_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      services_events_diseases_socios_db
    WHERE service_id IS NOT NULL
    GROUP BY service_id
    HAVING count(DISTINCT case_event_id) > 1
  )

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id with more than one member_id' AS error_type,
    ARRAY_AGG(CONCAT('service_id:', service_id, ';member_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT CAST(member_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      services_events_diseases_socios_db
    WHERE service_id IS NOT NULL
    GROUP BY service_id
    HAVING count(DISTINCT member_id) > 1
  )

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id with more than one disease_case_id' AS error_type,
    ARRAY_AGG(CONCAT('service_id:', service_id, ';disease_case_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'services_events_diseases_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT CAST(disease_case_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      services_events_diseases_socios_db
    WHERE service_id IS NOT NULL
    GROUP BY service_id
    HAVING count(DISTINCT disease_case_id) > 1
  )

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id with disease_case_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE disease_case_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'service_id with member_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE member_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  -- Error Cases for member_id
  SELECT
    'services_events_diseases_socios' AS table_name,
    'member_id NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id, ';case_event_id:', case_event_id, ';disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE member_id IS NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'member_id with service_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('member_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE service_id IS NULL AND member_id IS NOT NULL

  UNION ALL

  SELECT
    'services_events_diseases_socios' AS table_name,
    'member_id with disease_case_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('member_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    services_events_diseases_socios_db
  WHERE disease_case_id IS NULL AND member_id IS NOT NULL

  UNION ALL

  -- emr_socios TABLE
  -- Error Cases for disease_case_id
  SELECT
    'emr_socios' AS table_name,
    'disease_case_id NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id, ';case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE disease_case_id IS NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'disease_case_id with member_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE member_id IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'disease_case_id with service_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE service_id IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'disease_case_id with more than one member_id' AS error_type,
    ARRAY_AGG(CONCAT('disease_case_id:', disease_case_id, ';member_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'emr_socios' AS table_name,
      disease_case_id,
      ARRAY_AGG(DISTINCT CAST(member_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      emr_socios_db
    WHERE disease_case_id IS NOT NULL
    GROUP BY disease_case_id
    HAVING count(DISTINCT member_id) > 1
  )

  UNION ALL

  -- Error Cases for case_event_id
  SELECT
    'emr_socios' AS table_name,
    'case_event_id with more than one disease_case_id' AS error_type,
    ARRAY_AGG(CONCAT('case_event_id:', case_event_id, ';disease_case_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'emr_socios' AS table_name,
      case_event_id,
      ARRAY_AGG(DISTINCT CAST(disease_case_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      emr_socios_db
    WHERE case_event_id IS NOT NULL
    GROUP BY case_event_id
    HAVING count(DISTINCT disease_case_id) > 1
  )

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'case_event_id with more than one member_id' AS error_type,
    ARRAY_AGG(CONCAT('case_event_id:', case_event_id, ';member_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'emr_socios' AS table_name,
      case_event_id,
      ARRAY_AGG(DISTINCT CAST(member_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      emr_socios_db
    WHERE case_event_id IS NOT NULL
    GROUP BY case_event_id
    HAVING count(DISTINCT member_id) > 1
  )

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'case_event_id with service_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE service_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'case_event_id with disease_case_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE disease_case_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'case_event_id with member_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE member_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  -- Error Cases for service_id
  SELECT
    'emr_socios' AS table_name,
    'service_id NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('case_event_id:', case_event_id, ';disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE service_id IS NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'service_id with more than one case_event_id' AS error_type,
    ARRAY_AGG(CONCAT('service_id:', service_id, ';case_event_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'emr_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT CAST(case_event_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      emr_socios_db
    WHERE service_id IS NOT NULL
    GROUP BY service_id
    HAVING count(DISTINCT case_event_id) > 1
  )

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'service_id with more than one member_id' AS error_type,
    ARRAY_AGG(CONCAT('service_id:', service_id, ';member_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'emr_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT CAST(member_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      emr_socios_db
    WHERE service_id IS NOT NULL
    GROUP BY service_id
    HAVING count(DISTINCT member_id) > 1
  )

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'service_id with more than one disease_case_id' AS error_type,
    ARRAY_AGG(CONCAT('service_id:', service_id, ';disease_case_id:', ARRAY_TO_STRING(error_id_list, ','))) AS error_id_list
  FROM(
    SELECT
      'emr_socios' AS table_name,
      service_id,
      ARRAY_AGG(DISTINCT CAST(disease_case_id AS STRING) IGNORE NULLS) AS error_id_list
    FROM
      emr_socios_db
    WHERE service_id IS NOT NULL
    GROUP BY service_id
    HAVING count(DISTINCT disease_case_id) > 1
  )

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'service_id with disease_case_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE disease_case_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'service_id with member_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE member_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  -- Error Cases for member_id
  SELECT
    'emr_socios' AS table_name,
    'member_id NULL value' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('service_id:', service_id, ';case_event_id:', case_event_id, ';disease_case_id:', disease_case_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE member_id IS NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'member_id with service_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('member_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE service_id IS NULL AND member_id IS NOT NULL

  UNION ALL

  SELECT
    'emr_socios' AS table_name,
    'member_id with disease_case_id NULL' AS error_type,
    ARRAY_AGG(DISTINCT CONCAT('member_id:', service_id) IGNORE NULLS) AS error_id_list
  FROM
    emr_socios_db
  WHERE disease_case_id IS NULL AND member_id IS NOT NULL

)

SELECT
  table_name,
  error_type,
  ARRAY_LENGTH(error_id_list) AS len_error_id_list
FROM(
SELECT
  table_name,
  error_type,
  ARRAY_CONCAT_AGG(error_id_list) AS error_id_list
FROM
  ErrorCases
GROUP BY
  table_name,
  error_type
)
ORDER BY
  ARRAY_LENGTH(error_id_list) DESC
