CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.icd_10_model_labeling_test_members` AS 

WITH 
  icd_10_embed_table AS (
    SELECT
      id AS icd,
      content AS icd_description,
      ml_generate_embedding_result AS icd_10_embedding

    FROM
      `sofia-data-305018.cadena_cuidado.icd_10_embeddings`
  ),
  service_db AS (
    SELECT
      member_id,
      service_id,
      case_event_id,
      disease_case_id,
      
      evaluation_cie_keys,
      disease_origin_diagnosis_icd,
      services_diagnosis_icd,
      services_cpt,

      REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
      CONCAT(
        IF(diseasecase_description IS NOT NULL OR med_note_motive IS NOT NULL, CONCAT('Motivo de consulta medica: ', IFNULL(diseasecase_description,''), ', ', IFNULL(med_note_motive, ''), ' '), ''),
        IF(evaluation_diagnostic_impression IS NOT NULL OR evaluation_notes IS NOT NULL, CONCAT('Posible diagnostico y evaluacion: ', IFNULL(evaluation_diagnostic_impression,''), ' ', IFNULL(evaluation_notes, ''), ' '), '')
      ),
      ',  ,', ', '), ',  ', '.'), ' , ', '.'), ' + ', ', '), '.+ ', ', ') AS short_content,

      REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
      CONCAT(
        IF(diseasecase_description IS NOT NULL OR med_note_motive IS NOT NULL, CONCAT('Motivo de consulta medica: ', IFNULL(diseasecase_description,''), ', ', IFNULL(med_note_motive, ''), ' '), ''),
        IF(evaluation_diagnostic_impression IS NOT NULL OR evaluation_notes IS NOT NULL, CONCAT('Posible diagnostico y evaluacion: ', IFNULL(evaluation_diagnostic_impression,''), ' ', IFNULL(evaluation_notes, ''), ' '), ''),
        IF(med_note_suffering IS NOT NULL OR consult_prescription_diagnosis IS NOT NULL, CONCAT(', \nPadecimiento: ', IFNULL(med_note_suffering,''), ', ', IFNULL(consult_prescription_diagnosis, ''), ' '), ''),
        IF(doctor_descriptor IS NOT NULL, CONCAT(', \nEspecialidad medica: ', doctor_descriptor), ''),
        IF(consult_prescription_specialization IS NOT NULL, CONCAT(', \nEspecialidad consulta medica: ', consult_prescription_specialization), ''),
        IF(member_gender IS NOT NULL, CONCAT(', \nInformacion del paciente: genero ', CASE WHEN member_gender = 'M' THEN 'Masculino' WHEN member_gender = 'F' THEN 'Femenino' END), '') 
      ),
      ',  ,', ', '), ',  ', '.'), ' , ', '.'), ' + ', ', '), '.+ ', ', ') AS content
    FROM
			`sofia-data-305018.cadena_cuidado.services_events_diseases_and_emr_socios`
    WHERE
      DATE(services_created_ts) BETWEEN '2023-01-01' AND '2024-06-01'
      AND case_event_id IS NULL
      AND services_service_type_value IN ('ON_DEMAND_CONSULT', 'IN_PERSON_CONSULT', 'IN_PERSON_CONSULT_BY_PROVIDER', 'EXTERNAL_CONSULT', 'MEDICAL_FEES') 
      AND member_id IN (6369, 16477, 18203, 13971, 22543)
  ),
  service_embed_table AS (
    SELECT 
      member_id,
      service_id,
      case_event_id,
      disease_case_id,

      evaluation_cie_keys,
      disease_origin_diagnosis_icd,
      services_diagnosis_icd,
      services_cpt,

      service_description_summary,
      content AS service_description_summary_llm,
      ml_generate_embedding_result AS service_description_summary_llm_embedding
    FROM
      ML.GENERATE_EMBEDDING(
        MODEL `sofia-data-305018.cadena_cuidado.embedding-multilingual-text-vertex`,
        (
          SELECT 
            member_id,
            service_id,
            case_event_id,
            disease_case_id,

            evaluation_cie_keys,
            disease_origin_diagnosis_icd,
            services_diagnosis_icd,
            services_cpt,

            short_content,
            content AS service_description_summary, 
            COALESCE(
              REGEXP_REPLACE(ml_generate_text_llm_result, r'([0-9])\.([0-9])', r'\1\2'), 
              (
                SELECT 
                  REGEXP_REPLACE(ml_generate_text_llm_result, r'([0-9])\.([0-9])', r'\1\2')
                FROM
                ML.GENERATE_TEXT(
                  MODEL `sofia-data-305018.cadena_cuidado.gemini-pro-text-vertex`,
                  (
                    SELECT 
                      CONCAT('Instrucciones del sistema: Eres un experto en procesos y terminos medicos. Sabes reconocer las enfermedades del CIE-10 o ICD-10. Das respuestas en todos los casos porque eres un experto y profesional medico. Puedes resumir informacion medica de manera eficiente y clara, en no más de 2000 palabras. /n Contexto: ', short_content, ' /n Tarea: Determinar que enfermedades se pueden inferir del contexto. Generar texto de no mas de una oracion. Entrega una conclusion medica si o si de que CIE-10 podria ser y descripcion medica de cada una. Entregar un ranking de las enfermedades más probables. Dar mucha relevancia al Motivo de consulta medica que aparece en el contexto. /n Evitar: Dar consejos, adevertencias o recomendaciones o decir que no se puede inferir una enfermedad. /n Ejemplo 1 de respuesta: **Conclusión médica:** El motivo de consulta sugiere un chequeo rutinario de salud ginecológica, potencialmente codificable como **Z01.4 (CIE-10):  Examen ginecológico (general) (de rutina)**, que se refiere a la consulta para un examen de los órganos reproductivos femeninos y las mamas sin la presencia de síntomas o signos de enfermedad. /n Ejemplo 2 de respuesta: Las posibles enfermedades que se pueden inferir del contexto son: **H95.0** (Otitis media serosa, no especificada), caracterizada por la presencia de líquido en el oído medio con sensación de plenitud ótica y posible hipoacusia, y **H65.2** (Otitis media aguda serosa), que cursa con síntomas similares a la anterior pero de inicio más agudo y posiblemente relacionada con la infección por COVID-19. /n Inferencia de Enfermedades y codigos CIE-10 psoibles con sus descripciones:') AS prompt
                  ),
                  STRUCT(
                    0.1 AS temperature, 0.3 AS top_p, 8192 AS max_output_tokens, TRUE AS flatten_json_output)
                )
              ),
              content
            ) AS content
          FROM
            ML.GENERATE_TEXT(
              MODEL `sofia-data-305018.cadena_cuidado.gemini-pro-text-vertex`,
              (
                SELECT 
                  member_id,
                  service_id,
                  case_event_id,
                  disease_case_id,

                  evaluation_cie_keys,
                  disease_origin_diagnosis_icd,
                  services_diagnosis_icd,
                  services_cpt,

                  short_content,
                  content, 
                  CONCAT('Instrucciones del sistema: Eres un experto en procesos y terminos medicos. Sabes reconocer las enfermedades del CIE-10 o ICD-10. Das respuestas en todos los casos porque eres un experto y profesional medico. Puedes resumir informacion medica de manera eficiente y clara, en no más de 2000 palabras. /n Contexto: ', content, ' /n Tarea: Determinar que enfermedades se pueden inferir del contexto. Generar texto de no mas de una oracion. Entrega una conclusion medica si o si de que CIE-10 podria ser y descripcion medica de cada una. Entregar un ranking de las enfermedades más probables. Dar mucha relevancia al Motivo de consulta medica que aparece en el contexto. /n Evitar: Dar consejos, adevertencias o recomendaciones o decir que no se puede inferir una enfermedad. /n Ejemplo 1 de respuesta: **Conclusión médica:** El motivo de consulta sugiere un chequeo rutinario de salud ginecológica, potencialmente codificable como **Z01.4 (CIE-10):  Examen ginecológico (general) (de rutina)**, que se refiere a la consulta para un examen de los órganos reproductivos femeninos y las mamas sin la presencia de síntomas o signos de enfermedad. /n Ejemplo 2 de respuesta: Las posibles enfermedades que se pueden inferir del contexto son: **H95.0** (Otitis media serosa, no especificada), caracterizada por la presencia de líquido en el oído medio con sensación de plenitud ótica y posible hipoacusia, y **H65.2** (Otitis media aguda serosa), que cursa con síntomas similares a la anterior pero de inicio más agudo y posiblemente relacionada con la infección por COVID-19. /n Inferencia de Enfermedades y codigos CIE-10 psoibles con sus descripciones:') AS prompt
                FROM
                  service_db
              ),
              STRUCT(
                0.1 AS temperature, 0.3 AS top_p, 8192 AS max_output_tokens, TRUE AS flatten_json_output)
          )
        ),
        STRUCT('SEMANTIC_SIMILARITY' as task_type)
      )
)



SELECT
  member_id,
  service_id,
  case_event_id,
  disease_case_id,

  evaluation_cie_keys,
  disease_origin_diagnosis_icd,
  services_diagnosis_icd,
  services_cpt,

  service_description_summary,
  service_description_summary_llm,

  --ARRAY_AGG(icd_content  ORDER BY distance LIMIT 3) AS icd_content,
  --ARRAY_AGG(CONCAT(icd, ': ', distance)  ORDER BY distance LIMIT 3) AS list_icd,

  MIN_BY(icd_description, distance) AS model_icd_description,
  MIN_BY(icd, distance) AS model_icd_code,
  MIN(distance) AS model_icd_distance
FROM(
  SELECT
    icd,
    member_id, 
    service_id, 
    case_event_id,
    disease_case_id, 

    evaluation_cie_keys,
    disease_origin_diagnosis_icd,
    services_diagnosis_icd,
    services_cpt,

    icd_description,
    service_description_summary,
    service_description_summary_llm,

    --icd_10_embedding,
    --service_description_summary_llm_embedding,

    ML.DISTANCE(icd_10_embedding, service_description_summary_llm_embedding, 'COSINE') AS distance
  FROM
    service_embed_table,
    icd_10_embed_table
)
GROUP BY
  member_id,
  service_id,
  case_event_id,
  disease_case_id,
  evaluation_cie_keys,
  disease_origin_diagnosis_icd,
  services_diagnosis_icd,
  services_cpt,
  service_description_summary,
  service_description_summary_llm
