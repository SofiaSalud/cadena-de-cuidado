CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.services_events_diseases_socios` AS 

WITH    
    diseasecase_db AS (
        SELECT
            diseasecase.id AS disease_case_id, 
            diseasecase.member_id,
            diseasecase.origin_diagnosis_icd AS disease_origin_diagnosis_icd,

            diseasecase.updated_at AS diseasecase_date,

            diseasecase.medical_description,
            diseasecase.description AS diseasecase_description

        FROM
            `sofia-data-305018.backend_db_20240702.services_diseasecase` AS diseasecase
        WHERE
            diseasecase.id IS NOT NULL
            AND diseasecase.member_id IS NOT NULL
    ),
    events_db AS (
        SELECT
            caseevent.member_id,
            caseevent.disease_case_id,
            caseevent.id AS case_event_id,
            caseevent.origin_diagnosis_icd AS case_event_origin_diagnosis_icd,

            caseevent.updated_at AS caseevent_date,

            caseevent.occurrence_date AS caseevent_occurrence_date,

            caseevent.state,
            caseevent.medically_justified,

            caseevent.stage,
            caseevent.member_stage,
            caseevent.category AS caseevent_category,
            caseevent.event_class,

            caseevent.medical_pre_dictamination_notes,
            caseevent.discharge_ruling_notes,
            caseevent.administrative_ruling_notes,
            caseevent.description AS caseevent_description,
            caseevent.medical_pre_dictamination_notes AS caseevent_medical_pre_dictamination_notes,
            caseevent.internal_notes,
            caseevent.requested_partner_doctor_info,
            caseevent.relevant_history,    
            caseevent.discharge_reason,
            caseevent.quote_and_scheduling_ruling_notes,
            caseevent.medical_procedure_ruling_notes,

            eventcomment.author_id AS eventcomment_author_id,
            eventcomment.updated_at AS eventcomment_date,
            eventcomment.comment AS eventcomment_comments,

            caseeventsummary.author_id AS caseeventsummary_author_id,
            caseeventsummary.updated_at AS caseeventsummary_date,
            caseeventsummary.category AS caseeventsummary_category,
            caseeventsummary.assessment,

            caseeventfinalletterdata.updated_at AS caseeventfinalletterdata_date,
            caseeventfinalletterdata.cie_codes,
            caseeventfinalletterdata.cie_descriptions,
            caseeventfinalletterdata.cpt_codes,
            caseeventfinalletterdata.cpt_descriptions,
            caseeventfinalletterdata.observations,

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
            services.related_service_id,
            services.health_plan_id,
            services.uuid,
            services.cpt,
            services.diagnosis_icd,
            services.provided_by_object_id,
            services.provided_by_content_type_id,

            services.updated_at AS services_date,
            services.occurrence_date AS services_occurrence_date,

            services.closed,
            services.process_state,
            services.automatic_ruling_score,
            services.suggested_ruling_state,
            services.evidence_state_flags,

            services.service_type_value,
            --services.external_provider,

            services.diagnosis_description,
            services.comments AS services_comments,
            services.service_description,
            services.specification,
            services.medical_recommendation_notes,

            servicecomment.author_id AS servicecomment_author_id,
            servicecomment.updated_at AS servicecomment_date,
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
            AND services.uuid IS NOT NULL
            AND services.deleted IS NULL
            AND (servicecomment.deleted = 'None' OR servicecomment.deleted IS NULL)
            AND process_state != 'CANCELLED'
    )


SELECT
  -- ID
  member_id,
  service_id,
  disease_case_id,
  disease_case_id_from_event,
  diseasecase_db.disease_case_id AS disease_case_id_from_dc,
  case_event_id,
  case_event_id_from_event,
  related_service_id,
  health_plan_id,
  servicecomment_author_id,
  eventcomment_author_id,
  caseeventsummary_author_id,
  uuid,
  provided_by_object_id,
  provided_by_content_type_id,

  -- Disease
  cpt,
  diagnosis_icd,
  case_event_origin_diagnosis_icd,
  diseasecase_db.disease_origin_diagnosis_icd,
  cie_codes,
  cie_descriptions,
  cpt_codes,
  cpt_descriptions,

  -- Date
  services_date,
  services_occurrence_date,
  servicecomment_date,
  caseevent_date,
  caseevent_occurrence_date,
  eventcomment_date,
  caseeventsummary_date,
  caseeventfinalletterdata_date,
  diseasecase_db.diseasecase_date,

  -- State
  process_state,
  state,
  medically_justified,
  stage,
  member_stage,
  closed,
  automatic_ruling_score,
  suggested_ruling_state,

  -- Categories
  service_type_value,
  caseevent_category,
  event_class,
  caseeventsummary_category,

  -- Text
  diagnosis_description,
  services_comments,
  service_description,
  specification,
  medical_recommendation_notes,
  servicecomment_comments,
  eventcomment_comments,
  observations,
  diseasecase_db.medical_description,
  diseasecase_db.diseasecase_description,

  -- Other
  assessment,
  medical_pre_dictamination_notes,
  discharge_ruling_notes,
  administrative_ruling_notes,
  caseevent_description,
  internal_notes,
  requested_partner_doctor_info,
  relevant_history,    
  discharge_reason,
  quote_and_scheduling_ruling_notes,
  medical_procedure_ruling_notes
FROM(
  SELECT
    -- ID
    services_db.member_id,
    services_db.service_id,
    services_db.disease_case_id,
    events_db.disease_case_id AS disease_case_id_from_event,
    services_db.case_event_id,
    events_db.case_event_id AS case_event_id_from_event,
    services_db.related_service_id,
    services_db.health_plan_id,
    services_db.servicecomment_author_id,
    events_db.eventcomment_author_id,
    events_db.caseeventsummary_author_id,
    services_db.uuid,
    services_db.provided_by_object_id,
    services_db.provided_by_content_type_id,

    -- Disease
    services_db.cpt,
    services_db.diagnosis_icd,
    events_db.case_event_origin_diagnosis_icd,
    events_db.cie_codes,
    events_db.cie_descriptions,
    events_db.cpt_codes,
    events_db.cpt_descriptions,

    -- Date
    services_db.services_date,
    services_db.services_occurrence_date,
    services_db.servicecomment_date,
    events_db.caseevent_date,
    events_db.caseevent_occurrence_date,
    events_db.eventcomment_date,
    events_db.caseeventsummary_date,
    events_db.caseeventfinalletterdata_date,

    -- State
    services_db.process_state,
    events_db.state,
    events_db.medically_justified,
    events_db.stage,
    events_db.member_stage,
    services_db.closed,
    services_db.automatic_ruling_score,
    services_db.suggested_ruling_state,

    -- Categories
    services_db.service_type_value,
    events_db.caseevent_category,
    events_db.event_class,
    events_db.caseeventsummary_category,

    -- Text
    services_db.diagnosis_description,
    services_db.services_comments,
    services_db.service_description,
    services_db.specification,
    services_db.medical_recommendation_notes,
    services_db.servicecomment_comments,
    events_db.eventcomment_comments,
    events_db.observations,

    -- Other
    events_db.assessment,
    events_db.medical_pre_dictamination_notes,
    events_db.discharge_ruling_notes,
    events_db.administrative_ruling_notes,
    events_db.caseevent_description,
    events_db.internal_notes,
    events_db.requested_partner_doctor_info,
    events_db.relevant_history,    
    events_db.discharge_reason,
    events_db.quote_and_scheduling_ruling_notes,
    events_db.medical_procedure_ruling_notes
  FROM
      services_db
  FULL JOIN
      events_db
  USING(member_id, case_event_id)
)
FULL JOIN
    diseasecase_db
USING(member_id, disease_case_id)
WHERE
  member_id IS NOT NULL
  AND service_id IS NOT NULL
  AND disease_case_id IS NOT NULL
  AND diseasecase_db.disease_case_id IS NOT NULL
  AND disease_case_id = diseasecase_db.disease_case_id
  AND (case_event_id = case_event_id_from_event OR (case_event_id IS NULL AND case_event_id_from_event IS NULL))
