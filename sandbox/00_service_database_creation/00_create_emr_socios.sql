CREATE OR REPLACE TABLE `sofia-data-305018.cadena_cuidado.emr_socios` (
	member_id INT64 OPTIONS (description = 'Member ID'), 
	disease_case_id INT64 OPTIONS (description = 'Disease Case ID'),
	case_event_id INT64 OPTIONS (description = 'Case Event ID'),
	service_id INT64 OPTIONS (description = 'Service ID'),
  consult_prescription_member_name STRING OPTIONS (description = 'Member name from the consult prescription'),
	consult_prescription_doctor_name STRING OPTIONS (description = 'Doctor name from the consult prescription'),
	consult_prescription_license_number STRING OPTIONS (description = 'License number from the consult prescription'),
	consult_prescription_license_institution STRING OPTIONS (description = 'License institution from the consult prescription'),
	consult_prescription_specialist_institution STRING OPTIONS (description = 'Specialist institution from the consult prescription'),
	consult_prescription_diagnosis STRING OPTIONS (description = 'Diagnosis from the consult prescription'),
	evaluation_cie_keys STRING OPTIONS (description = 'CIE keys from the evaluation'),
	evaluation_diagnostics STRING OPTIONS (description = 'Diagnostics from the evaluation'),
	evaluation_diagnostic_impression STRING OPTIONS (description = 'Diagnostic impression from the evaluation'),
	consult_prescription_specialization STRING OPTIONS (description = 'Specialization from the consult prescription'),
	interrogation_system STRING OPTIONS (description = 'System from the interrogation'),
	interrogation_system_name STRING OPTIONS (description = 'System name from the interrogation'),
	interrogation_notes STRING OPTIONS (description = 'Notes from the interrogation'),
	exam_notes STRING OPTIONS (description = 'Notes from the exam'),
	med_note_ts TIMESTAMP OPTIONS (description = 'Medical note timestamp'),
	exam_physical_ts TIMESTAMP OPTIONS (description = 'Physical exam timestamp'),
	exam_ts TIMESTAMP OPTIONS (description = 'Exam timestamp'),
	exam_obstetric_ts TIMESTAMP OPTIONS (description = 'Obstetric exam timestamp'),
	addendum_ts TIMESTAMP OPTIONS (description = 'Addendum timestamp'),
	interrogation_ts TIMESTAMP OPTIONS (description = 'Interrogation timestamp'),
	scheduledprocedure_ts TIMESTAMP OPTIONS (description = 'Scheduled procedure timestamp'),
	dischargeinfo_ts TIMESTAMP OPTIONS (description = 'Discharge info timestamp'),
	discharge_date DATE OPTIONS (description = 'Discharge date'),
	evaluation_ts TIMESTAMP OPTIONS (description = 'Evaluation timestamp'),
	medical_procedure_ts TIMESTAMP OPTIONS (description = 'Medical procedure timestamp'),
	consult_prescription_ts TIMESTAMP OPTIONS (description = 'Consult prescription timestamp'),
	med_history_ts TIMESTAMP OPTIONS (description = 'Medical history timestamp'),
	med_note_type STRING OPTIONS (description = 'Medical note type'),
	med_note_motive STRING OPTIONS (description = 'Medical note motive'),
	med_note_state STRING OPTIONS (description = 'Medical note state'),
	med_explo_segment_name STRING OPTIONS (description = 'Medical exploration segment name'),
	med_explo_segment STRING OPTIONS (description = 'Medical exploration segment'),
	scheduledprocedure_procedure_name STRING OPTIONS (description = 'Scheduled procedure name'),
	medical_procedure_name STRING OPTIONS (description = 'Medical procedure name'),
	medical_procedure STRING OPTIONS (description = 'Medical procedure'),
	med_history_pathologies_state STRING OPTIONS (description = 'Pathologies state from the medical history'),
	med_history_surgeries_state STRING OPTIONS (description = 'Surgeries state from the medical history'),
	med_history_vaccines_state STRING OPTIONS (description = 'Vaccines state from the medical history'),
	med_history_hospitalizations_state STRING OPTIONS (description = 'Hospitalizations state from the medical history'),
	med_history_allergies_state STRING OPTIONS (description = 'Allergies state from the medical history'),
	med_history_malformations_state STRING OPTIONS (description = 'Malformations state from the medical history'),
	med_history_family_pathologies_state STRING OPTIONS (description = 'Family pathologies state from the medical history'),
	med_history_mental_health_psychology_state STRING OPTIONS (description = 'Mental health psychology state from the medical history'),
	med_history_mental_health_psychiatry_state STRING OPTIONS (description = 'Mental health psychiatry state from the medical history'),
	consult_prescription_signed BOOL OPTIONS (description = 'Consult prescription signed'),
	med_note_doctor_specializations STRING OPTIONS (description = 'Doctor specializations from the medical note'),
	med_note_doctor_specializations_description STRING OPTIONS (description = 'Doctor specializations description from the medical note'),
	med_note_doctor_specializations_type STRING OPTIONS (description = 'Doctor specializations type from the medical note'),
	med_note_doctor_specializations_is_primary_care BOOL OPTIONS (description = 'Doctor specializations is primary care from the medical note'),
	consult_prescription_has_antibiotics BOOL OPTIONS (description = 'Consult prescription has antibiotics'),
	scheduledprocedure_is_urgent BOOL OPTIONS (description = 'Scheduled procedure is urgent'),
	scheduledprocedure_in_hospital BOOL OPTIONS (description = 'Scheduled procedure in hospital'),
	scheduledprocedure_has_extra_requirements BOOL OPTIONS (description = 'Scheduled procedure has extra requirements'),
	dischargeinfo_visits_amount INT64 OPTIONS (description = 'Discharge info visits amount'),
	med_history_health_summary STRING OPTIONS (description = 'Health summary from the medical history'),
	consult_prescription_recommendations STRING OPTIONS (description = 'Recommendations from the consult prescription'),
	med_note_suffering STRING OPTIONS (description = 'Medical note suffering'),
	med_explo_notes STRING OPTIONS (description = 'Medical exploration notes'),
	exam_physical_notes STRING OPTIONS (description = 'Physical exam notes'),
	addendum_notes STRING OPTIONS (description = 'Addendum notes'),
	med_history_pathologies_notes STRING OPTIONS (description = 'Pathologies notes from the medical history'),
	med_history_surgeries_notes STRING OPTIONS (description = 'Surgeries notes from the medical history'),
	med_history_vaccines_notes STRING OPTIONS (description = 'Vaccines notes from the medical history'),
	med_history_hospitalizations_notes STRING OPTIONS (description = 'Hospitalizations notes from the medical history'),
	med_history_allergies_notes STRING OPTIONS (description = 'Allergies notes from the medical history'),
	med_history_malformations_notes STRING OPTIONS (description = 'Malformations notes from the medical history'),
	med_history_family_pathologies_notes STRING OPTIONS (description = 'Family pathologies notes from the medical history'),
	med_history_mental_health_psychology_notes STRING OPTIONS (description = 'Mental health psychology notes from the medical history'),
	med_history_mental_health_psychiatry_notes STRING OPTIONS (description = 'Mental health psychiatry notes from the medical history'),
	evaluation_notes STRING OPTIONS (description = 'Evaluation notes'),
	scheduledprocedure_medical_reason STRING OPTIONS (description = 'Scheduled procedure medical reason'),
	scheduledprocedure_extra_requirements STRING OPTIONS (description = 'Scheduled procedure extra requirements'),
	dischargeinfo_stay_summary STRING OPTIONS (description = 'Discharge info stay summary'),
	dischargeinfo_evolution STRING OPTIONS (description = 'Discharge info evolution'),
	dischargeinfo_discharge_reason STRING OPTIONS (description = 'Discharge info discharge reason'),
	medical_procedure_description STRING OPTIONS (description = 'Medical procedure description'),
	procedurecategory_name STRING OPTIONS (description = 'Procedure category name'),
	procedurecategory_description STRING OPTIONS (description = 'Procedure category description'),
	procedurecategory_is_scheduled BOOL OPTIONS (description = 'Procedure category is scheduled'),
	procedurecategory_type STRING OPTIONS (description = 'Procedure category type'),
	procedurecategory_cpt_key STRING OPTIONS (description = 'Procedure category CPT key'),
	med_history_last_huli_sync_snapshot STRING OPTIONS (description = 'Last Huli sync snapshot from the medical history'),
	consult_prescription_items_json STRING OPTIONS (description = 'Items JSON from the consult prescription'),
	consult_prescription_items_member_checks STRING OPTIONS (description = 'Items member checks from the consult prescription'),
	medical_procedure_pathology_sending_required BOOL OPTIONS (description = 'Medical procedure pathology sending required'),
	consult_prescription_references_check BOOL OPTIONS (description = 'Consult prescription references check'), 
	consult_prescription_checkups_check BOOL OPTIONS (description = 'Consult prescription checkups check'),
	consult_prescription_labs_check BOOL OPTIONS (description = 'Consult prescription labs check'), 
	consult_prescription_medicines_check BOOL OPTIONS (description = 'Consult prescription medicines check'),
	consult_prescription_urgencies_check BOOL OPTIONS (description = 'Consult prescription urgencies check') 
) OPTIONS (
		description = 'EMR data, as medical notes, of members (socios)'
)
AS

