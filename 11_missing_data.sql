BEGIN;
UPDATE src_vn_json.observations_json
SET item = item
WHERE id IN (SELECT entity_source_pk_value::INT
             FROM src_vn_json.observations_json
                      JOIN pr_vigienature.t_releve ON bdd_source_id_universal = id_form_universal
                      LEFT JOIN pr_vigienature.t_observation ON t_releve.id = t_observation.releve_id
                      JOIN gn_synthese.synthese ON entity_source_pk_value = observations_json.id::TEXT
             WHERE t_observation.id IS NULL);
COMMIT;

