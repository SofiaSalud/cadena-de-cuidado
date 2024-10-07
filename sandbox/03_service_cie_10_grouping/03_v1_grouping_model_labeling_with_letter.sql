WITH services_with_diff AS (
    SELECT
        member_id,
        service_id,
        SUBSTR(model_icd_code, 1, 2) AS letter,
        model_icd_code,
        model_icd_distance,
        services_diagnosis_icd,
        disease_case_id,
        service_description_summary,
        icd_table.description AS service_icd_description, 
        model_icd_description AS model_icd_description, 
        COALESCE(services_occurrence_ts, services_created_ts) AS services_ts,
        IFNULL(
            DATE_DIFF(COALESCE(services_occurrence_ts, services_created_ts), LAG(COALESCE(services_occurrence_ts, services_created_ts)) OVER (PARTITION BY member_id, SUBSTR(model_icd_code, 1, 2) ORDER BY COALESCE(services_occurrence_ts, services_created_ts)), DAY),
            0
        ) AS days_diff
    FROM
      `cadena_cuidado.services_events_diseases_and_emr_socios` AS services_db
    JOIN
      `sofia-data-305018.cadena_cuidado.icd_10_model_labeling_test_members`
    USING(member_id, service_id, disease_case_id, services_diagnosis_icd)
    LEFT JOIN
        `sofia-data-305018.common_20240702.icd_10` AS icd_table
    ON REGEXP_REPLACE(SPLIT(services_db.services_diagnosis_icd, ',')[SAFE_OFFSET(0)], 'X$', '') = REGEXP_REPLACE(icd_table.id, 'X$', '')
),
services_with_grouping AS (
    SELECT
        member_id,
        service_id,
        letter,
        model_icd_code,
        model_icd_distance,
        services_diagnosis_icd,
        disease_case_id,
        service_description_summary,
        service_icd_description,
        model_icd_description,
        services_ts,
        SUM(CASE WHEN days_diff > 45 THEN 1 ELSE 0 END) OVER (PARTITION BY member_id, letter ORDER BY services_ts) AS group_id -- Diferencia de dias entre servicios
    FROM
        services_with_diff
)
SELECT
    member_id,
    letter,
    group_id,
    ARRAY_AGG(DISTINCT model_icd_code IGNORE NULLS) AS model_icd_code,
    MIN(services_ts) AS group_start_date,
    MAX(services_ts) AS group_end_date,
    COUNT(service_id) AS number_of_services,
    ARRAY_AGG(service_id) AS services_in_group,

    ARRAY_AGG(CONCAT('service_id: ', service_id, ',\ndisease_case_id: ', disease_case_id, ',\nservices_diagnosis_icd: ', services_diagnosis_icd, ',\nmodel_icd_code: ', model_icd_code, ',\nmodel_icd_distance: ', ROUND(model_icd_distance, 3)) IGNORE NULLS ORDER BY services_ts) AS related_services,

  ARRAY_AGG(service_description_summary IGNORE NULLS ORDER BY services_ts) AS service_description_summary,
  ARRAY_AGG(service_icd_description IGNORE NULLS ORDER BY services_ts) AS service_icd_description,
  ARRAY_AGG(model_icd_description IGNORE NULLS ORDER BY services_ts) AS model_icd_description,
FROM
    services_with_grouping
GROUP BY
    member_id,
    letter,
    group_id
ORDER BY
    member_id,
    group_start_date


-- Agrupar por letras o dominio y ventana, hacer una correcion hacia atras
-- Detectar las consultas preventivas y las primeras consultas, las que pide el socio por algo nuevo
  -- preguntar si el socio puede pedir una consulta por algo nuevo o puede decir que es por el seguimiento de algo mas
-- Hay enfermedades que tienen más de 1 mes de visbilidad para atras? Por ejemplo, depresion? Se toma solo los eventos
-- Hay que ver como agrupar los que no son consultas, tal vez usar los servicios relacionados para llegar al origen 