WITH    
	dr_specializations AS (
		SELECT
			doctor_id,
			ARRAY_TO_STRING(ARRAY_AGG(DISTINCT REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(pdms.name = 'None' OR pdms.name = '', NULL, pdms.name) )), NFD), r'\pM', '') IGNORE NULLS), ', ') AS doctor_specializations,
			ARRAY_TO_STRING(ARRAY_AGG(DISTINCT REGEXP_REPLACE(NORMALIZE(TRIM(LOWER( IF(pdms.description = 'None' OR pdms.description = '', NULL, pdms.description) )), NFD), r'\pM', '') IGNORE NULLS), ', ') AS doctor_specializations_description,
			ARRAY_TO_STRING(ARRAY_AGG(DISTINCT REGEXP_REPLACE(NORMALIZE(TRIM(UPPER( IF(pdms.type = 'None' OR pdms.type = '', NULL, pdms.type) )), NFD), r'\pM', '') IGNORE NULLS), ', ') AS doctor_specializations_type,
			MAX(CAST(pdms.is_primary_care AS BOOL)) AS doctor_specializations_is_primary_care,

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
			medical_note_id,
			MAX_BY(case_event_id, updated_at) AS case_event_id,
			MAX_BY(procedure_category_id, updated_at) AS procedure_category_id,
			MAX_BY(updated_at, updated_at) AS updated_at,
			MAX_BY(is_urgent, updated_at) AS is_urgent,
			MAX_BY(in_hospital, updated_at) AS in_hospital,
			MAX_BY(medical_reason, updated_at) AS medical_reason,
			MAX_BY(procedure_name, updated_at) AS procedure_name,
			MAX_BY(has_extra_requirements, updated_at) AS has_extra_requirements,
			MAX_BY(extra_requirements, updated_at) AS extra_requirements,
			MAX_BY(stay_days, updated_at) AS stay_days,

		FROM
			`sofia-data-305018.backend_db_20240702.emr_scheduledprocedure`
		WHERE   
			deleted IS NULL
		GROUP BY 
			medical_note_id
	),
	emr_member_med_notes AS (
		SELECT DISTINCT
			med_note.member_id AS member_id,
			CAST(med_note.service_id AS INT64) AS service_id,
			CAST(med_note.disease_case_id AS INT64) AS disease_case_id,
			CAST(scheduledprocedure_db.case_event_id AS INT64) AS case_event_id,
			med_note.id AS medical_note_id,
			exam.medical_history_id AS medical_history_id,
			--med_note.uuid,

			med_note.updated_at AS med_note_ts,
			med_note.note_type AS med_note_type,
			LOWER(TRIM( IF(med_note.motive IN ('None', ''), NULL, med_note.motive) )) AS med_note_motive,
			LOWER(TRIM( IF(med_note.suffering IN ('None', '', '.'), NULL, med_note.suffering) )) AS med_note_suffering, 
			med_note.state AS med_note_state, --COMPLETED, CLOSED, OPEN, CANCELLED -- puede ser un campo para ver que el caso esta activo

			LOWER(TRIM( IF(med_explo.notes IN ('None', ''), NULL, med_explo.notes) )) AS med_explo_notes,
			UPPER(TRIM( IF(med_explo.segment_name IN ('None', ''), NULL, med_explo.segment_name) )) AS med_explo_segment_name,
			med_explo.segment AS med_explo_segment,

			exam_physical.updated_at AS exam_physical_ts,
			LOWER(TRIM( IF(exam_physical.notes IN ('None', ''), NULL, exam_physical.notes) )) AS exam_physical_notes,

			exam.updated_at AS exam_ts,
			LOWER(TRIM( IF(exam.notes IN ('None', ''), NULL, exam.notes) )) AS exam_notes, -- lleno de siglas medicas

			exam_obstetric.updated_at AS exam_obstetric_ts,
			--exam_obstetric.has_gynecological_exams,
			--exam_obstetric.has_been_pregnant,
			--exam_obstetric.has_menstrual_cycle,
			--exam_obstetric.has_birth_control,
			
			addendum.updated_at AS addendum_ts,
			LOWER(TRIM( IF(addendum.notes IN ('None', ''), NULL, addendum.notes) )) AS addendum_notes,

			interrogation.updated_at AS interrogation_ts,
			LOWER(TRIM( IF(interrogation.notes IN ('None', '', 'NA', 'na'), NULL, interrogation.notes) )) AS interrogation_notes,
			interrogation.system AS interrogation_system,
			UPPER(TRIM( IF(interrogation.system_name IN ('None', ''), NULL, interrogation.system_name) )) AS interrogation_system_name, -- Puros valores nulos, muy pocos valores Oídos, nariz, garganta y cuello

			scheduledprocedure_db.updated_at AS  scheduledprocedure_ts,
			CAST(scheduledprocedure_db.is_urgent AS BOOL) AS scheduledprocedure_is_urgent,
			CAST(scheduledprocedure_db.in_hospital AS BOOL) AS scheduledprocedure_in_hospital,
			LOWER(TRIM( IF(scheduledprocedure_db.medical_reason IN ('None', '', '.', 'NA', '-'), NULL, scheduledprocedure_db.medical_reason) )) AS scheduledprocedure_medical_reason,
			LOWER(TRIM( IF(scheduledprocedure_db.procedure_name IN ('None', '', '.'), NULL, scheduledprocedure_db.procedure_name) )) AS scheduledprocedure_procedure_name,
			CAST(scheduledprocedure_db.has_extra_requirements AS BOOL) AS scheduledprocedure_has_extra_requirements,
			LOWER(TRIM( IF(scheduledprocedure_db.extra_requirements IN ('None', ''), NULL, scheduledprocedure_db.extra_requirements) )) AS scheduledprocedure_extra_requirements,
			scheduledprocedure_db.stay_days AS scheduledprocedure_stay_days,
			UPPER(TRIM( IF(emr_procedurecategory.name IN ('None', ''), NULL, emr_procedurecategory.name) )) AS procedurecategory_name,
			LOWER(TRIM( IF(emr_procedurecategory.description IN ('None', ''), NULL, emr_procedurecategory.description) )) AS procedurecategory_description,
			CAST(emr_procedurecategory.is_scheduled AS BOOL) AS procedurecategory_is_scheduled,
			emr_procedurecategory.type AS procedurecategory_type,
			IF(emr_procedurecategory.cpt_key IN ('None', ''), NULL, emr_procedurecategory.cpt_key) AS procedurecategory_cpt_key,
			dr_specializations.doctor_specializations AS med_note_doctor_specializations,
			dr_specializations.doctor_specializations_description AS med_note_doctor_specializations_description,
			dr_specializations.doctor_specializations_type AS med_note_doctor_specializations_type,
			dr_specializations.doctor_specializations_is_primary_care AS med_note_doctor_specializations_is_primary_care,

			dischargeinfo.updated_at AS dischargeinfo_ts,
			CAST(IF(dischargeinfo.discharge_date IN ('None', ''), NULL, dischargeinfo.discharge_date) AS DATE) AS discharge_date,
			CAST(dischargeinfo.visits_amount AS INT64) AS dischargeinfo_visits_amount,
			LOWER(TRIM( IF(dischargeinfo.stay_summary IN ('None', ''), NULL, dischargeinfo.stay_summary) )) AS dischargeinfo_stay_summary,
			LOWER(TRIM( IF(dischargeinfo.evolution IN ('None', ''), NULL, dischargeinfo.evolution) )) AS dischargeinfo_evolution,
			UPPER(TRIM( IF(dischargeinfo.discharge_reason IN ('None', ''), NULL, dischargeinfo.discharge_reason) )) AS dischargeinfo_discharge_reason,

			evaluation.updated_at AS evaluation_ts,
			REPLACE(REPLACE(REPLACE(REPLACE( IF(evaluation.cie_keys IN ("['NO APLICA']", '[]', ''), NULL, evaluation.cie_keys), '\'', ''), ' ', ''), ']', ''), '[', '') AS evaluation_cie_keys,
			LOWER(REPLACE(REPLACE(REPLACE( IF(evaluation.diagnostics IN ("['NO APLICA']", '[]', ''), NULL, evaluation.diagnostics), '\'', ''), ']', ''), '[', '')) AS evaluation_diagnostics,
			LOWER(TRIM( IF(evaluation.diagnostic_impression IN ('None', ''), NULL, evaluation.diagnostic_impression) )) AS evaluation_diagnostic_impression,
			LOWER(TRIM( IF(evaluation.notes IN ('None', '', '.', 'NA', '-'), NULL, evaluation.notes) )) AS evaluation_notes,

			medical_procedure.updated_at AS medical_procedure_ts,
			LOWER(TRIM( IF(medical_procedure.name IN ('None', '', '.'), NULL, medical_procedure.name) )) AS medical_procedure_name,
			medical_procedure.procedure AS medical_procedure,
			LOWER(TRIM( IF(medical_procedure.description IN ('None', ''), NULL, medical_procedure.description) )) AS medical_procedure_description,
			CAST(medical_procedure.pathology_sending_required AS BOOL) AS medical_procedure_pathology_sending_required,
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
			updated_at AS consult_prescription_ts,
			CAST(IF(has_antibiotics IN ('None', ''), NULL, has_antibiotics) AS BOOL) AS consult_prescription_has_antibiotics,
			member_name AS consult_prescription_member_name,
			doctor_name AS consult_prescription_doctor_name,
			license_number AS consult_prescription_license_number,
			IF(prescription_items_json IN ('None', '', '{}'), NULL, prescription_items_json) AS consult_prescription_items_json,
			LOWER(TRIM( IF(diagnosis IN ('None', ''), NULL, diagnosis) )) AS consult_prescription_diagnosis,
			license_institution AS consult_prescription_license_institution,
			specialist_institution AS consult_prescription_specialist_institution,
			specialist_number AS consult_prescription_specialist_number,
			CASE
				WHEN specialization = "AGY" THEN "ALGOLOGÍA"
				WHEN specialization = "ANY" THEN "ANESTESIOLOGÍA"
				WHEN specialization = "ANA" THEN "ANGIOLOGÍA Y CIRUGÍA VASCULAR"
				WHEN specialization = "ANG" THEN "ANGIOLOGÍA"
				WHEN specialization = "BRA" THEN "BARIATRÍA Y COMORBILIDADES"
				WHEN specialization = "HRB" THEN "BIOLOGÍA REPRODUCTIVA HUMANA"
				WHEN specialization = "CRY" THEN "CARDIOLOGÍA"
				WHEN specialization = "ICA" THEN "CARDIOLOGÍA INTERVENCIONISTA"
				WHEN specialization = "PCA" THEN "CARDIOLOGÍA PEDIÁTRICA"
				WHEN specialization = "JNS" THEN "CIRUGÍA ARTICULAR"
				WHEN specialization = "BRS" THEN "CIRUGÍA BARIÁTRICA"
				WHEN specialization = "CRS" THEN "CIRUGÍA CARDIOTORÁCICA"
				WHEN specialization = "CRM" THEN "MEDICINA CRÍTICA"
				WHEN specialization = "SPS" THEN "CIRUGÍA DE COLUMNA"
				WHEN specialization = "COS" THEN "CIRUGÍA DE CÓRNEA"
				WHEN specialization = "EPS" THEN "CIRUGÍA DE EPILEPSIA"
				WHEN specialization = "HAS" THEN "CIRUGÍA DE MANO"
				WHEN specialization = "RTA" THEN "CIRUGÍA DE RETINA Y VÍTREO"
				WHEN specialization = "TRS" THEN "CIRUGÍA DE TRASPLANTES"
				WHEN specialization = "DRS" THEN "CIRUGÍA DERMATOLÓGICA"
				WHEN specialization = "HMG" THEN "HEMATOLOGÍA"
				WHEN specialization = "MFM" THEN "MEDICINA FETAL Y MATERNA"
				WHEN specialization = "GNS" THEN "CIRUGÍA GENERAL"
				WHEN specialization = "HPB" THEN "CIRUGÍA HEPATOPANCREATOBILIAR"
				WHEN specialization = "ONS" THEN "CIRUGÍA ONCOLÓGICA"
				WHEN specialization = "PSO" THEN "ONCOLOGÍA QUIRÚRGICA PEDIÁTRICA"
				WHEN specialization = "PDR" THEN "CIRUGÍA PEDIÁTRICA"
				WHEN specialization = "PLA" THEN "CIRUGÍA PLÁSTICA Y RECONSTRUCTIVA"
				WHEN specialization = "RFS" THEN "CIRUGÍA REFRACTIVA"
				WHEN specialization = "DRY" THEN "DERMATOLOGÍA"
				WHEN specialization = "PDD" THEN "DERMATOLOGÍA PEDIÁTRICA"
				WHEN specialization = "DRP" THEN "DERMATOPATOLOGÍA"
				WHEN specialization = "ECL" THEN "ECOCARDIOLOGÍA"
				WHEN specialization = "ENY" THEN "ENDOCRINOLOGÍA"
				WHEN specialization = "PEN" THEN "ENDOCRINOLOGÍA PEDIÁTRICA"
				WHEN specialization = "GYE" THEN "ENDOSCOPIA GINECOLÓGICA"
				WHEN specialization = "EDO" THEN "ENFERMEDADES EXTERNAS DEL OJO Y SUPERFICIE OCULAR"
				WHEN specialization = "PHY" THEN "FISIOTERAPIA Y REHABILITACIÓN"
				WHEN specialization = "PHS" THEN "FONOCIRUGÍA"
				WHEN specialization = "GSY" THEN "GASTROENTEROLOGÍA"
				WHEN specialization = "PDG" THEN "GASTROENTEROLOGÍA PEDIÁTRICA Y NUTRICIÓN"
				WHEN specialization = "MDG" THEN "GENÉTICA MÉDICA"
				WHEN specialization = "PRG" THEN "GENÉTICA PERINATAL"
				WHEN specialization = "GRS" THEN "GERIATRÍA"
				WHEN specialization = "GYA" THEN "GINECOLOGÍA Y OBSTETRICIA"
				WHEN specialization = "HPT" THEN "HEPATOLOGÍA"
				WHEN specialization = "IMG" THEN "IMAGENOLOGÍA"
				WHEN specialization = "DGI" THEN "IMAGENOLOGÍA DIAGNÓSTICA Y TERAPÉUTICA"
				WHEN specialization = "LRL" THEN "LARINGOLOGÍA"
				WHEN specialization = "INM" THEN "MEDICINA INTERNA"
				WHEN specialization = "GNM" THEN "MEDICINA GENERAL"
				WHEN specialization = "NCM" THEN "MEDICINA NUCLEAR"
				WHEN specialization = "ASM" THEN "MICROCIRUGÍA DEL SEGMENTO ANTERIOR"
				WHEN specialization = "MOT" THEN "MOTILIDAD"
				WHEN specialization = "NPY" THEN "NEFROLOGÍA"
				WHEN specialization = "PNP" THEN "NEFROLOGÍA PEDIÁTRICA"
				WHEN specialization = "NNY" THEN "NEONATOLOGÍA"
				WHEN specialization = "PDP" THEN "NEUMOLOGÍA PEDIÁTRICA"
				WHEN specialization = "NRS" THEN "NEUROCIRUGÍA"
				WHEN specialization = "CLR" THEN "NEUROFISIOLOGÍA CLÍNICA"
				WHEN specialization = "NRY" THEN "NEUROLOGÍA"
				WHEN specialization = "NRP" THEN "NEUROPEDIATRÍA"
				WHEN specialization = "CNP" THEN "NEUROPSICOLOGÍA CLÍNICA"
				WHEN specialization = "CLN" THEN "NUTRICIÓN CLÍNICA"
				WHEN specialization = "OPY" THEN "OFTALMOLOGÍA"
				WHEN specialization = "POP" THEN "OFTALMOLOGÍA PEDIÁTRICA"
				WHEN specialization = "MDO" THEN "ONCOLOGÍA MÉDICA"
				WHEN specialization = "OEL" THEN "ÓRBITA, PÁRPADOS Y VÍAS LAGRIMALES"
				WHEN specialization = "OTR" THEN "ORTOPEDIA Y TRAUMATOLOGÍA"
				WHEN specialization = "POT" THEN "ORTOPEDIA Y TRAUMATOLOGÍA PEDIÁTRICA"
				WHEN specialization = "PVF" THEN "SUELO PÉLVICO"
				WHEN specialization = "NCP" THEN "PRÁCTICAS NARRATIVAS Y COLABORATIVAS EN PSICOTERAPIA"
				WHEN specialization = "OTY" THEN "OTORRINOLARINGOLOGÍA"
				WHEN specialization = "PDS" THEN "PEDIATRÍA"
				WHEN specialization = "CLP" THEN "PSICOLOGÍA CLÍNICA"
				WHEN specialization = "PSY" THEN "PSIQUIATRÍA"
				WHEN specialization = "VSA" THEN "RADIOLOGÍA VASCULAR E INTERVENCIONISTA"
				WHEN specialization = "RON" THEN "RADIOONCOLOGÍA"
				WHEN specialization = "HJR" THEN "RECONSTRUCCIÓN DE CADERA"
				WHEN specialization = "JRA" THEN "REEMPLAZO ARTICULAR Y ARTROSCOPIA"
				WHEN specialization = "RHY" THEN "REUMATOLOGÍA"
				WHEN specialization = "KNT" THEN "TRASPLANTE RENAL"
				WHEN specialization = "URG" THEN "URGENCIOLOGÍA" 
				WHEN specialization = "URY" THEN "UROLOGÍA"
				WHEN specialization = "GYU" THEN "UROLOGÍA GINECOLÓGICA"
				WHEN specialization = "ONU" THEN "UROLOGÍA ONCOLÓGICA"
				WHEN specialization = "PDU" THEN "UROLOGÍA PEDIÁTRICA"
				WHEN specialization = "INY" THEN "INFECTOLOGÍA"
				WHEN specialization = "CLY" THEN "COLOPROCTOLOGÍA"
				WHEN specialization = "AOS" THEN "AUDIOLOGÍA, OTONEUROLOGÍA Y TERAPIA DEL HABLA"
				WHEN specialization = "PNM" THEN "NEUMOLOGÍA"
				WHEN specialization = "AIM" THEN "ALERGOLOGÍA E INMUNOLOGÍA"
				WHEN specialization = "GAE" THEN "ENDOSCOPIA GASTROINTESTINAL"
				WHEN specialization = "CAP" THEN "PSIQUIATRÍA INFANTIL Y ADOLESCENTE"
				WHEN specialization = "PSI" THEN "PSICOLOGÍA"
				WHEN specialization = "ONT" THEN "NUTRICIÓN ONCOLÓGICA"
				WHEN specialization = "UCE" THEN "EMERGENCIAS CARDIOVASCULARES"
				WHEN specialization = "RHM" THEN "REHABILITACIÓN"
				WHEN specialization = "RBS" THEN "CIRUGÍA ROBÓTICA"
				WHEN specialization = "ORS" THEN "ORTOPEDIA"
				WHEN specialization = "OOG" THEN "GINECOLOGÍA ONCOLÓGICA"
				WHEN specialization = "NUT" THEN "NUTRICIÓN"
				WHEN specialization = "DGA" THEN "ENDOSCOPIA DIAGNÓSTICA Y TERAPÉUTICA"
				WHEN specialization = "None" THEN NULL
				WHEN specialization = '' THEN NULL
				ELSE UPPER(specialization)
			END AS consult_prescription_specialization,
			LOWER(TRIM( IF(recommendations IN ('None', '', '.'), NULL, recommendations) )) AS consult_prescription_recommendations,
			CAST(signed AS BOOL) AS consult_prescription_signed,
			IF(prescription_items_member_checks IN ('None', '', '{}'), NULL, prescription_items_member_checks) AS consult_prescription_items_member_checks,
			CAST( IF(references_check IN ('None', ''), NULL, references_check) AS BOOL) AS consult_prescription_references_check,
			CAST( IF(checkups_check IN ('None', ''), NULL, checkups_check) AS BOOL) AS consult_prescription_checkups_check,
			CAST( IF(labs_check IN ('None', ''), NULL, labs_check) AS BOOL) AS consult_prescription_labs_check,
			CAST( IF(medicines_check IN ('None', ''), NULL, medicines_check) AS BOOL) AS consult_prescription_medicines_check,
			CAST( IF(urgencies_check IN ('None', ''), NULL, urgencies_check) AS BOOL) AS consult_prescription_urgencies_check,
			
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
			updated_at AS med_history_ts,
			--therapy_notes,
			IF(last_huli_sync_snapshot IN ('None', '', '{}'), NULL, last_huli_sync_snapshot) AS med_history_last_huli_sync_snapshot,
			--has_therapy,
			--non_pathological_history_id,
			UPPER(TRIM( IF(pathologies_state IN ('None', ''), NULL, pathologies_state) )) AS med_history_pathologies_state,
			UPPER(TRIM( IF(surgeries_state IN ('None', ''), NULL, surgeries_state) )) AS med_history_surgeries_state,
			UPPER(TRIM( IF(vaccines_state IN ('None', ''), NULL, vaccines_state) )) AS med_history_vaccines_state,
			UPPER(TRIM( IF(hospitalizations_state IN ('None', ''), NULL, hospitalizations_state) )) AS med_history_hospitalizations_state,
			UPPER(TRIM( IF(allergies_state IN ('None', ''), NULL, allergies_state) )) AS med_history_allergies_state,
			UPPER(TRIM( IF(malformations_state IN ('None', ''), NULL, malformations_state) )) AS med_history_malformations_state,
			UPPER(TRIM( IF(family_pathologies_state IN ('None', ''), NULL, family_pathologies_state) )) AS med_history_family_pathologies_state,
			UPPER(TRIM( IF(mental_health_psychology_state IN ('None', ''), NULL, mental_health_psychology_state) )) AS med_history_mental_health_psychology_state,
			UPPER(TRIM( IF(mental_health_psychiatry_state IN ('None', ''), NULL, mental_health_psychiatry_state) )) AS med_history_mental_health_psychiatry_state,
			LOWER(TRIM( IF(pathologies_notes IN ('None', ''), NULL, pathologies_notes) )) AS med_history_pathologies_notes,
			LOWER(TRIM( IF(surgeries_notes IN ('None', ''), NULL, surgeries_notes) )) AS med_history_surgeries_notes, -- muy poca informacion
			LOWER(TRIM( IF(vaccines_notes IN ('None', ''), NULL, vaccines_notes) )) AS med_history_vaccines_notes,
			LOWER(TRIM( IF(hospitalizations_notes IN ('None', ''), NULL, hospitalizations_notes) )) AS med_history_hospitalizations_notes,
			LOWER(TRIM( IF(allergies_notes IN ('None', ''), NULL, allergies_notes) )) AS med_history_allergies_notes,
			LOWER(TRIM( IF(malformations_notes IN ('None', ''), NULL, malformations_notes) )) AS med_history_malformations_notes,
			LOWER(TRIM( IF(family_pathologies_notes IN ('None', ''), NULL, family_pathologies_notes) )) AS med_history_family_pathologies_notes,
			LOWER(TRIM( IF(mental_health_psychology_notes IN ('None', ''), NULL, mental_health_psychology_notes) )) AS med_history_mental_health_psychology_notes,
			LOWER(TRIM( IF(mental_health_psychiatry_notes IN ('None', ''), NULL, mental_health_psychiatry_notes) )) AS med_history_mental_health_psychiatry_notes,
			--medicines_notes, -- todos nulos
			LOWER(TRIM( IF(health_summary IN ('None', ''), NULL, health_summary) )) AS med_history_health_summary,
				
		FROM    
			`sofia-data-305018.backend_db_20240702.emr_medicalhistory`
		WHERE
			member_id IS NOT NULL
			AND id IS NOT NULL
			AND deleted = 'None'
)


