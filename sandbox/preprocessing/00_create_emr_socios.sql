CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.emr_socios` AS 

WITH    
    emr_member_med_notes AS (
        SELECT DISTINCT
            med_note.member_id AS member_id,
            med_note.service_id AS service_id,
            med_note.disease_case_id AS disease_case_id,
            scheduledprocedure.case_event_id,
            med_note.id AS medical_note_id,
            exam.medical_history_id AS medical_history_id,
            med_note.uuid,

            providers_doctor.descriptor AS doctor_specialization,

            med_note.updated_at AS med_note_date,
            med_note.note_type AS med_note_type,
            med_note.motive AS med_note_motive,
            med_note.suffering,
            med_note.state, --COMPLETED, CLOSED, OPEN, CANCELLED

            med_explo.notes AS med_explo_notes,
            med_explo.segment_name AS med_explo_segment_name,
            med_explo.segment AS med_explo_segment,

            exam_physical.updated_at AS exam_physical_date,
            exam_physical.notes AS exam_physical_notes,

            exam.updated_at AS exam_date,
            exam.notes AS exam_notes,

            exam_obstetric.updated_at AS exam_obstetric_date,
            exam_obstetric.has_gynecological_exams,
            exam_obstetric.has_been_pregnant,
            exam_obstetric.has_menstrual_cycle,
            exam_obstetric.has_birth_control,
            
            addendum.updated_at AS addendum_date,
            addendum.notes AS addendum_notes,

            interrogation.updated_at AS interrogation_date,
            interrogation.notes AS interrogation_notes,
            interrogation.system AS interrogation_system,
            interrogation.system_name AS interrogation_system_name,

            scheduledprocedure.updated_at AS  scheduledprocedure_date,
            scheduledprocedure.is_urgent AS scheduledprocedure_is_urgent,
            scheduledprocedure.in_hospital AS scheduledprocedure_in_hospital,
            scheduledprocedure.medical_reason AS scheduledprocedure_medical_reason,
            scheduledprocedure.procedure_name AS scheduledprocedure_procedure_name,
            scheduledprocedure.has_extra_requirements AS scheduledprocedure_has_extra_requirements,
            scheduledprocedure.extra_requirements AS scheduledprocedure_extra_requirements,
            scheduledprocedure.stay_days AS scheduledprocedure_stay_days,
            emr_procedurecategory.name AS procedurecategory_name,
            emr_procedurecategory.description AS procedurecategory_description,
            emr_procedurecategory.is_scheduled AS procedurecategory_is_scheduled,
            emr_procedurecategory.type AS procedurecategory_type,
            emr_procedurecategory.cpt_key AS procedurecategory_cpt_key,
            providers_medicalspecialization.name AS providers_medicalspecialization_name,
            providers_medicalspecialization.description AS providers_medicalspecialization_description,
            providers_medicalspecialization.type AS providers_medicalspecialization_type,
            providers_medicalspecialization.is_primary_care AS providers_medicalspecialization_is_primary_care,

            dischargeinfo.updated_at AS dischargeinfo_date,
            dischargeinfo.discharge_date AS discharge_date,
            dischargeinfo.visits_amount AS dischargeinfo_visits_amount,
            dischargeinfo.stay_summary AS dischargeinfo_stay_summary,
            dischargeinfo.evolution AS dischargeinfo_evolution,
            dischargeinfo.discharge_reason AS dischargeinfo_discharge_reason,

            evaluation.updated_at AS evaluation_date,
            evaluation.cie_keys AS evaluation_cie_keys,
            evaluation.diagnostics AS evaluation_diagnostics,
            evaluation.diagnostic_impression AS evaluation_diagnostic_impression,
            evaluation.notes AS evaluation_notes,

            medical_procedure.updated_at AS medical_procedure_date,
            medical_procedure.name AS medical_procedure_name,
            medical_procedure.procedure AS medical_procedure,
            medical_procedure.description AS medical_procedure_description,
            medical_procedure.pathology_sending_required AS medical_procedure_pathology_sending_required
        FROM    
            `sofia-data-305018.backend_db_20240702.emr_medicalnote` AS med_note
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.providers_doctor` AS providers_doctor
        ON med_note.doctor_id = providers_doctor.id
	    LEFT JOIN 
            `sofia-data-305018.backend_db_20240702.providers_doctorspecialistdetail` AS providers_doctorspecialistdetail 
        ON providers_doctorspecialistdetail.doctor_id = providers_doctor.id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_exploration` AS med_explo
        ON med_note.id = med_explo.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_physicalexam` AS exam_physical
        ON med_note.id = exam_physical.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_exam` AS exam
        ON med_note.id = exam.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_obstetricgynecologicalinfo` AS exam_obstetric
        ON med_note.id = exam_obstetric.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_addendum` AS addendum
        ON med_note.id = addendum.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_interrogation` AS interrogation
        ON med_note.id = interrogation.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_scheduledprocedure` AS scheduledprocedure
        ON med_note.id = scheduledprocedure.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_procedurecategory` AS emr_procedurecategory
        ON emr_procedurecategory.id = scheduledprocedure.procedure_category_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.providers_medicalspecialization` AS providers_medicalspecialization 
        ON providers_medicalspecialization.id = emr_procedurecategory.medical_specialization_id AND providers_medicalspecialization.id = providers_doctorspecialistdetail.medical_specialization_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_dischargeinfo` AS dischargeinfo
        ON med_note.id = dischargeinfo.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_evaluation` AS evaluation
        ON med_note.id = evaluation.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_procedure` AS medical_procedure
        ON med_note.id = medical_procedure.medical_note_id
        WHERE       
            service_id IS NOT NULL
            AND disease_case_id IS NOT NULL
            AND med_note.id IS NOT NULL
            AND medical_history_id IS NOT NULL
            AND med_note.uuid IS NOT NULL
            AND (med_note.deleted = 'None' OR med_note.deleted IS NULL)
            AND (providers_doctor.deleted = 'None' OR providers_doctor.deleted IS NULL)
            AND providers_doctorspecialistdetail.deleted IS NULL
            AND med_explo.deleted IS NULL
            AND scheduledprocedure.deleted IS NULL
            AND exam.deleted IS NULL
            AND addendum.deleted IS NULL
            AND interrogation.deleted IS NULL
            AND (exam_physical.deleted = 'None' OR exam_physical.deleted IS NULL)
            AND (exam_obstetric.deleted = 'None' OR exam_obstetric.deleted IS NULL)
            AND (emr_procedurecategory.deleted = 'None' OR emr_procedurecategory.deleted IS NULL)
            AND providers_medicalspecialization.deleted IS NULL
            AND (evaluation.deleted = 'None' OR evaluation.deleted IS NULL)
            AND (medical_procedure.deleted = 'None' OR medical_procedure.deleted IS NULL)
            AND (dischargeinfo.deleted = 'None' OR dischargeinfo.deleted IS NULL)
    ),
    consult_prescription AS (
        SELECT DISTINCT
            member_id,
            medical_note_id,
            updated_at AS consult_prescription_date,
            has_antibiotics,
            member_name,
            doctor_name,
            license_number,
            prescription_items_json,
            diagnosis,
            license_institution,
            specialist_institution,
            specialist_number,
            specialization,
            recommendations,
            signed,

            prescription_items_member_checks,
            references_check,
            checkups_check,
            labs_check,
            medicines_check,
            urgencies_check
            
        FROM
            `sofia-data-305018.backend_db_20240702.consult_prescription`
        WHERE
            member_id IS NOT NULL
            AND medical_note_id IS NOT NULL
            AND deleted IS NULL
    ),
    med_history AS (
        SELECT DISTINCT
            id AS medical_history_id,
            member_id,
            updated_at AS med_history_date,
            therapy_notes,
            last_huli_sync_snapshot,
            has_therapy,
            --non_pathological_history_id,
            pathologies_notes,
            pathologies_state,
            surgeries_notes,
            surgeries_state,
            vaccines_notes,
            vaccines_state,
            hospitalizations_notes,
            hospitalizations_state,
            allergies_notes,
            allergies_state,
            malformations_notes,
            malformations_state,
            family_pathologies_notes,
            family_pathologies_state,
            mental_health_psychology_notes,
            mental_health_psychology_state,
            mental_health_psychiatry_notes,
            mental_health_psychiatry_state,
            medicines_notes,
            health_summary
            
        FROM    
            `sofia-data-305018.backend_db_20240702.emr_medicalhistory`
        WHERE
            member_id IS NOT NULL
            AND id IS NOT NULL
            AND deleted IS NULL
    )

