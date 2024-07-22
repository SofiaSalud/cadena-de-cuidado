WITH ErrorCases AS (

  -- Error Cases for disease_case_id
  SELECT
    'disease_case_id NULL value' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE disease_case_id IS NULL

  UNION ALL

  SELECT
    'disease_case_id with member_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE member_id IS NULL AND disease_case_id IS NOT NULL

  UNION ALL

  -- Error Cases for case_event_id
  SELECT
    'case_event_id with more than one disease_case_id' AS error_type,
    'case_event_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(case_event_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE case_event_id IS NOT NULL
  GROUP BY case_event_id
  HAVING count(DISTINCT disease_case_id) > 1

  UNION ALL

  SELECT
    'case_event_id with more than one member_id' AS error_type,
    'case_event_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(case_event_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE case_event_id IS NOT NULL
  GROUP BY case_event_id
  HAVING count(DISTINCT member_id) > 1

  UNION ALL

  SELECT
    'case_event_id with service_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE service_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'case_event_id with disease_case_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE disease_case_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  SELECT
    'case_event_id with member_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE member_id IS NULL AND case_event_id IS NOT NULL

  UNION ALL

  -- Error Cases for service_id
  SELECT
    'service_id NULL value' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE service_id IS NULL

  UNION ALL

  SELECT
    'service_id with more than one event id' AS error_type,
    'service_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(service_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE service_id IS NOT NULL
  GROUP BY service_id
  HAVING count(DISTINCT case_event_id) > 1

  UNION ALL

  SELECT
    'service_id with more than one member_id' AS error_type,
    'service_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(service_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE service_id IS NOT NULL
  GROUP BY service_id
  HAVING count(DISTINCT member_id) > 1

  UNION ALL

  SELECT
    'service_id with more than one disease_case_id' AS error_type,
    'service_id' AS error_id,
    ARRAY_AGG(DISTINCT CAST(service_id AS STRING) IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE service_id IS NOT NULL
  GROUP BY service_id
  HAVING count(DISTINCT disease_case_id) > 1

  UNION ALL

  SELECT
    'service_id with disease_case_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE disease_case_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  SELECT
    'service_id with member_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE member_id IS NULL AND service_id IS NOT NULL

  UNION ALL

  -- Error Cases for member_id
  SELECT
    'member_id NULL value' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
  WHERE member_id IS NULL

  UNION ALL

  SELECT
    'member_id with service_id NULL' AS error_type,
    'uuid' AS error_id,
    ARRAY_AGG(DISTINCT uuid IGNORE NULLS) AS error_id_list
  FROM
    `sofia-data-305018.cadena_cuidado.emr_socios` AS emr
  FULL JOIN
    `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS sed
  USING(member_id, service_id, disease_case_id, case_event_id)
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
