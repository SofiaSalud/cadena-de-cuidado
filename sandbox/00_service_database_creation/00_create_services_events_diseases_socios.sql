CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS 
-- Determinar logica de campos de texto para reducir la cantidad de columnas y redundancia
-- Usar esa tabla en la logica de optimizacion de mlr y recalcular los estadisticos

WITH    
    diseasecase_db AS (
        SELECT
					diseasecase.id AS disease_case_id,
					diseasecase.member_id,
					diseasecase.origin_diagnosis_icd AS disease_origin_diagnosis_icd,

					diseasecase.created_at AS diseasecase_created_date, 

					diseasecase.medical_description AS diseasecase_medical_description,
					diseasecase.description AS diseasecase_description,

        FROM
					`sofia-data-305018.backend_db_20240702.services_diseasecase` AS diseasecase
        WHERE
					diseasecase.id IS NOT NULL
					AND diseasecase.member_id IS NOT NULL
					AND (diseasecase.description != 'None' OR diseasecase.description IS NOT NULL)
    ),
    events_db AS (
        SELECT
					caseevent.member_id,
					caseevent.disease_case_id,
					caseevent.id AS case_event_id,
					caseevent.origin_diagnosis_icd AS case_event_origin_diagnosis_icd,

					caseevent.created_at AS caseevent_created_date,
					caseevent.occurrence_date AS caseevent_occurrence_date, 
					caseevent.pause_start_date AS caseevent_pause_start_date,
          caseevent.discharge_start_date AS caseevent_discharge_start_date, 
          caseevent.medical_monitoring_date AS caseevent_medical_monitoring_date, 
          caseevent.invoice_id AS caseevent_invoice_id,
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
					caseevent.category AS caseevent_category,
					caseevent.event_class AS caseevent_class,

					caseevent.discharge_ruling_notes AS caseevent_discharge_ruling_notes,
					caseevent.administrative_ruling_notes AS caseevent_administrative_ruling_notes,
					caseevent.description AS caseevent_description,
					caseevent.medical_pre_dictamination_notes AS caseevent_medical_pre_dictamination_notes,
					caseevent.internal_notes AS caseevent_internal_notes,
					caseevent.requested_partner_doctor_info AS caseevent_requested_partner_doctor_info,
					caseevent.relevant_history AS caseevent_relevant_history,    
					caseevent.discharge_reason AS caseevent_discharge_reason,
					caseevent.quote_and_scheduling_ruling_notes AS caseevent_quote_and_scheduling_ruling_notes,
					caseevent.medical_procedure_ruling_notes AS caseevent_medical_procedure_ruling_notes,

					eventcomment.author_id AS eventcomment_author_id, -- author_id sabios medicos
					eventcomment.created_at AS eventcomment_created_date,
					eventcomment.comment AS eventcomment_comments,

					caseeventsummary.author_id AS caseeventsummary_author_id, -- author_id sabios medicos
					caseeventsummary.created_at AS caseeventsummary_created_date,
					caseeventsummary.category AS caseeventsummary_category,
					caseeventsummary.assessment AS caseeventsummary_assessment,

					caseeventfinalletterdata.created_at AS caseeventfinalletterdata_created_date,
					caseeventfinalletterdata.cie_codes AS caseeventfinalletterdata_cie_codes,
					caseeventfinalletterdata.cie_descriptions AS caseeventfinalletterdata_cie_descriptions,
					caseeventfinalletterdata.cpt_codes AS caseeventfinalletterdata_cpt_codes,
					caseeventfinalletterdata.cpt_descriptions AS caseeventfinalletterdata_cpt_descriptions,
					caseeventfinalletterdata.observations AS caseeventfinalletterdata_observations,

					-- Ver en que parte del proceso esta el caso: falta dictaminacion administrativa, predictaminacion medica (ver si va o no)
						-- Si se acepta, cotizacion y programacion del evento (en el caso que lo necesite)
						-- Programacion 
						-- Esto esta en caseevent_state

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
					services.member_id,
					services.id AS service_id,
					services.disease_case_id,
					services.case_event_id,
					services.related_service_id AS services_related_service_id, -- servicio padre (todos los servicios de medicamentos y estudios de laboratorio este campo permite ver el origen de tales servicios)
					services.health_plan_id AS services_health_plan_id,
					--services.uuid AS services_uuid, -- eliminar por que es solo relevante para facturacion 
					services.cpt AS services_cpt,
					services.diagnosis_icd AS services_diagnosis_icd,
					services.provided_by_object_id AS services_provided_by_object_id, -- proveedor doctor, doctor amigo o farmacia-clinica-hospitales
					services.provided_by_content_type_id AS services_provided_by_content_type_id, -- tipo de proveedor

					services.created_at AS services_created_date,
					services.occurrence_date AS services_occurrence_date, -- fecha correcta del servicio ejecutado

					--services.closed AS --services_closed, -- sin uso (eliminar)
					services.process_state AS services_process_state, -- en que parte del proceso del servicio esta
					--services.automatic_ruling_score AS --services_automatic_ruling_score, -- para dictaminacion automatica (no utilidad para este proyecto)
					--services.suggested_ruling_state AS --services_suggested_ruling_state, -- para dictaminacion automatica (no tiene tanta utilidad para este proyecto)
					services.evidence_state_flags AS services_evidence_state_flags, -- Si esta aceptado o rechazada la evidencia 

					services.service_type_value AS services_service_type_value,
					services.scheduled AS services_scheduled,
					--services.ruling_difficulty AS services_ruling_difficulty, -- lo mismo de arriva
					services.assigned_to_id AS services_assigned_to_id, -- sabios medicos
					services.coverage_tag AS services_coverage_tag, -- se usa en actuaria para ver si es cobertura de gastos medicos medicos mayores, medicamentos, vacunas, ...

					services.diagnosis_description AS services_diagnosis_description,
					services.comments AS services_comments,
					services.service_description AS services_service_description,
					services.specification AS services_specification,
					services.medical_recommendation_notes AS services_medical_recommendation_notes,

					servicecomment.author_id AS servicecomment_author_id, -- sabios medicos
					servicecomment.created_at AS servicecomment_created_date,
					servicecomment.comment AS servicecomment_comments

        FROM
            `sofia-data-305018.backend_db_20240702.services_service` AS services
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.services_servicecomment` AS servicecomment
        ON services.id = servicecomment.service_id
        WHERE   
            services.member_id IS NOT NULL
            AND services.id IS NOT NULL
            AND services.disease_case_id IS NOT NULL
            AND services.health_plan_id IS NOT NULL
            --AND services.uuid IS NOT NULL
            AND services.deleted IS NULL
            AND (servicecomment.deleted = 'None' OR servicecomment.deleted IS NULL)
            AND process_state != 'CANCELLED'
    )


SELECT
	member_id_from_event, member_id_from_service,
	diseasecase_db_for_event.member_id AS member_id_from_dc_for_event,
	diseasecase_db_for_service.member_id AS member_id_from_dc_for_service,
	IF(caseevent_created_date IS NOT NULL, diseasecase_db_for_event.member_id, diseasecase_db_for_service.member_id) AS member_id,
	service_id,

	case_event_id_from_event AS case_event_id,
	case_event_id_from_service,
	disease_case_id_from_event, disease_case_id_from_service,
	IF(caseevent_created_date IS NOT NULL, disease_case_id_from_event, disease_case_id_from_service) AS disease_case_id,

	services_related_service_id,
	services_health_plan_id,
  caseevent_invoice_id,
	--services_uuid,

	services_cpt,
	services_diagnosis_icd,
	services_provided_by_object_id,
	services_provided_by_content_type_id,

	-- Event tiene prioridad en definir el diagnostico de origen
	diseasecase_db_for_event.disease_origin_diagnosis_icd AS disease_origin_diagnosis_icd_for_event, 
	diseasecase_db_for_service.disease_origin_diagnosis_icd AS disease_origin_diagnosis_icd_for_service,
	IF(caseevent_created_date IS NOT NULL, diseasecase_db_for_event.disease_origin_diagnosis_icd, diseasecase_db_for_service.disease_origin_diagnosis_icd) AS disease_origin_diagnosis_icd,
	case_event_origin_diagnosis_icd
	caseeventfinalletterdata_cie_codes,
	caseeventfinalletterdata_cie_descriptions,
	caseeventfinalletterdata_cpt_codes,
	caseeventfinalletterdata_cpt_descriptions,
	caseeventfinalletterdata_observations,
	diseasecase_db_for_event.diseasecase_medical_description AS diseasecase_medical_description_for_event,
	diseasecase_db_for_service.diseasecase_medical_description AS diseasecase_medical_description_for_service,
	IF(caseevent_created_date IS NOT NULL, diseasecase_db_for_event.diseasecase_medical_description, diseasecase_db_for_service.diseasecase_medical_description) AS diseasecase_medical_description,
	diseasecase_db_for_event.diseasecase_description AS diseasecase_description_for_event,
	diseasecase_db_for_service.diseasecase_description AS diseasecase_description_for_service,
	IF(caseevent_created_date IS NOT NULL, diseasecase_db_for_event.diseasecase_description, diseasecase_db_for_service.diseasecase_description) AS diseasecase_description,
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
  caseevent_occurrence_date,
	caseevent_pause_start_date,
  caseevent_discharge_start_date,
  caseevent_medical_monitoring_date,
	eventcomment_created_date,
	caseeventsummary_created_date,
	caseeventfinalletterdata_created_date,
	diseasecase_db_for_event.diseasecase_created_date AS diseasecase_created_date_for_event,
	diseasecase_db_for_service.diseasecase_created_date AS diseasecase_created_date_for_service,
	IF(caseevent_created_date IS NOT NULL, diseasecase_db_for_event.diseasecase_created_date, diseasecase_db_for_service.diseasecase_created_date) AS diseasecase_created_date,

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
	services_process_state,
	----services_automatic_ruling_score,
	----services_suggested_ruling_state,
	services_evidence_state_flags,

	services_service_type_value,
	services_scheduled,
	--services_ruling_difficulty,
	services_assigned_to_id,
	services_coverage_tag,

FROM(
  SELECT
		services_db.member_id	AS member_id_from_service,
		service_id,
		services_db.disease_case_id AS disease_case_id_from_service,
		services_db.case_event_id AS case_event_id_from_service,

    events_db.member_id AS member_id_from_event,
		events_db.disease_case_id AS disease_case_id_from_event,
		events_db.case_event_id AS case_event_id_from_event,
		events_db.case_event_origin_diagnosis_icd,

		events_db.caseevent_created_date,
		events_db.caseevent_occurrence_date,
		events_db.caseevent_pause_start_date,
    events_db.caseevent_discharge_start_date,
    events_db.caseevent_medical_monitoring_date,

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
		events_db.eventcomment_created_date,
		events_db.eventcomment_comments,

		events_db.caseeventsummary_author_id,
		events_db.caseeventsummary_created_date,
		events_db.caseeventsummary_category,
		events_db.caseeventsummary_assessment,

		events_db.caseeventfinalletterdata_created_date,
		events_db.caseeventfinalletterdata_cie_codes,
		events_db.caseeventfinalletterdata_cie_descriptions,
		events_db.caseeventfinalletterdata_cpt_codes,
		events_db.caseeventfinalletterdata_cpt_descriptions,
		events_db.caseeventfinalletterdata_observations,

		services_db.services_related_service_id,
		services_db.services_health_plan_id,
		--services_db.services_uuid,
		services_db.services_cpt,
		services_db.services_diagnosis_icd,
		services_db.services_provided_by_object_id,
		services_db.services_provided_by_content_type_id,

		services_db.services_created_date,
		services_db.services_occurrence_date,

		--services_db.services_closed,
		services_db.services_process_state,
		--services_db.services_automatic_ruling_score,
		--services_db.services_suggested_ruling_state,
		services_db.services_evidence_state_flags,

		services_db.services_service_type_value,
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
		services_db.servicecomment_created_date,
		services_db.servicecomment_comments,
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
--  AND member_id IS NOT NULL
--  AND disease_case_id IS NOT NULL
--  AND diseasecase_db.disease_case_id IS NOT NULL
--  AND disease_case_id = diseasecase_db.disease_case_id
--  AND (case_event_id = case_event_id_from_event OR (case_event_id IS NULL AND case_event_id_from_event IS NULL))

