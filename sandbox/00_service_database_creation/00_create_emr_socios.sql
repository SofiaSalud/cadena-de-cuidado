CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.emr_socios` AS 

WITH    
    dr_specializations AS (
        SELECT
            doctor_id,
            ARRAY_TO_STRING(ARRAY_AGG(DISTINCT pdms.name IGNORE NULLS), ', ') AS doctor_specializations,
            ARRAY_TO_STRING(ARRAY_AGG(DISTINCT pdms.description IGNORE NULLS), ', ') AS doctor_specializations_description,
            ARRAY_TO_STRING(ARRAY_AGG(DISTINCT pdms.type IGNORE NULLS), ', ') AS doctor_specializations_type,
            MAX(pdms.is_primary_care) AS doctor_specializations_is_primary_care,

        FROM 
            `sofia-data-305018.backend_db_20240702.providers_doctorspecialistdetail` AS sp
        LEFT JOIN 
            `sofia-data-305018.backend_db_20240702.providers_medicalspecialization` AS pdms 
        ON pdms.id = sp.medical_specialization_id
        WHERE
            sp.deleted IS NULL
            AND pdms.deleted IS NULL
        GROUP BY doctor_id
    ),
    scheduledprocedure_db AS (
        SELECT
            MAX_BY(case_event_id, updated_at) AS case_event_id,
            MAX_BY(updated_at, updated_at) AS updated_at,
            MAX_BY(is_urgent, updated_at) AS is_urgent,
            MAX_BY(in_hospital, updated_at) AS in_hospital,
            MAX_BY(medical_reason, updated_at) AS medical_reason,
            MAX_BY(procedure_name, updated_at) AS procedure_name,
            MAX_BY(has_extra_requirements, updated_at) AS has_extra_requirements,
            MAX_BY(extra_requirements, updated_at) AS extra_requirements,
            MAX_BY(stay_days, updated_at) AS stay_days,
            MAX_BY(medical_note_id, updated_at) AS medical_note_id,
            MAX_BY(procedure_category_id, updated_at) AS procedure_category_id,
            
        FROM
            `sofia-data-305018.backend_db_20240702.emr_scheduledprocedure`
        WHERE   
            deleted IS NULL
    ),
    emr_member_med_notes AS (
        SELECT DISTINCT
            med_note.member_id AS member_id,
            med_note.service_id AS service_id,
            med_note.disease_case_id AS disease_case_id,
            scheduledprocedure_db.case_event_id,
            med_note.id AS medical_note_id,
            exam.medical_history_id AS medical_history_id,
            --med_note.uuid,

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

            scheduledprocedure_db.updated_at AS  scheduledprocedure_date,
            scheduledprocedure_db.is_urgent AS scheduledprocedure_is_urgent,
            scheduledprocedure_db.in_hospital AS scheduledprocedure_in_hospital,
            scheduledprocedure_db.medical_reason AS scheduledprocedure_medical_reason,
            scheduledprocedure_db.procedure_name AS scheduledprocedure_procedure_name,
            scheduledprocedure_db.has_extra_requirements AS scheduledprocedure_has_extra_requirements,
            scheduledprocedure_db.extra_requirements AS scheduledprocedure_extra_requirements,
            scheduledprocedure_db.stay_days AS scheduledprocedure_stay_days,
            emr_procedurecategory.name AS procedurecategory_name,
            emr_procedurecategory.description AS procedurecategory_description,
            emr_procedurecategory.is_scheduled AS procedurecategory_is_scheduled,
            emr_procedurecategory.type AS procedurecategory_type,
            emr_procedurecategory.cpt_key AS procedurecategory_cpt_key,
            doctor_specializations,
            doctor_specializations_description,
            doctor_specializations_type,
            doctor_specializations_is_primary_care,

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
            -- proveedor solo es medico porque es el que describe la nota medica

        FROM    
            `sofia-data-305018.backend_db_20240702.emr_medicalnote` AS med_note
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.providers_doctor` AS providers_doctor
        ON med_note.doctor_id = providers_doctor.id 
	    LEFT JOIN 
            dr_specializations
        ON dr_specializations.doctor_id = providers_doctor.id
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
            `sofia-data-305018.backend_db_20240702.emr_addendum` AS addendum -- Verificar
        ON med_note.id = addendum.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_interrogation` AS interrogation
        ON med_note.id = interrogation.medical_note_id
        LEFT JOIN
            scheduledprocedure_db
        ON med_note.id = scheduledprocedure_db.medical_note_id
        LEFT JOIN
            `sofia-data-305018.backend_db_20240702.emr_procedurecategory` AS emr_procedurecategory
        ON emr_procedurecategory.id = scheduledprocedure_db.procedure_category_id
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
            AND med_note.deleted = 'None'
            AND (providers_doctor.deleted = 'None' OR providers_doctor.deleted IS NULL)
            AND med_explo.deleted IS NULL
            AND exam.deleted IS NULL
            AND addendum.deleted IS NULL
            AND interrogation.deleted IS NULL
            AND (exam_physical.deleted = 'None' OR exam_physical.deleted IS NULL)
            AND (exam_obstetric.deleted = 'None' OR exam_obstetric.deleted IS NULL)
            AND (emr_procedurecategory.deleted = 'None' OR emr_procedurecategory.deleted IS NULL)
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
    med_notes.member_id,
    med_notes.disease_case_id,
    med_notes.case_event_id,
    med_notes.service_id,
    ----med_notes.med_note_uuid,

    --member_name,
    --doctor_name,
    --license_number,
    --license_institution,
    --specialist_institution,
    --specialist_number,

    -- Diseases
    consult_prescription.diagnosis,
    med_notes.evaluation_cie_keys,
    med_notes.evaluation_diagnostics,
    med_notes.evaluation_diagnostic_impression,
    consult_prescription.specialization,
    med_notes.interrogation_system,
    med_notes.interrogation_system_name,
    med_notes.interrogation_notes,
    med_notes.exam_notes,

    -- Dates
    med_notes.med_note_date,
    med_notes.exam_physical_date,
    med_notes.exam_date,
    med_notes.exam_obstetric_date,
    med_notes.addendum_date,
    med_notes.interrogation_date,
    med_notes.scheduledprocedure_date,
    med_notes.dischargeinfo_date,
    med_notes.discharge_date,
    med_notes.evaluation_date,
    med_notes.medical_procedure_date,
    consult_prescription.consult_prescription_date,
    med_notes.med_history_date,

    -- Categories, Names
    med_notes.med_note_type,
    med_notes.med_note_motive,
    med_notes.state,
    med_notes.med_explo_segment_name,
    med_notes.med_explo_segment,
    med_notes.scheduledprocedure_procedure_name,
    med_notes.medical_procedure_name,
    med_notes.medical_procedure,
    med_notes.pathologies_state,
    med_notes.surgeries_state,
    med_notes.vaccines_state,
    med_notes.hospitalizations_state,
    med_notes.allergies_state,
    med_notes.malformations_state,
    med_notes.family_pathologies_state,
    med_notes.mental_health_psychology_state,
    med_notes.mental_health_psychiatry_state,
    consult_prescription.signed,
    med_notes.doctor_specializations,
    med_notes.doctor_specializations_description,
    med_notes.doctor_specializations_type,
    med_notes.doctor_specializations_is_primary_care,

    -- Dichotomous, Values
    med_notes.has_gynecological_exams,
    med_notes.has_been_pregnant,
    med_notes.has_menstrual_cycle,
    med_notes.has_birth_control,
    med_notes.has_therapy,
    consult_prescription.has_antibiotics,
    med_notes.scheduledprocedure_is_urgent,
    med_notes.scheduledprocedure_in_hospital,
    med_notes.scheduledprocedure_has_extra_requirements,
    med_notes.dischargeinfo_visits_amount,

    -- Text
    med_notes.health_summary,
    consult_prescription.recommendations,
    med_notes.suffering,
    med_notes.med_explo_notes,
    med_notes.exam_physical_notes,
    med_notes.addendum_notes,
    med_notes.therapy_notes,
    med_notes.pathologies_notes,
    med_notes.surgeries_notes,
    med_notes.vaccines_notes,
    med_notes.hospitalizations_notes,
    med_notes.allergies_notes,
    med_notes.malformations_notes,
    med_notes.family_pathologies_notes,
    med_notes.mental_health_psychology_notes,
    med_notes.mental_health_psychiatry_notes,
    med_notes.medicines_notes,
    med_notes.evaluation_notes,
    med_notes.scheduledprocedure_medical_reason,
    med_notes.scheduledprocedure_extra_requirements,
    med_notes.dischargeinfo_stay_summary,
    med_notes.dischargeinfo_evolution,
    med_notes.dischargeinfo_discharge_reason,
    med_notes.medical_procedure_description,

    -- Procedures
    med_notes.procedurecategory_name,
    med_notes.procedurecategory_description,
    med_notes.procedurecategory_is_scheduled,
    med_notes.procedurecategory_type,
    med_notes.procedurecategory_cpt_key,

    -- Raw
    med_notes.last_huli_sync_snapshot,
    consult_prescription.prescription_items_json,
    consult_prescription.prescription_items_member_checks,

    -- Other
    med_notes.medical_procedure_pathology_sending_required,
    consult_prescription.references_check, 
    consult_prescription.checkups_check,
    consult_prescription.labs_check, 
    consult_prescription.medicines_check, 
    consult_prescription.urgencies_check 
FROM(
    SELECT 
        -- ID
        emr_member_med_notes.member_id,
        emr_member_med_notes.disease_case_id,
        emr_member_med_notes.case_event_id,
        emr_member_med_notes.service_id,
        ----emr_member_med_notes.uuid --AS med_note_uuid,
        emr_member_med_notes.medical_note_id,

        --member_name,
        --doctor_name,
        --license_number,
        --license_institution,
        --specialist_institution,
        --specialist_number,

        -- Diseases
        emr_member_med_notes.evaluation_cie_keys,
        emr_member_med_notes.evaluation_diagnostics,
        emr_member_med_notes.evaluation_diagnostic_impression,
        emr_member_med_notes.interrogation_system,
        emr_member_med_notes.interrogation_system_name,
        emr_member_med_notes.interrogation_notes,
        emr_member_med_notes.exam_notes,

        -- Dates
        emr_member_med_notes.med_note_date,
        emr_member_med_notes.exam_physical_date,
        emr_member_med_notes.exam_date,
        emr_member_med_notes.exam_obstetric_date,
        emr_member_med_notes.addendum_date,
        emr_member_med_notes.interrogation_date,
        emr_member_med_notes.scheduledprocedure_date,
        emr_member_med_notes.dischargeinfo_date,
        emr_member_med_notes.discharge_date,
        emr_member_med_notes.evaluation_date,
        emr_member_med_notes.medical_procedure_date,
        med_history.med_history_date,

        -- Categories, Names
        emr_member_med_notes.med_note_type,
        emr_member_med_notes.med_note_motive,
        emr_member_med_notes.state,
        emr_member_med_notes.med_explo_segment_name,
        emr_member_med_notes.med_explo_segment,
        emr_member_med_notes.scheduledprocedure_procedure_name,
        emr_member_med_notes.medical_procedure_name,
        emr_member_med_notes.medical_procedure,
        med_history.pathologies_state,
        med_history.surgeries_state,
        med_history.vaccines_state,
        med_history.hospitalizations_state,
        med_history.allergies_state,
        med_history.malformations_state,
        med_history.family_pathologies_state,
        med_history.mental_health_psychology_state,
        med_history.mental_health_psychiatry_state,
        emr_member_med_notes.doctor_specializations,
        emr_member_med_notes.doctor_specializations_description,
        emr_member_med_notes.doctor_specializations_type,
        emr_member_med_notes.doctor_specializations_is_primary_care,

        -- Dichotomous, Values
        emr_member_med_notes.has_gynecological_exams,
        emr_member_med_notes.has_been_pregnant,
        emr_member_med_notes.has_menstrual_cycle,
        emr_member_med_notes.has_birth_control,
        med_history.has_therapy,
        emr_member_med_notes.scheduledprocedure_is_urgent,
        emr_member_med_notes.scheduledprocedure_in_hospital,
        emr_member_med_notes.scheduledprocedure_has_extra_requirements,
        emr_member_med_notes.dischargeinfo_visits_amount,

        -- Text
        med_history.health_summary,
        emr_member_med_notes.suffering,
        emr_member_med_notes.med_explo_notes,
        emr_member_med_notes.exam_physical_notes,
        emr_member_med_notes.addendum_notes,
        med_history.therapy_notes,
        med_history.pathologies_notes,
        med_history.surgeries_notes,
        med_history.vaccines_notes,
        med_history.hospitalizations_notes,
        med_history.allergies_notes,
        med_history.malformations_notes,
        med_history.family_pathologies_notes,
        med_history.mental_health_psychology_notes,
        med_history.mental_health_psychiatry_notes,
        med_history.medicines_notes,
        emr_member_med_notes.evaluation_notes,
        emr_member_med_notes.scheduledprocedure_medical_reason,
        emr_member_med_notes.scheduledprocedure_extra_requirements,
        emr_member_med_notes.dischargeinfo_stay_summary,
        emr_member_med_notes.dischargeinfo_evolution,
        emr_member_med_notes.dischargeinfo_discharge_reason,
        emr_member_med_notes.medical_procedure_description,

        -- Procedures
        emr_member_med_notes.procedurecategory_name,
        emr_member_med_notes.procedurecategory_description,
        emr_member_med_notes.procedurecategory_is_scheduled,
        emr_member_med_notes.procedurecategory_type,
        emr_member_med_notes.procedurecategory_cpt_key,

        -- Raw
        med_history.last_huli_sync_snapshot,

        -- Other
        emr_member_med_notes.medical_procedure_pathology_sending_required,

    FROM
        emr_member_med_notes
    FULL JOIN
        med_history
    USING(member_id, medical_history_id)
) AS med_notes
LEFT JOIN
    consult_prescription
USING(member_id, medical_note_id)
WHERE
    member_id IS NOT NULL
    AND med_notes.member_id IS NOT NULL
    AND med_notes.disease_case_id IS NOT NULL
    AND med_notes.service_id IS NOT NULL
