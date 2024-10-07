CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` (
	member_id_from_event INT64 OPTIONS (description = 'Member ID from event'), 
	member_id_from_service INT64 OPTIONS (description = 'Member ID from service'),
	member_id_from_dc_for_event INT64 OPTIONS (description = 'Member ID from disease case for event'),
	member_id_from_dc_for_service INT64 OPTIONS (description = 'Member ID from disease case for service'),
	member_id INT64 OPTIONS (description = 'Member ID'),
	service_id INT64 OPTIONS (description = 'Service ID'),
	case_event_id INT64 OPTIONS (description = 'Case event ID'),
	case_event_id_from_service INT64 OPTIONS (description = 'Case event ID from service'),
	disease_case_id_from_event INT64 OPTIONS (description = 'Disease case ID from event'),
	disease_case_id_from_service INT64 OPTIONS (description = 'Disease case ID from service'),
	disease_case_id INT64 OPTIONS (description = 'Disease case ID'),
	services_related_service_id INT64 OPTIONS (description = 'Related service ID'),
	services_health_plan_id INT64 OPTIONS (description = 'Health plan ID'),
    caseevent_invoice_id INT64 OPTIONS (description = 'Invoice ID'),
	provider_admin_user_id INT64 OPTIONS (description = 'Provider admin user ID'),
	doctorfriend_id INT64 OPTIONS (description = 'Doctor friend ID'),
	doctor_id INT64 OPTIONS (description = 'Doctor ID'),
	doctor_user_id INT64 OPTIONS (description = 'Doctor user ID'),
	services_cpt STRING OPTIONS (description = 'CPT codes'),
	services_diagnosis_icd STRING OPTIONS (description = 'Diagnosis ICD codes'),
	services_provided_by_object_id INT64 OPTIONS (description = 'Provider ID'),
	services_provided_by_content_type_id INT64 OPTIONS (description = 'Provider content type ID'),
	provider_network STRING OPTIONS (description = 'Provider network'),
	disease_origin_diagnosis_icd_for_event STRING OPTIONS (description = 'Disease origin diagnosis ICD for event'),
	disease_origin_diagnosis_icd_for_service STRING OPTIONS (description = 'Disease origin diagnosis ICD for service'),
	disease_origin_diagnosis_icd STRING OPTIONS (description = 'Disease origin diagnosis ICD'),
	case_event_origin_diagnosis_icd STRING OPTIONS (description = 'Case event origin diagnosis ICD'),
	caseeventfinalletterdata_cie_codes STRING OPTIONS (description = 'CIE codes'),
	caseeventfinalletterdata_cie_descriptions STRING OPTIONS (description = 'CIE descriptions'),
	caseeventfinalletterdata_cpt_codes STRING OPTIONS (description = 'CPT codes'),
	caseeventfinalletterdata_cpt_descriptions STRING OPTIONS (description = 'CPT descriptions'),
	diseasecase_medical_description_for_event STRING OPTIONS (description = 'Disease case medical description for event'),
	diseasecase_medical_description_for_service STRING OPTIONS (description = 'Disease case medical description for service'),
	diseasecase_medical_description STRING OPTIONS (description = 'Disease case medical description'),
	diseasecase_description_for_event STRING OPTIONS (description = 'Disease case description for event'),
	diseasecase_description_for_service STRING OPTIONS (description = 'Disease case description for service'),
	diseasecase_description STRING OPTIONS (description = 'Disease case description'),
	services_diagnosis_description STRING OPTIONS (description = 'Diagnosis description'),
	services_service_description STRING OPTIONS (description = 'Service description'),
	services_specification STRING OPTIONS (description = 'Service specification'),
	services_medical_recommendation_notes STRING OPTIONS (description = 'Service medical recommendation notes'),
	caseevent_discharge_ruling_notes STRING OPTIONS (description = 'Case event discharge ruling notes'),
	caseevent_administrative_ruling_notes STRING OPTIONS (description = 'Case event administrative ruling notes'),
	caseevent_description STRING OPTIONS (description = 'Case event description'),
	caseevent_medical_pre_dictamination_notes STRING OPTIONS (description = 'Case event medical pre dictamination notes'),
	caseevent_internal_notes STRING OPTIONS (description = 'Case event internal notes'),
	caseevent_requested_partner_doctor_info STRING OPTIONS (description = 'Case event requested partner doctor info'),
	caseevent_relevant_history STRING OPTIONS (description = 'Case event relevant history'), 
	caseevent_discharge_reason STRING OPTIONS (description = 'Case event discharge reason'),
	caseevent_quote_and_scheduling_ruling_notes STRING OPTIONS (description = 'Case event quote and scheduling ruling notes'),
	caseevent_medical_procedure_ruling_notes STRING OPTIONS (description = 'Case event medical procedure ruling notes'),
	services_created_ts TIMESTAMP OPTIONS (description = 'Service created date'),
	services_occurrence_ts TIMESTAMP OPTIONS (description = 'Service occurrence date'),
	servicecomment_created_ts TIMESTAMP OPTIONS (description = 'Service comment created date'),
	caseevent_created_ts TIMESTAMP OPTIONS (description = 'Case event created date'),
    caseevent_occurrence_ts TIMESTAMP OPTIONS (description = 'Case event occurrence date'),
	caseevent_pause_start_ts TIMESTAMP OPTIONS (description = 'Case event pause start date'),
    caseevent_discharge_start_ts TIMESTAMP OPTIONS (description = 'Case event discharge start date'),
     caseevent_medical_monitoring_ts TIMESTAMP OPTIONS (description = 'Case event medical monitoring date'),
	eventcomment_created_ts TIMESTAMP OPTIONS (description = 'Event comment created date'),
	caseeventsummary_created_ts TIMESTAMP OPTIONS (description = 'Case event summary created date'),
	caseeventfinalletterdata_created_ts TIMESTAMP OPTIONS (description = 'Case event final letter data created date'),
	diseasecase_created_ts_for_event TIMESTAMP OPTIONS (description = 'Disease case created date for event'),
	diseasecase_created_ts_for_service TIMESTAMP OPTIONS (description = 'Disease case created date for service'),
	diseasecase_created_ts TIMESTAMP OPTIONS (description = 'Disease case created date'),
	caseevent_state STRING OPTIONS (description = 'Case event state'),
	caseevent_step INT64 OPTIONS (description = 'Case event step'),
	caseevent_medically_justified STRING OPTIONS (description = 'Case event medically justified'),
	caseevent_stage STRING OPTIONS (description = 'Case event stage'),
	caseevent_member_stage STRING OPTIONS (description = 'Case event member stage'),
	caseevent_admission_source STRING OPTIONS (description = 'Case event admission source'),
	caseevent_category STRING OPTIONS (description = 'Case event category'),
	caseevent_class STRING OPTIONS (description = 'Case event class'),
	services_comments STRING OPTIONS (description = 'Service comments'),
	servicecomment_comments STRING OPTIONS (description = 'Service comment comments'),
	eventcomment_comments STRING OPTIONS (description = 'Event comment comments'),
	servicecomment_author_id INT64 OPTIONS (description = 'Service comment author ID'),
	eventcomment_author_id INT64 OPTIONS (description = 'Event comment author ID'),
	caseeventsummary_author_id INT64 OPTIONS (description = 'Case event summary author ID'),
	caseeventsummary_category STRING OPTIONS (description = 'Case event summary category'),
	caseeventsummary_assessment STRING OPTIONS (description = 'Case event summary assessment'),
	services_is_automatic_approval_workflow BOOL OPTIONS (description = 'Service is automatic approval workflow'),
	services_automatic_ruling_passed BOOL OPTIONS (description = 'Service automatic ruling passed'),
	services_process_state STRING OPTIONS (description = 'Service process state'),
	services_evidence_state_flags STRING OPTIONS (description = 'Service evidence state flags'),
	services_service_type_value STRING OPTIONS (description = 'Service type value'),
	service_type_from_description STRING OPTIONS (description = 'Service type from description'),
	services_scheduled BOOL OPTIONS (description = 'Service scheduled'),
	services_assigned_to_id INT64 OPTIONS (description = 'Service assigned to ID'),
	services_coverage_tag STRING OPTIONS (description = 'Service coverage tag'),
	provider_name STRING OPTIONS (description = 'Provider name'),
	provider_category_name STRING OPTIONS (description = 'Provider category name'),
	provider_state STRING OPTIONS (description = 'Provider state'),
	provider_contract_category STRING OPTIONS (description = 'Provider contract category'),
	doctorfriend_name STRING OPTIONS (description = 'External doctor name'),
	doctor_nickname STRING OPTIONS (description = 'Doctor nickname'), 
	doctor_name STRING OPTIONS (description = 'Internal doctor name'),
	doctor_descriptor STRING OPTIONS (description = 'Doctor descriptor'), 
	doctor_is_primary_care_doctor BOOL OPTIONS (description = 'Doctor is primary care doctor'),
	doctor_is_active BOOL OPTIONS (description = 'Doctor is active'), 
	doctor_is_pediatrics_care_doctor BOOL OPTIONS (description = 'Doctor is pediatrics care doctor'), 
	doctor_license_institution STRING OPTIONS (description = 'Doctor license institution'), 
	doctor_internal_notes STRING OPTIONS (description = 'Doctor internal notes'), 
	doctor_availability_hours INT64 OPTIONS (description = 'Doctor availability hours'),
	doctor_specializations STRING OPTIONS (description = 'Doctor specializations'),
	doctor_specializationfare_name STRING OPTIONS (description = 'Doctor specialization fare name'),
	doctor_specialization_name STRING OPTIONS (description = 'Doctor specialization name'),
	doctor_specialization_description STRING OPTIONS (description = 'Doctor specialization description'),
	doctor_specialization_type STRING OPTIONS (description = 'Doctor specialization type'),
	member_age_at_subscription INT64 OPTIONS (description = 'Member age at subscription'),
	member_gender STRING OPTIONS (description = 'Member gender'),
	member_occupation STRING OPTIONS (description = 'Member occupation'),
	member_height_cm INT64 OPTIONS (description = 'Member height in cm'),
	member_weight_kg INT64 OPTIONS (description = 'Member weight in kg'),
	member_is_represented_by_user_id INT64 OPTIONS (description = 'Member is represented by user ID'),
	relationship_beneficiary_with_owner STRING OPTIONS (description = 'Relationship beneficiary with owner'),
	owner_type STRING OPTIONS (description = 'Owner type'),
	electronic_voucher_id INT64 OPTIONS (description = 'Electronic voucher ID'),
	voucher_item_items STRING OPTIONS (description = 'Voucher item items'),
	voucher_item_total_items_quantity	INT64 OPTIONS (description = 'Voucher item total items quantity'),
	voucher_item_total_discount_cents	INT64 OPTIONS (description = 'Voucher item total discount cents'),
	voucher_item_total_unit_value_cents	INT64 OPTIONS (description = 'Voucher item total unit value cents'),
	voucher_item_main_item STRING OPTIONS (description = 'Voucher item main item'),
	voucher_item_list_unit_key STRING OPTIONS (description = 'Voucher item list unit key'),
	voucher_item_parsed_product_service_key STRING OPTIONS (description = 'Voucher item parsed product service key'),
	voucher_item_created_ts TIMESTAMP OPTIONS (description = 'Voucher item created at'),
	voucher_item_is_cancellable BOOL OPTIONS (description = 'Voucher item is cancellable'),
	voucher_item_list_cancellation_state STRING OPTIONS (description = 'Voucher item list cancellation state'),
	voucher_item_list_cancellation_reason STRING OPTIONS (description = 'Voucher item list cancellation reason'),
) OPTIONS (
		description = 'Table with services, events and diseases information of members (socios)'
)
AS

WITH    
	providers_doctor AS (
    SELECT DISTINCT
      id,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(nickname = 'None' OR nickname = '', NULL, nickname) )), NFD), r'\pM', '') AS nickname,
      user_id,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(CONCAT(first_name, ' ', first_last_name, ' ', second_last_name) =  'None' OR CONCAT(first_name, ' ', first_last_name, ' ', second_last_name) = '', NULL, CONCAT(first_name, ' ', first_last_name, ' ', second_last_name)) )), NFD), r'\pM', '') AS member_name,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(descriptor = 'None' OR descriptor = '', NULL, descriptor))), NFD), r'\pM', '') AS descriptor,
      is_primary_care_doctor,
      is_active, 
      is_pediatrics_care_doctor, 
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(license_institution = 'None' OR license_institution = '', NULL, license_institution) )), NFD), r'\pM', '') AS license_institution,
      --available_on_demand, 
			REGEXP_REPLACE(NORMALIZE(TRIM(LOWER( IF(internal_notes = 'None' OR internal_notes = '', NULL, internal_notes) )), NFD), r'\pM', '') AS internal_notes,
      CAST(availability_hours AS INT64) AS availability_hours,
      specialization_fare_id
    FROM
    `sofia-data-305018.backend_db_20240702.providers_doctor`
  ),
  providers_doctorfriend AS (
    SELECT DISTINCT
      id,
      user_id,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(name = 'None' OR name = '', NULL, name) )), NFD), r'\pM', '') AS name,
      tier
    FROM
    `sofia-data-305018.backend_db_20240702.providers_doctorfriend`
  ),
  providers_specializationfare AS (
    SELECT DISTINCT
      id,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(name = 'None' OR name = '', NULL, name) )), NFD), r'\pM', '') AS name,
      medical_specialization_id
    FROM
      `sofia-data-305018.backend_db_20240702.providers_specializationfare` 
  ),
  providers_medicalspecialization AS (
    SELECT DISTINCT
      id, 
      REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(name = 'None' OR name = '', NULL, name) )), NFD), r'\pM', '')  AS name, -- es similar a doctor_specializationfare_name pero limpio y sin GENERIC
      REGEXP_REPLACE(NORMALIZE(TRIM(LOWER( IF(description = 'None' OR description = '', NULL, description) )), NFD), r'\pM', '')  AS description, -- Va en compañia con doctor_specialization_name, es la descripcion de este campo
      REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(type = 'None' OR type = '', NULL, type) )), NFD), r'\pM', '')  AS type,
      --is_primary_care
    FROM
      `sofia-data-305018.backend_db_20240702.providers_medicalspecialization` 
  ),
  app_member AS (
    SELECT DISTINCT
      id,
      residence_address_id,
      REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(occupation = 'None' OR occupation = '', NULL, occupation) )), NFD), r'\pM', '') AS occupation,
			gender,
      REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(nickname = 'None' OR nickname = '', NULL, nickname) )), NFD), r'\pM', '') AS nickname,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(CONCAT(first_name, ' ', first_last_name, ' ', second_last_name) = 'None' OR CONCAT(first_name, ' ', first_last_name, ' ', second_last_name) = '', NULL, CONCAT(first_name, ' ', first_last_name, ' ', second_last_name)) )), NFD), r'\pM', '') AS member_name,
      birth_country,
      CAST(height_cm AS INT64) AS height_cm,
      CAST(weight_kg AS INT64) AS weight_kg,
      date_of_birth,
      birth_country_code,
      nationality_country_code,
      CAST(IF(user_id = represented_by_user_id OR (user_id IS NULL), represented_by_user_id, NULL) AS INT64) AS member_is_represented_by_user_id,
      rfc,
    FROM
      `sofia-data-305018.backend_db_20240702.sofia_app_member`
    WHERE
      deleted IS NULL
  ),
  providerbranchoffice AS (
    SELECT DISTINCT
      id,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(name = 'None' OR name = '', NULL, name) )), NFD), r'\pM', '') AS name,
      provider_id,
      admin_user_id,
    FROM
      `sofia-data-305018.backend_db_20240702.providers_providerbranchoffice`
  ),
  providers_provider AS (
    SELECT DISTINCT
      id,
      contract_category,
      category_id,
      website,
      state,
      --notes
    FROM
      `sofia-data-305018.backend_db_20240702.providers_provider`
  ),
  providercategory AS (
    SELECT DISTINCT
      id,
      REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(name = 'None' OR name = '', NULL, name) )), NFD), r'\pM', '') AS name
    FROM
      `sofia-data-305018.backend_db_20240702.providers_providercategory`
  ),
  app_user AS (
    SELECT DISTINCT
      id
    FROM
      `sofia-data-305018.backend_db_20240702.sofia_app_user`
  ),
	dr_specializations AS (
    SELECT
      doctor_id,
      ARRAY_AGG(DISTINCT REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(pdms.name = 'None' OR pdms.name = '', NULL, pdms.name) )), NFD), r'\pM', '') IGNORE NULLS) AS specialization_arr
    FROM 
      `sofia-data-305018.backend_db_20240702.providers_doctorspecialistdetail` AS sp
    LEFT JOIN 
      `sofia-data-305018.backend_db_20240702.providers_medicalspecialization` AS pdms 
    ON 
      pdms.id = sp.medical_specialization_id
    GROUP BY 1
  ),
  healthplan_healthplan AS (
    SELECT
      h.id,
      h.relationship,
      hap.business_code,
      CASE
        WHEN h.relationship = 'SL' THEN 'Titular'
        WHEN h.relationship = 'WF' THEN 'Esposa'
        WHEN h.relationship = 'HS' THEN 'Esposo'
        WHEN h.relationship = 'DG' THEN 'Hija'
        WHEN h.relationship = 'SN' THEN 'Hijo'
        WHEN hap.business_code IS NOT NULL THEN 'Empleado'
        ELSE NULL -- Add ELSE NULL to handle other cases
      END AS relationship_beneficiary_with_owner,
      CASE 
        WHEN hap.business_code IS NOT NULL THEN 'Persona Moral'
        ELSE 'Persona Física'
      END AS owner_type,
    FROM
      `sofia-data-305018.backend_db_20240702.healthplan_healthplan` AS h
    LEFT JOIN 
      `sofia-data-305018.backend_db_20240702.subscriptions_healthplanapplicationitem` AS hapi 
    ON h.health_plan_application_item_id = hapi.id
    LEFT JOIN 
      `sofia-data-305018.backend_db_20240702.subscriptions_healthplanapplication` AS hap 
    ON hapi.application_id = hap.id
  ),
	voucher_item_db AS (
		SELECT
			ie_items.electronic_voucher_id,
      ARRAY_TO_STRING(ARRAY_AGG(DISTINCT CONCAT(ie_items.description, ': ', ie_items.quantity) IGNORE NULLS), ',') AS items,
      SUM(ie_items.quantity) AS total_items_quantity,
      SUM(ie_items.discount_cents) AS total_discount_cents,
      SUM(ie_items.unit_value_cents) AS total_unit_value_cents,
      MAX_BY(description, quantity) AS main_item,
      ARRAY_TO_STRING(ARRAY_AGG(DISTINCT ie_items.unit_key IGNORE NULLS), ',') AS list_unit_key,
			ARRAY_TO_STRING(ARRAY_AGG(DISTINCT IF(ie_items.parsed_product_service_key IN ('None', ''), NULL, ie_items.parsed_product_service_key) IGNORE NULLS), ',') AS parsed_product_service_key,
			MAX(ie_items.created_at) AS created_at,
			MAX(CAST(IF(ie.is_cancellable IN ('None', ''), NULL, ie.is_cancellable) AS BOOL)) AS is_cancellable,
      ARRAY_TO_STRING(ARRAY_AGG(DISTINCT ie.cancellation_state IGNORE NULLS), ',') AS list_cancellation_state,
      ARRAY_TO_STRING(ARRAY_AGG(DISTINCT ie.cancellation_reason IGNORE NULLS), ',') AS list_cancellation_reason,
		FROM
			`sofia-data-305018.backend_db_20240702.invoice_electronicvoucher` AS ie
		JOIN
			`sofia-data-305018.backend_db_20240702.invoice_electronicvoucheritems` AS ie_items
		ON ie.id = ie_items.electronic_voucher_id
		WHERE
			electronic_voucher_id IS NOT NULL
			AND ie_items.description IS NOT NULL
			AND ie.deleted IS NULL
			AND ie_items.deleted IS NULL
		GROUP BY 
      ie_items.electronic_voucher_id
	),
	diseasecase_db AS (
		SELECT
			CAST(diseasecase.id AS INT64) AS disease_case_id,
			CAST(diseasecase.member_id AS INT64) AS member_id,
			REPLACE(REPLACE(REPLACE(REPLACE( IF(diseasecase.origin_diagnosis_icd = 'None' OR diseasecase.origin_diagnosis_icd = '', NULL, diseasecase.origin_diagnosis_icd), '\'', ''), ' ', ''), ']', ''), '[', '') AS disease_origin_diagnosis_icd,

			diseasecase.created_at AS diseasecase_created_ts, 

			LOWER(TRIM( IF(diseasecase.medical_description = 'None' OR diseasecase.medical_description = '', NULL, diseasecase.medical_description) )) AS diseasecase_medical_description,
			LOWER(TRIM( IF(diseasecase.description = 'None' OR diseasecase.description = '', NULL, diseasecase.description) )) AS diseasecase_description

		FROM
			`sofia-data-305018.backend_db_20240702.services_diseasecase` AS diseasecase
		WHERE
			diseasecase.id IS NOT NULL
			AND diseasecase.member_id IS NOT NULL
			AND (diseasecase.description != 'None' OR diseasecase.description IS NOT NULL)
	),
	events_db AS (
		SELECT
			CAST(caseevent.member_id AS INT64) AS member_id,
			CAST(caseevent.disease_case_id AS INT64) AS disease_case_id,
			CAST(caseevent.id AS INT64) AS case_event_id,
			REPLACE(REPLACE(REPLACE(REPLACE( IF(caseevent.origin_diagnosis_icd = 'None' OR caseevent.origin_diagnosis_icd = '', NULL, caseevent.origin_diagnosis_icd), '\'', ''), ' ', ''), ']', ''), '[', '') AS case_event_origin_diagnosis_icd,

			caseevent.created_at AS caseevent_created_ts,
			CAST( IF( (caseevent.occurrence_date = 'None') OR (caseevent.occurrence_date = '') OR (caseevent.occurrence_date = ""), NULL, caseevent.occurrence_date) AS TIMESTAMP) AS caseevent_occurrence_ts,
			CAST( IF( (caseevent.pause_start_date = 'None') OR (caseevent.pause_start_date = '') OR (caseevent.pause_start_date = ""), NULL, caseevent.pause_start_date) AS TIMESTAMP) AS caseevent_pause_start_ts,
			caseevent.discharge_start_date AS caseevent_discharge_start_ts,
			caseevent.medical_monitoring_date AS caseevent_medical_monitoring_ts,
			CAST( IF( (caseevent.invoice_id = 'None') OR (caseevent.invoice_id = '') OR (caseevent.invoice_id = ""), NULL, caseevent.invoice_id) AS INT64) AS caseevent_invoice_id,
			caseevent.state AS caseevent_state,
			CASE
				WHEN caseevent.state = 'CREATED' THEN 1
				WHEN caseevent.state = 'IN_ADMINISTRATIVE_RULING' THEN 2
				WHEN caseevent.state = 'IN_MEDICAL_PRE_RULING' THEN 3
				WHEN caseevent.state = 'ACCEPTED' THEN 4
				WHEN caseevent.state = 'REJECTED' THEN -1
				WHEN caseevent.state = 'CANCELLED' THEN -1
				WHEN caseevent.state = 'QUOTING' THEN 5
				WHEN caseevent.state = 'LETTERS_SENT' THEN 6
				WHEN caseevent.state = 'SCHEDULED' THEN 7
				WHEN caseevent.state = 'ACTIVE' THEN 8
				WHEN caseevent.state = 'DISCHARGE_INITIATED' THEN 9
				WHEN caseevent.state = 'DISCHARGE_COMPLETED' THEN 10
				WHEN caseevent.state = 'PAUSED' THEN 0
				WHEN caseevent.state = 'MEDICAL_MONITORING' THEN 11
				WHEN caseevent.state = 'PAYMENTS_PENDING' THEN 12
				WHEN caseevent.state = 'PROCESS_FINALIZED' THEN 13
			END AS caseevent_step,
			caseevent.medically_justified AS caseevent_medically_justified,

			caseevent.stage AS caseevent_stage,
			caseevent.member_stage AS caseevent_member_stage,
			caseevent.admission_source AS caseevent_admission_source,
			REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(caseevent.category = 'None' OR caseevent.category = '', NULL, caseevent.category) )), NFD), r'\pM', '') AS caseevent_category,
			caseevent.event_class AS caseevent_class,

			caseevent.discharge_ruling_notes AS caseevent_discharge_ruling_notes,
			caseevent.administrative_ruling_notes AS caseevent_administrative_ruling_notes,
			LOWER(TRIM( IF(caseevent.description = 'None' OR caseevent.description = '', NULL, caseevent.description) )) AS caseevent_description,
			caseevent.medical_pre_dictamination_notes AS caseevent_medical_pre_dictamination_notes,
			LOWER(TRIM( IF(caseevent.internal_notes = 'None' OR caseevent.internal_notes = '', NULL, caseevent.internal_notes) )) AS caseevent_internal_notes,
			caseevent.requested_partner_doctor_info AS caseevent_requested_partner_doctor_info,
			caseevent.relevant_history AS caseevent_relevant_history,    
			caseevent.discharge_reason AS caseevent_discharge_reason,
			caseevent.quote_and_scheduling_ruling_notes AS caseevent_quote_and_scheduling_ruling_notes,
			caseevent.medical_procedure_ruling_notes AS caseevent_medical_procedure_ruling_notes,

			eventcomment.author_id AS eventcomment_author_id, -- author_id sabios medicos
			eventcomment.created_at AS eventcomment_created_ts,
			eventcomment.comment AS eventcomment_comments,

			caseeventsummary.author_id AS caseeventsummary_author_id, -- author_id sabios medicos
			caseeventsummary.created_at AS caseeventsummary_created_ts,
			caseeventsummary.category AS caseeventsummary_category,
			caseeventsummary.assessment AS caseeventsummary_assessment,

			caseeventfinalletterdata.created_at AS caseeventfinalletterdata_created_ts,
			REPLACE(REPLACE(REPLACE(REPLACE( IF(caseeventfinalletterdata.cie_codes = 'None' OR caseeventfinalletterdata.cie_codes = '', NULL, caseeventfinalletterdata.cie_codes), '\'', ''), ' ', ''), ']', ''), '[', '') AS caseeventfinalletterdata_cie_codes,
			LOWER(TRIM( IF(caseeventfinalletterdata.cie_descriptions = 'None' OR caseeventfinalletterdata.cie_descriptions = '', NULL, caseeventfinalletterdata.cie_descriptions) )) AS caseeventfinalletterdata_cie_descriptions,
			REPLACE(REPLACE(REPLACE(REPLACE( IF(caseeventfinalletterdata.cpt_codes = 'None' OR caseeventfinalletterdata.cpt_codes = '', NULL, caseeventfinalletterdata.cpt_codes), '\'', ''), ' ', ''), ']', ''), '[', '') AS caseeventfinalletterdata_cpt_codes,
			LOWER(TRIM( IF(caseeventfinalletterdata.cpt_descriptions = 'None' OR caseeventfinalletterdata.cpt_descriptions = '', NULL, caseeventfinalletterdata.cpt_descriptions) )) AS caseeventfinalletterdata_cpt_descriptions,
			--caseeventfinalletterdata.observations AS caseeventfinalletterdata_observations,

		FROM
			`sofia-data-305018.backend_db_20240702.services_caseevent` AS caseevent
		LEFT JOIN
			`sofia-data-305018.backend_db_20240702.services_eventcomment` AS eventcomment
		ON caseevent.id = eventcomment.event_id
		LEFT JOIN
			`sofia-data-305018.backend_db_20240702.services_caseeventsummary` AS caseeventsummary
		ON caseevent.id = caseeventsummary.event_id
		LEFT JOIN
			`sofia-data-305018.backend_db_20240702.services_caseeventfinalletterdata` AS caseeventfinalletterdata
		ON caseevent.id = caseeventfinalletterdata.case_event_id
		WHERE
			caseevent.member_id IS NOT NULL
			AND caseevent.disease_case_id IS NOT NULL
			AND caseevent.id IS NOT NULL
			AND caseevent.deleted = 'None'
			AND caseevent.state != 'CANCELLED'
			AND (eventcomment.deleted = 'None' OR eventcomment.deleted IS NULL)
			AND (caseeventsummary.deleted = 'None' OR caseeventsummary.deleted IS NULL)
			AND (caseeventfinalletterdata.deleted = 'None' OR caseeventfinalletterdata.deleted IS NULL)
	),
	services_db AS (
		SELECT
			CAST(services.member_id AS INT64) AS member_id,
			CAST(services.id AS INT64) AS service_id,
			CAST(services.disease_case_id AS INT64) AS disease_case_id,
			CAST(services.case_event_id AS INT64) AS case_event_id,
			CAST(services.related_service_id AS INT64) AS services_related_service_id, -- servicio padre (todos los servicios de medicamentos y estudios de laboratorio este campo permite ver el origen de tales servicios)
			CAST(services.health_plan_id AS INT64) AS services_health_plan_id,
			--services.uuid AS services_uuid, -- eliminar por que es solo relevante para facturacion 
			REPLACE(REPLACE(REPLACE(REPLACE( IF(services.cpt = 'None' OR services.cpt = '', NULL, services.cpt), '\'', ''), ' ', ''), ']', ''), '[', '') AS services_cpt,
			REPLACE(REPLACE(REPLACE(REPLACE( IF(services.diagnosis_icd = 'None' OR services.diagnosis_icd = '', NULL, services.diagnosis_icd), '\'', ''), ' ', ''), ']', ''), '[', '') AS services_diagnosis_icd,
			CAST(services.provided_by_object_id AS INT64) AS services_provided_by_object_id, -- proveedor doctor, doctor amigo o farmacia-clinica-hospitales
			CAST(services.provided_by_content_type_id AS INT64) AS services_provided_by_content_type_id, -- tipo de proveedor
			CASE
				WHEN services.provided_by_content_type_id = 57 THEN 'hospital_pharmacy_lab'
				WHEN services.provided_by_content_type_id = 58 THEN 'doctor_out_of_network'
				WHEN services.provided_by_content_type_id = 59 THEN 'doctor_in_network'
				ELSE CAST(services.provided_by_content_type_id AS STRING)
			END AS provider_network, 

			services.created_at AS services_created_ts,
			services.occurrence_date AS services_occurrence_ts, -- fecha correcta del servicio ejecutado

			--services.closed AS --services_closed, -- sin uso (eliminar)
			CAST( IF(services.is_automatic_approval_workflow = 'None' OR services.is_automatic_approval_workflow = '', NULL, services.is_automatic_approval_workflow) AS BOOL) AS services_is_automatic_approval_workflow,
			CAST( IF(services.automatic_ruling_passed = 'None' OR services.automatic_ruling_passed = '', NULL, services.automatic_ruling_passed) AS BOOL) AS services_automatic_ruling_passed,
			services.process_state AS services_process_state, -- en que parte del proceso del servicio esta
			--services.automatic_ruling_score AS --services_automatic_ruling_score, -- para dictaminacion automatica (no utilidad para este proyecto)
			--services.suggested_ruling_state AS --services_suggested_ruling_state, -- para dictaminacion automatica (no tiene tanta utilidad para este proyecto)
			IF(services.evidence_state_flags = 'None' OR services.evidence_state_flags = '', NULL, services.evidence_state_flags) AS services_evidence_state_flags, -- Si esta aceptado o rechazada la evidencia 

			services.service_type_value AS services_service_type_value,
			LOWER(TRIM( IF(COALESCE(st.descripcion, 'Otro servicio') = 'None' OR COALESCE(st.descripcion, 'Otro servicio') = '', NULL, COALESCE(st.descripcion, 'Otro servicio')) )) AS service_type_from_description, 
			CAST( IF(services.scheduled = 'None' OR services.scheduled = '', NULL, services.scheduled) AS BOOL) AS services_scheduled,
			--services.ruling_difficulty AS services_ruling_difficulty, -- lo mismo de arriva
			CAST(services.assigned_to_id AS INT64) AS services_assigned_to_id, -- sabios medicos
			services.coverage_tag AS services_coverage_tag, -- se usa en actuaria para ver si es cobertura de gastos medicos medicos mayores, medicamentos, vacunas, ...

			LOWER(TRIM( IF(services.diagnosis_description = 'None' OR services.diagnosis_description = '', NULL, services.diagnosis_description) )) AS services_diagnosis_description,
			services.comments AS services_comments,
			LOWER(TRIM( IF(services.service_description = 'None' OR services.service_description = '', NULL, services.service_description) )) AS services_service_description,
			UPPER(TRIM(REPLACE( IF(services.specification = 'None' OR services.specification = '', NULL, services.specification), '_', ' '))) AS services_specification,
		 	LOWER(TRIM( IF(services.medical_recommendation_notes = 'None' OR services.medical_recommendation_notes = '', NULL, services.medical_recommendation_notes) )) AS services_medical_recommendation_notes,

			servicecomment.author_id AS servicecomment_author_id, -- sabios medicos
			servicecomment.created_at AS servicecomment_created_ts,
			servicecomment.comment AS servicecomment_comments,

			# proveedor 
      		providerbranchoffice.admin_user_id AS provider_admin_user_id,
			providerbranchoffice.name AS provider_name,
			providercategory.name AS provider_category_name,
			----providers_provider.website AS provider_website,
			providers_provider.state AS provider_state,
			--providers_provider.notes AS --provider_notes,
			providers_provider.contract_category AS provider_contract_category,

			# informacion del doctor
			providers_doctorfriend.id AS doctorfriend_id,
			providers_doctorfriend.name AS doctorfriend_name,
      		providers_doctor.id AS doctor_id,
      		providers_doctor.user_id AS doctor_user_id,
			providers_doctor.nickname AS doctor_nickname, 
			providers_doctor.member_name AS doctor_name,
			providers_doctor.descriptor AS doctor_descriptor, 
			providers_doctor.is_primary_care_doctor AS doctor_is_primary_care_doctor,
			providers_doctor.is_active AS doctor_is_active, 
			providers_doctor.is_pediatrics_care_doctor AS doctor_is_pediatrics_care_doctor, 
			providers_doctor.license_institution AS doctor_license_institution, 
			----providers_doctor.available_on_demand AS doctor_available_on_demand, 
			providers_doctor.internal_notes AS doctor_internal_notes, 
			providers_doctor.availability_hours AS doctor_availability_hours,
			ARRAY_TO_STRING(dr_specializations.specialization_arr, ', ') AS doctor_specializations,
			providers_specializationfare.name AS doctor_specializationfare_name,
			providers_medicalspecialization.name AS doctor_specialization_name,
			providers_medicalspecialization.description AS doctor_specialization_description,
			providers_medicalspecialization.type AS doctor_specialization_type,
			----providers_medicalspecialization.is_primary_care AS doctor_specialization_is_primary_care,

			# personales del socio
			DATE_DIFF(COALESCE(DATE(services.occurrence_date), DATE(services.created_at), CURRENT_DATE()), DATE(app_member.date_of_birth), YEAR) AS member_age_at_subscription,
			app_member.gender AS member_gender,
			app_member.occupation AS member_occupation,
			app_member.height_cm AS member_height_cm,
			app_member.weight_kg AS member_weight_kg,
			app_member.member_is_represented_by_user_id,

			# primas
			healthplan_healthplan.relationship_beneficiary_with_owner,
			healthplan_healthplan.owner_type,
			
			CAST(services.electronic_voucher_id AS INT64) AS electronic_voucher_id,
			voucher_item_db.items AS voucher_item_items,
			voucher_item_db.total_items_quantity AS voucher_item_total_items_quantity,
			voucher_item_db.total_discount_cents AS voucher_item_total_discount_cents,
			voucher_item_db.total_unit_value_cents AS voucher_item_total_unit_value_cents,
			voucher_item_db.main_item AS voucher_item_main_item,
			voucher_item_db.list_unit_key AS voucher_item_list_unit_key,
			voucher_item_db.parsed_product_service_key AS voucher_item_parsed_product_service_key,
			voucher_item_db.created_at AS voucher_item_created_ts,
			voucher_item_db.is_cancellable AS voucher_item_is_cancellable,
			voucher_item_db.list_cancellation_state AS voucher_item_list_cancellation_state,
			voucher_item_db.list_cancellation_reason AS voucher_item_list_cancellation_reason,

		FROM
				`sofia-data-305018.backend_db_20240702.services_service` AS services
		LEFT JOIN
				`sofia-data-305018.backend_db_20240702.services_servicecomment` AS servicecomment
		ON services.id = servicecomment.service_id

		LEFT JOIN 
			healthplan_healthplan 
		ON services.health_plan_id = healthplan_healthplan.id

		LEFT JOIN 
			`sofia-data-305018.common_20240702.service_types` AS st 
		ON st.code = services.service_type_value


		LEFT JOIN 
			providers_doctor 
		ON providers_doctor.id = services.provided_by_object_id AND services.provided_by_content_type_id = 59
		LEFT JOIN
			providers_specializationfare
		ON providers_doctor.specialization_fare_id = providers_specializationfare.id -- tarifa de acuerdo a la especializacion (no hay para dr amigo)
		LEFT JOIN
			providers_medicalspecialization
		ON providers_medicalspecialization.id = providers_specializationfare.medical_specialization_id -- solo para dr de red
		LEFT JOIN 
			dr_specializations
		ON dr_specializations.doctor_id = providers_doctor.id


		LEFT JOIN 
			providers_doctorfriend 
		ON providers_doctorfriend.id = services.provided_by_object_id AND services.provided_by_content_type_id = 58


		LEFT JOIN
			providerbranchoffice 
		ON services.provided_by_object_id = providerbranchoffice.id AND services.provided_by_content_type_id = 57 
		LEFT JOIN
			providers_provider -- Solo para los branch office (casa matriz)
		ON providerbranchoffice.provider_id = providers_provider.id
		LEFT JOIN 
			providercategory
		ON providercategory.id = providers_provider.category_id


		LEFT JOIN 
			app_user AS app_user_doctor  -- elimianr
		ON providers_doctor.user_id = app_user_doctor.id


		LEFT JOIN 
			app_user AS app_user_provider -- eliminar
		ON providerbranchoffice.admin_user_id = app_user_provider.id


		LEFT JOIN
			app_member 
		ON services.member_id = app_member.id


		LEFT JOIN
			voucher_item_db
		ON services.electronic_voucher_id = voucher_item_db.electronic_voucher_id

		WHERE   
				services.member_id IS NOT NULL
				AND services.id IS NOT NULL
				AND services.disease_case_id IS NOT NULL
				AND services.health_plan_id IS NOT NULL
				AND services.deleted IS NULL
				AND (servicecomment.deleted = 'None' OR servicecomment.deleted IS NULL)
				AND process_state != 'CANCELLED'
)


SELECT
	member_id_from_event, member_id_from_service,
	diseasecase_db_for_event.member_id AS member_id_from_dc_for_event,
	diseasecase_db_for_service.member_id AS member_id_from_dc_for_service,
	IF(caseevent_created_ts IS NOT NULL, diseasecase_db_for_event.member_id, diseasecase_db_for_service.member_id) AS member_id,
	service_id,

	case_event_id_from_event AS case_event_id,
	case_event_id_from_service,
	disease_case_id_from_event, disease_case_id_from_service,
	IF(caseevent_created_ts IS NOT NULL, disease_case_id_from_event, disease_case_id_from_service) AS disease_case_id,

	services_related_service_id,
	services_health_plan_id,
    caseevent_invoice_id,
	--services_uuid,

	provider_admin_user_id,
	doctorfriend_id,
	doctor_id,
	doctor_user_id,

	services_cpt,
	services_diagnosis_icd,
	services_provided_by_object_id,
	services_provided_by_content_type_id,
	provider_network,

	-- Event tiene prioridad en definir el diagnostico de origen
	diseasecase_db_for_event.disease_origin_diagnosis_icd AS disease_origin_diagnosis_icd_for_event, 
	diseasecase_db_for_service.disease_origin_diagnosis_icd AS disease_origin_diagnosis_icd_for_service,
	IF(caseevent_created_ts IS NOT NULL, diseasecase_db_for_event.disease_origin_diagnosis_icd, diseasecase_db_for_service.disease_origin_diagnosis_icd) AS disease_origin_diagnosis_icd,
	case_event_origin_diagnosis_icd,
	caseeventfinalletterdata_cie_codes,
	caseeventfinalletterdata_cie_descriptions,
	caseeventfinalletterdata_cpt_codes,
	caseeventfinalletterdata_cpt_descriptions,
	--caseeventfinalletterdata_observations,
	diseasecase_db_for_event.diseasecase_medical_description AS diseasecase_medical_description_for_event,
	diseasecase_db_for_service.diseasecase_medical_description AS diseasecase_medical_description_for_service,
	IF(caseevent_created_ts IS NOT NULL, diseasecase_db_for_event.diseasecase_medical_description, diseasecase_db_for_service.diseasecase_medical_description) AS diseasecase_medical_description,
	diseasecase_db_for_event.diseasecase_description AS diseasecase_description_for_event,
	diseasecase_db_for_service.diseasecase_description AS diseasecase_description_for_service,
	IF(caseevent_created_ts IS NOT NULL, diseasecase_db_for_event.diseasecase_description, diseasecase_db_for_service.diseasecase_description) AS diseasecase_description,
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

	services_created_ts,
	services_occurrence_ts,
	servicecomment_created_ts,
	caseevent_created_ts,
    caseevent_occurrence_ts,
	caseevent_pause_start_ts,
    caseevent_discharge_start_ts,
    caseevent_medical_monitoring_ts,
	eventcomment_created_ts,
	caseeventsummary_created_ts,
	caseeventfinalletterdata_created_ts,
	diseasecase_db_for_event.diseasecase_created_ts AS diseasecase_created_ts_for_event,
	diseasecase_db_for_service.diseasecase_created_ts AS diseasecase_created_ts_for_service,
	IF(caseevent_created_ts IS NOT NULL, diseasecase_db_for_event.diseasecase_created_ts, diseasecase_db_for_service.diseasecase_created_ts) AS diseasecase_created_ts,

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

	--services_closed,
	services_is_automatic_approval_workflow,
	services_automatic_ruling_passed,
	services_process_state,
	----services_automatic_ruling_score,
	----services_suggested_ruling_state,
	services_evidence_state_flags,

	services_service_type_value,
	service_type_from_description,
	services_scheduled,
	--services_ruling_difficulty,
	services_assigned_to_id,
	services_coverage_tag,

	# proveedor 
	provider_name,
	provider_category_name,
	----provider_website,
	provider_state,
	--provider_notes,
	provider_contract_category,

	# informacion del doctor
	doctorfriend_name,
	doctor_nickname, 
	doctor_name,
	doctor_descriptor, 
	doctor_is_primary_care_doctor,
	doctor_is_active, 
	doctor_is_pediatrics_care_doctor, 
	doctor_license_institution, 
	----doctor_available_on_demand, 
	doctor_internal_notes, 
	doctor_availability_hours,
	doctor_specializations,
	doctor_specializationfare_name,
	doctor_specialization_name,
	doctor_specialization_description,
	doctor_specialization_type,
	--doctor_specialization_is_primary_care,

	# personales del socio
	member_age_at_subscription,
	member_gender,
	member_occupation,
	member_height_cm,
	member_weight_kg,
	member_is_represented_by_user_id,

	# primas
	relationship_beneficiary_with_owner,
	owner_type,

	electronic_voucher_id,
	voucher_item_items,
	voucher_item_total_items_quantity,
	voucher_item_total_discount_cents,
	voucher_item_total_unit_value_cents,
	voucher_item_main_item,
	voucher_item_list_unit_key,
	voucher_item_parsed_product_service_key,
	voucher_item_created_ts,
	voucher_item_is_cancellable,
	voucher_item_list_cancellation_state,
	voucher_item_list_cancellation_reason,

FROM(
  SELECT
		services_db.member_id	AS member_id_from_service,
		service_id,
		services_db.disease_case_id AS disease_case_id_from_service,
		services_db.case_event_id AS case_event_id_from_service,

		services_db.provider_admin_user_id,
		services_db.doctorfriend_id,
		services_db.doctor_id,
		services_db.doctor_user_id,

    	events_db.member_id AS member_id_from_event,
		events_db.disease_case_id AS disease_case_id_from_event,
		events_db.case_event_id AS case_event_id_from_event,
		events_db.case_event_origin_diagnosis_icd,

		events_db.caseevent_created_ts,
		events_db.caseevent_occurrence_ts,
		events_db.caseevent_pause_start_ts,
    	events_db.caseevent_discharge_start_ts,
    	events_db.caseevent_medical_monitoring_ts,

		events_db.caseevent_state,
		events_db.caseevent_step,
		events_db.caseevent_medically_justified,

		events_db.caseevent_stage,
		events_db.caseevent_member_stage,
		events_db.caseevent_admission_source,
		events_db.caseevent_category,
		events_db.caseevent_class,

		events_db.caseevent_discharge_ruling_notes,
		events_db.caseevent_administrative_ruling_notes,
		events_db.caseevent_description,
		events_db.caseevent_medical_pre_dictamination_notes,
		events_db.caseevent_internal_notes,
		events_db.caseevent_requested_partner_doctor_info,
		events_db.caseevent_relevant_history,    
		events_db.caseevent_discharge_reason,
		events_db.caseevent_quote_and_scheduling_ruling_notes,
		events_db.caseevent_medical_procedure_ruling_notes,
    	events_db.caseevent_invoice_id,

		events_db.eventcomment_author_id,
		events_db.eventcomment_created_ts,
		events_db.eventcomment_comments,

		events_db.caseeventsummary_author_id,
		events_db.caseeventsummary_created_ts,
		events_db.caseeventsummary_category,
		events_db.caseeventsummary_assessment,

		events_db.caseeventfinalletterdata_created_ts,
		events_db.caseeventfinalletterdata_cie_codes,
		events_db.caseeventfinalletterdata_cie_descriptions,
		events_db.caseeventfinalletterdata_cpt_codes,
		events_db.caseeventfinalletterdata_cpt_descriptions,
		--events_db.caseeventfinalletterdata_observations,

		services_db.services_related_service_id,
		services_db.services_health_plan_id,
		--services_db.services_uuid,
		services_db.services_cpt,
		services_db.services_diagnosis_icd,
		services_db.services_provided_by_object_id,
		services_db.services_provided_by_content_type_id,
		services_db.provider_network,

		services_db.services_created_ts,
		services_db.services_occurrence_ts,

		--services_db.services_closed,
		services_db.services_is_automatic_approval_workflow,
		services_db.services_automatic_ruling_passed,
		services_db.services_process_state,
		--services_db.services_automatic_ruling_score,
		--services_db.services_suggested_ruling_state,
		services_db.services_evidence_state_flags,

		services_db.services_service_type_value,
		services_db.service_type_from_description, 
		services_db.services_scheduled,
		--services_db.services_ruling_difficulty,
		services_db.services_assigned_to_id,
		services_db.services_coverage_tag,

		services_db.services_diagnosis_description,
		services_db.services_comments,
		services_db.services_service_description,
		services_db.services_specification,
		services_db.services_medical_recommendation_notes,

		services_db.servicecomment_author_id,
		services_db.servicecomment_created_ts,
		services_db.servicecomment_comments,

		# proveedor 
		services_db.provider_name,
		services_db.provider_category_name,
		--services_db.provider_website,
		services_db.provider_state,
		--services_db.provider_notes,
		services_db.provider_contract_category,

		# informacion del doctor
		services_db.doctorfriend_name,
		services_db.doctor_nickname, 
		services_db.doctor_name,
		services_db.doctor_descriptor, 
		services_db.doctor_is_primary_care_doctor,
		services_db.doctor_is_active, 
		services_db.doctor_is_pediatrics_care_doctor, 
		services_db.doctor_license_institution, 
		----services_db.doctor_available_on_demand, 
		services_db.doctor_internal_notes, 
		services_db.doctor_availability_hours,
		services_db.doctor_specializations,
		services_db.doctor_specializationfare_name,
		services_db.doctor_specialization_name,
		services_db.doctor_specialization_description,
		services_db.doctor_specialization_type,
		--services_db.doctor_specialization_is_primary_care,

		# personales del socio
		services_db.member_age_at_subscription,
		services_db.member_gender,
		services_db.member_occupation,
		services_db.member_height_cm,
		services_db.member_weight_kg,
		services_db.member_is_represented_by_user_id,

		# primas
		services_db.relationship_beneficiary_with_owner,
		services_db.owner_type,

		services_db.electronic_voucher_id,
		services_db.voucher_item_items,
		services_db.voucher_item_total_items_quantity,
		services_db.voucher_item_total_discount_cents,
		services_db.voucher_item_total_unit_value_cents,
		services_db.voucher_item_main_item,
		services_db.voucher_item_list_unit_key,
		services_db.voucher_item_parsed_product_service_key,
		services_db.voucher_item_created_ts,
		services_db.voucher_item_is_cancellable,
		services_db.voucher_item_list_cancellation_state,
		services_db.voucher_item_list_cancellation_reason,
  FROM
    services_db
  FULL JOIN
    events_db
  USING(member_id, case_event_id)
)
LEFT JOIN
  diseasecase_db AS diseasecase_db_for_service
ON diseasecase_db_for_service.disease_case_id=disease_case_id_from_service
LEFT JOIN
  diseasecase_db AS diseasecase_db_for_event
ON diseasecase_db_for_event.disease_case_id=disease_case_id_from_event
WHERE
	service_id IS NOT NULL
