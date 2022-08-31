/*
PEUPLEMENT DES TABLES PAR TRIGGERS
-----
Simulation d'un update pour déclencher le trigger
*/

BEGIN TRANSACTION
;

TRUNCATE pr_vigienature.t_releve RESTART IDENTITY CASCADE
;



UPDATE src_vn_json.forms_json
SET
    item = item
    WHERE
            (site, id) IN (SELECT
                               site
                             , id
                               FROM
                                   src_vn_json.forms_json f
                               WHERE
                                     f.item #>> '{protocol,protocol_name}' LIKE 'S_OC%'
                                 AND item ->> 'id_form_universal' NOT LIKE '0')

;

END TRANSACTION;

BEGIN TRANSACTION;

ALTER TABLE src_vn_json.observations_json DISABLE TRIGGER fct_tri_c_upsert_vn_observation_to_geonature;

UPDATE src_vn_json.observations_json
SET
    item = item
    WHERE
            observations_json.id_form_universal IN
            (SELECT
                 bdd_source_id_universal
                 FROM
                     pr_vigienature.t_releve
            )
;


ALTER TABLE src_vn_json.observations_json DISABLE TRIGGER fct_tri_c_upsert_vn_observation_to_geonature;

END TRANSACTION;
