CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.icd_10_embeddings` AS 

SELECT 
  *
FROM
  ML.GENERATE_EMBEDDING(
    MODEL `sofia-data-305018.cadena_cuidado.embedding-multilingual-text-vertex`,
    (
      SELECT 
        id, 
        CONCAT(
          'Enfermedades del CIE-10: codigo ',
          id, ', grupo ',
          IFNULL(icd_table.grouping, ''),
          '  y descripcion ', IFNULL(icd_table.description, '')
        ) AS content
      FROM `sofia-data-305018.common_20240702.icd_10` AS icd_table
    ),
    STRUCT('SEMANTIC_SIMILARITY' as task_type)
)
