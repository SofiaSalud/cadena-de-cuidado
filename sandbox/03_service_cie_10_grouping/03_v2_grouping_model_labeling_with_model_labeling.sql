CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.icd_10_model_grouping_test_members` AS 

WITH 
	services_embed AS (
    SELECT
			member_id,
			service_id,
			model_icd_code,
			model_icd_distance,
			services_diagnosis_icd,
			disease_case_id,
			service_description_summary,
			service_description_summary_llm,
			model_icd_description, 
			COALESCE(services_occurrence_ts, services_created_ts) AS services_ts,
			REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
      CONCAT(
        IF(diseasecase_description IS NOT NULL OR med_note_motive IS NOT NULL, CONCAT('Motivo de consulta medica: ', IFNULL(diseasecase_description,''), ', ', IFNULL(med_note_motive, ''), ' '), ''),
        IF(evaluation_diagnostic_impression IS NOT NULL OR evaluation_notes IS NOT NULL, CONCAT('Posible diagnostico y evaluacion: ', IFNULL(evaluation_diagnostic_impression,''), ' ', IFNULL(evaluation_notes, ''), ' '), '')
      ),
      ',  ,', ', '), ',  ', '.'), ' , ', '.'), ' + ', ', '), '.+ ', ', ') AS short_content,
      (SELECT ml_generate_embedding_result FROM ML.GENERATE_EMBEDDING(MODEL `sofia-data-305018.cadena_cuidado.embedding-multilingual-text-vertex`, (SELECT 
			IF(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
      CONCAT(
        IF(diseasecase_description IS NOT NULL OR med_note_motive IS NOT NULL, CONCAT('Motivo de consulta medica: ', IFNULL(diseasecase_description,''), ', ', IFNULL(med_note_motive, ''), ' '), ''),
        IF(evaluation_diagnostic_impression IS NOT NULL OR evaluation_notes IS NOT NULL, CONCAT('Posible diagnostico y evaluacion: ', IFNULL(evaluation_diagnostic_impression,''), ' ', IFNULL(evaluation_notes, ''), ' '), '')
      ),
      ',  ,', ', '), ',  ', '.'), ' , ', '.'), ' + ', ', '), '.+ ', ', ') = '', service_description_summary_llm, REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
      CONCAT(
        IF(diseasecase_description IS NOT NULL OR med_note_motive IS NOT NULL, CONCAT('Motivo de consulta medica: ', IFNULL(diseasecase_description,''), ', ', IFNULL(med_note_motive, ''), ' '), ''),
        IF(evaluation_diagnostic_impression IS NOT NULL OR evaluation_notes IS NOT NULL, CONCAT('Posible diagnostico y evaluacion: ', IFNULL(evaluation_diagnostic_impression,''), ' ', IFNULL(evaluation_notes, ''), ' '), '')
      ),
      ',  ,', ', '), ',  ', '.'), ' , ', '.'), ' + ', ', '), '.+ ', ', '))
			AS content), STRUCT('SEMANTIC_SIMILARITY' as task_type))) AS service_description_summary_embedding,
    FROM
      `cadena_cuidado.services_events_diseases_and_emr_socios` AS services_db
    JOIN
      `sofia-data-305018.cadena_cuidado.icd_10_model_labeling_test_members`
    USING(member_id, service_id, disease_case_id, services_diagnosis_icd)
	),
	services_embed_dist AS (
		SELECT
			services_embed_main.member_id,
			services_embed_main.service_id,
			services_embed_main.model_icd_code,
			services_embed_main.model_icd_distance,
			services_embed_main.services_diagnosis_icd,
			services_embed_main.disease_case_id,
			services_embed_main.service_description_summary,
			services_embed_main.model_icd_description, 
			services_embed_main.services_ts,

			services_embed_second.service_id AS service_id_second,
			services_embed_second.model_icd_code AS model_icd_code_second,
			services_embed_second.model_icd_distance AS model_icd_distance_second,
			services_embed_second.model_icd_description AS model_icd_description_second,
			
			ML.DISTANCE(services_embed_main.service_description_summary_embedding, services_embed_second.service_description_summary_embedding, 'COSINE') AS dist,
      
		FROM
			services_embed AS services_embed_main
    JOIN
      services_embed AS services_embed_second
    ON services_embed_main.member_id = services_embed_second.member_id-- AND services_embed_main.services_ts <= services_embed_second.services_ts-- AND DATE_DIFF(services_embed_second.services_ts, services_embed_main.services_ts, DAY) < 45
	),
	clean_cie_10 AS (
		SELECT 
			member_id,
			service_id,
			model_icd_code,
			model_icd_distance,
			services_diagnosis_icd,
			disease_case_id,
			service_description_summary,
			model_icd_description, 
			services_ts,

			MIN_BY(model_icd_code_second, IF(dist < 0.2, model_icd_distance_second, NULL)) AS match_model_icd_code, 
			MIN_BY(model_icd_distance_second, IF(dist < 0.2, model_icd_distance_second, NULL)) AS match_model_icd_distance,
			MIN_BY(model_icd_description_second, IF(dist < 0.2, model_icd_distance_second, NULL)) AS match_model_icd_description
		FROM
			services_embed_dist
		GROUP BY 
			member_id,
			service_id,
			model_icd_code,
			model_icd_distance,
			services_diagnosis_icd,
			disease_case_id,
			service_description_summary,
			model_icd_description, 
			services_ts
	),
	services_with_diff AS (
    SELECT
			member_id,
			service_id,
			match_model_icd_code,
			match_model_icd_distance,
			match_model_icd_description,
			model_icd_code,
			model_icd_distance,
			model_icd_description, 
			services_diagnosis_icd,
			disease_case_id,
			service_description_summary,
			services_ts,
			IFNULL(
					DATE_DIFF(services_ts, LAG(services_ts) OVER (PARTITION BY member_id, match_model_icd_code ORDER BY services_ts), DAY),
					0
			) AS days_diff
    FROM
      clean_cie_10
	),
	services_with_grouping AS (
    SELECT
			member_id,
			service_id,
			match_model_icd_code,
			match_model_icd_distance,
			match_model_icd_description, 
			model_icd_code,
			model_icd_distance,
			model_icd_description, 
			services_diagnosis_icd,
			disease_case_id,
			service_description_summary,
			services_ts,
			SUM(CASE WHEN days_diff > 45 THEN 1 ELSE 0 END) OVER (PARTITION BY member_id, match_model_icd_code ORDER BY services_ts) AS group_id, -- Diferencia de dias entre servicios
    FROM
			services_with_diff
)


SELECT
	member_id,
	--group_id,
	CONCAT(match_model_icd_code, '_', group_id) AS model_disease_id,
	match_model_icd_code AS model_disease_icd,
	MIN(services_ts) AS group_start_date,
	MAX(services_ts) AS group_end_date,
	COUNT(service_id) AS number_of_services,
	ARRAY_AGG(service_id) AS services_in_group,

	ARRAY_AGG(CONCAT('services_ts: ', services_ts, '\nservice_id: ', service_id, ',\ndisease_case_id: ', disease_case_id, ',\nservices_diagnosis_icd: ', services_diagnosis_icd, ',\nmodel_icd_code: ', model_icd_code, ',\nmodel_icd_distance: ', ROUND(model_icd_distance, 3)) IGNORE NULLS ORDER BY services_ts) AS related_services,

	ARRAY_AGG(service_description_summary IGNORE NULLS ORDER BY services_ts) AS service_description_summary,
	ARRAY_AGG(match_model_icd_description IGNORE NULLS ORDER BY services_ts) AS model_icd_description,
FROM
    services_with_grouping
GROUP BY
    member_id,
		match_model_icd_code,
		group_id
ORDER BY
    member_id,
    group_start_date






-- Quiero encontrar la similitud entre dos servicios a traves de sus descripciones
-- Juntar los servicios más cercanos
-- Juntar solo servicios que tengan una diferencia entre si menor a 45 dias
-- Despues que se corta la agrupacion, que sea otra distinta
-- Sacar el data diff, si es mayor que 45 es un 1 es el fin de la secuencia
-- las llaves a usar son member_id, service_id
-- Evitar duplicaciones, evitar hacer grupos pequeños



-- Agrupar por letras o dominio y ventana, hacer una correcion hacia atras
-- Detectar las consultas preventivas y las primeras consultas, las que pide el socio por algo nuevo
  -- preguntar si el socio puede pedir una consulta por algo nuevo o puede decir que es por el seguimiento de algo mas
-- Hay enfermedades que tienen más de 1 mes de visbilidad para atras? Por ejemplo, depresion? Se toma solo los eventos
-- Hay que ver como agrupar los que no son consultas, tal vez usar los servicios relacionados para llegar al origen 
