SELECT
  icd_10.id,
  icd_10.letter,
  icd_10.grouping,
  icd_10.description,
  CASE  
    WHEN avg_duration_time_days IS NULL AND ABS(acute_probability - chronic_probability) > 0.4 THEN FALSE
    ELSE TRUE
  END AS is_acute
FROM
  `sofia-data-305018.common_20240702.icd_10` AS icd_10
LEFT JOIN
  `sofia-data-305018.cadena_cuidado.icd_10_with_class_and_time` AS icd_10_with_class
ON icd_10.id = icd_10_with_class.cie_10_code
--WHERE
  --avg_duration_time_days IS NULL 
  --AND ABS(acute_probability - chronic_probability) > 0.4 -- Chronicos
  --NOT(avg_duration_time_days IS NULL -- Chronicos
  --AND ABS(acute_probability - chronic_probability) > 0.4) -- Acute