SELECT
	-- ID
	med_notes.member_id,
	med_notes.disease_case_id,
	med_notes.case_event_id,
	med_notes.service_id,

	-- Member and Doctor description
	consult_prescription.consult_prescription_member_name,
	consult_prescription.consult_prescription_doctor_name,
	consult_prescription.consult_prescription_license_number,
	consult_prescription.consult_prescription_license_institution,
	consult_prescription.consult_prescription_specialist_institution,

	-- Diseases
	consult_prescription.consult_prescription_diagnosis,
	med_notes.evaluation_cie_keys,
	med_notes.evaluation_diagnostics,
	med_notes.evaluation_diagnostic_impression,
	consult_prescription.consult_prescription_specialization,
	med_notes.interrogation_system,
	med_notes.interrogation_system_name,
	med_notes.interrogation_notes,
	med_notes.exam_notes,

	-- Dates
	med_notes.med_note_ts,
	med_notes.exam_physical_ts,
	med_notes.exam_ts,
	med_notes.exam_obstetric_ts,
	med_notes.addendum_ts,
	med_notes.interrogation_ts,
	med_notes.scheduledprocedure_ts,
	med_notes.dischargeinfo_ts,
	med_notes.discharge_date,
	med_notes.evaluation_ts,
	med_notes.medical_procedure_ts,
	consult_prescription.consult_prescription_ts,
	med_notes.med_history_ts,

	-- Categories, Names
	med_notes.med_note_type,
	med_notes.med_note_motive,
	med_notes.med_note_state,
	med_notes.med_explo_segment_name,
	med_notes.med_explo_segment,
	med_notes.scheduledprocedure_procedure_name,
	med_notes.medical_procedure_name,
	med_notes.medical_procedure,
	med_notes.med_history_pathologies_state,
	med_notes.med_history_surgeries_state,
	med_notes.med_history_vaccines_state,
	med_notes.med_history_hospitalizations_state,
	med_notes.med_history_allergies_state,
	med_notes.med_history_malformations_state,
	med_notes.med_history_family_pathologies_state,
	med_notes.med_history_mental_health_psychology_state,
	med_notes.med_history_mental_health_psychiatry_state,
	consult_prescription.consult_prescription_signed,
	med_notes.med_note_doctor_specializations,
	med_notes.med_note_doctor_specializations_description,
	med_notes.med_note_doctor_specializations_type,
	med_notes.med_note_doctor_specializations_is_primary_care,

	-- Dichotomous, Values
	--med_notes.has_gynecological_exams,
	--med_notes.has_been_pregnant,
	--med_notes.has_menstrual_cycle,
	--med_notes.has_birth_control,
	--med_notes.has_therapy,
	consult_prescription.consult_prescription_has_antibiotics,
	med_notes.scheduledprocedure_is_urgent,
	med_notes.scheduledprocedure_in_hospital,
	med_notes.scheduledprocedure_has_extra_requirements,
	med_notes.dischargeinfo_visits_amount,

	-- Text
	med_notes.med_history_health_summary,
	consult_prescription.consult_prescription_recommendations,
	med_notes.med_note_suffering,
	med_notes.med_explo_notes,
	med_notes.exam_physical_notes,
	med_notes.addendum_notes,
	med_notes.med_history_pathologies_notes,
	med_notes.med_history_surgeries_notes,
	med_notes.med_history_vaccines_notes,
	med_notes.med_history_hospitalizations_notes,
	med_notes.med_history_allergies_notes,
	med_notes.med_history_malformations_notes,
	med_notes.med_history_family_pathologies_notes,
	med_notes.med_history_mental_health_psychology_notes,
	med_notes.med_history_mental_health_psychiatry_notes,
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
	med_notes.med_history_last_huli_sync_snapshot,
	consult_prescription.consult_prescription_items_json,
	consult_prescription.consult_prescription_items_member_checks,

	-- Other
	med_notes.medical_procedure_pathology_sending_required,
	consult_prescription.consult_prescription_references_check, 
	consult_prescription.consult_prescription_checkups_check,
	consult_prescription.consult_prescription_labs_check, 
	consult_prescription.consult_prescription_medicines_check, 
	consult_prescription.consult_prescription_urgencies_check 