SELECT 
    -- ID
    member_id,
    disease_case_id,
    case_event_id,
    service_id,
    uuid AS med_note_uuid,

    --member_name,
    --doctor_name,
    --license_number,
    --license_institution,
    --specialist_institution,
    --specialist_number,

    -- Diseases
    diagnosis,
    evaluation_cie_keys,
    evaluation_diagnostics,
    evaluation_diagnostic_impression,
    specialization,
    interrogation_system,
    interrogation_system_name,
    interrogation_notes,
    exam_notes,

    -- Dates
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

    -- Categories, Names
    med_note_type,
    med_note_motive,
    state,
    med_explo_segment_name,
    med_explo_segment,
    scheduledprocedure_procedure_name,
    medical_procedure_name,
    medical_procedure,
    pathologies_state,
    surgeries_state,
    vaccines_state,
    hospitalizations_state,
    allergies_state,
    malformations_state,
    family_pathologies_state,
    mental_health_psychology_state,
    mental_health_psychiatry_state,
    signed,
    doctor_specialization,

    -- Dichotomous, Values
    has_gynecological_exams,
    has_been_pregnant,
    has_menstrual_cycle,
    has_birth_control,
    has_therapy,
    has_antibiotics,
    scheduledprocedure_is_urgent,
    scheduledprocedure_in_hospital,
    scheduledprocedure_has_extra_requirements,
    dischargeinfo_visits_amount,

    -- Text
    health_summary,
    recommendations,
    suffering,
    med_explo_notes,
    exam_physical_notes,
    addendum_notes,
    therapy_notes,
    pathologies_notes,
    surgeries_notes,
    vaccines_notes,
    hospitalizations_notes,
    allergies_notes,
    malformations_notes,
    family_pathologies_notes,
    mental_health_psychology_notes,
    mental_health_psychiatry_notes,
    medicines_notes,
    evaluation_notes,
    scheduledprocedure_medical_reason,
    scheduledprocedure_extra_requirements,
    dischargeinfo_stay_summary,
    dischargeinfo_evolution,
    dischargeinfo_discharge_reason,
    medical_procedure_description,

    -- Procedures
    procedurecategory_name,
    procedurecategory_description,
    procedurecategory_is_scheduled,
    procedurecategory_type,
    procedurecategory_cpt_key,
    providers_medicalspecialization_name,
    providers_medicalspecialization_description,
    providers_medicalspecialization_type,
    providers_medicalspecialization_is_primary_care,
    
    -- Raw
    last_huli_sync_snapshot,
    prescription_items_json,
    prescription_items_member_checks,

    -- Other
    medical_procedure_pathology_sending_required,
    references_check, 
    checkups_check,
    labs_check, 
    medicines_check, 
    urgencies_check 

FROM
    emr_member_med_notes
FULL JOIN
    med_history
USING(member_id, medical_history_id)
LEFT JOIN
    consult_prescription
USING(member_id, medical_note_id)