FROM(
	SELECT 
		-- ID
		emr_member_med_notes.member_id,
		emr_member_med_notes.disease_case_id,
		emr_member_med_notes.case_event_id,
		emr_member_med_notes.service_id,
		emr_member_med_notes.medical_note_id,

		-- Diseases
		emr_member_med_notes.evaluation_cie_keys,
		emr_member_med_notes.evaluation_diagnostics,
		emr_member_med_notes.evaluation_diagnostic_impression,
		emr_member_med_notes.interrogation_system,
		emr_member_med_notes.interrogation_system_name,
		emr_member_med_notes.interrogation_notes,
		emr_member_med_notes.exam_notes,

		-- Dates
		emr_member_med_notes.med_note_ts,
		emr_member_med_notes.exam_physical_ts,
		emr_member_med_notes.exam_ts,
		emr_member_med_notes.exam_obstetric_ts,
		emr_member_med_notes.addendum_ts,
		emr_member_med_notes.interrogation_ts,
		emr_member_med_notes.scheduledprocedure_ts,
		emr_member_med_notes.dischargeinfo_ts,
		emr_member_med_notes.discharge_date,
		emr_member_med_notes.evaluation_ts,
		emr_member_med_notes.medical_procedure_ts,
		med_history.med_history_ts,

		-- Categories, Names
		emr_member_med_notes.med_note_type,
		emr_member_med_notes.med_note_motive,
		emr_member_med_notes.med_note_state,
		emr_member_med_notes.med_explo_segment_name,
		emr_member_med_notes.med_explo_segment,
		emr_member_med_notes.scheduledprocedure_procedure_name,
		emr_member_med_notes.medical_procedure_name,
		emr_member_med_notes.medical_procedure,
		med_history.med_history_pathologies_state,
		med_history.med_history_surgeries_state,
		med_history.med_history_vaccines_state,
		med_history.med_history_hospitalizations_state,
		med_history.med_history_allergies_state,
		med_history.med_history_malformations_state,
		med_history.med_history_family_pathologies_state,
		med_history.med_history_mental_health_psychology_state,
		med_history.med_history_mental_health_psychiatry_state,
		emr_member_med_notes.med_note_doctor_specializations,
		emr_member_med_notes.med_note_doctor_specializations_description,
		emr_member_med_notes.med_note_doctor_specializations_type,
		emr_member_med_notes.med_note_doctor_specializations_is_primary_care,

		-- Dichotomous, Values
		emr_member_med_notes.scheduledprocedure_is_urgent,
		emr_member_med_notes.scheduledprocedure_in_hospital,
		emr_member_med_notes.scheduledprocedure_has_extra_requirements,
		emr_member_med_notes.dischargeinfo_visits_amount,

		-- Text
		med_history.med_history_health_summary,
		emr_member_med_notes.med_note_suffering,
		emr_member_med_notes.med_explo_notes,
		emr_member_med_notes.exam_physical_notes,
		emr_member_med_notes.addendum_notes,
		med_history.med_history_pathologies_notes,
		med_history.med_history_surgeries_notes,
		med_history.med_history_vaccines_notes,
		med_history.med_history_hospitalizations_notes,
		med_history.med_history_allergies_notes,
		med_history.med_history_malformations_notes,
		med_history.med_history_family_pathologies_notes,
		med_history.med_history_mental_health_psychology_notes,
		med_history.med_history_mental_health_psychiatry_notes,
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
		med_history.med_history_last_huli_sync_snapshot,

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
