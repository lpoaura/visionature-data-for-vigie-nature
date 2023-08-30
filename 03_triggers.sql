/*
TRIGGERS
-----
???
 */
DO
$$
    BEGIN

        DROP TRIGGER IF EXISTS tri_vigienature_delete_releve ON src_vn_json.forms_json;

        CREATE TRIGGER tri_vigienature_delete_releve
            AFTER DELETE
            ON src_vn_json.forms_json
            FOR EACH ROW
            WHEN (old.item #>> '{protocol, protocol_name}' LIKE 'S_OC%')
        EXECUTE PROCEDURE pr_vigienature.fct_tri_delete_releve();


        DROP TRIGGER IF EXISTS tri_vigienature_upsert_releve
            ON src_vn_json.forms_json;

        CREATE TRIGGER tri_vigienature_upsert_releve
            AFTER UPDATE OR INSERT
            ON src_vn_json.forms_json
            FOR EACH ROW
            --     WHEN pr_vigienature.is_stoc_eps_form(new.item, 'STOC_EPS')
            WHEN (new.item #>> '{protocol,protocol_name}' LIKE 'S_OC%')
        EXECUTE PROCEDURE pr_vigienature.fct_tri_upsert_releve();

        DROP TRIGGER IF EXISTS tri_vigienature_insert_alti
            ON pr_vigienature.t_releve;
        CREATE TRIGGER tri_vigienature_insert_alti
            AFTER INSERT
            ON pr_vigienature.t_releve
            FOR EACH ROW
--             WHEN (new.geom_point IS NOT NULL)
        EXECUTE PROCEDURE pr_vigienature.fct_tri_update_releve_altitude();

        DROP TRIGGER IF EXISTS tri_vigienature_update_alti
            ON pr_vigienature.t_releve;
        CREATE TRIGGER tri_vigienature_update_alti
            AFTER UPDATE OF geom_point
            ON pr_vigienature.t_releve
            FOR EACH ROW
--             WHEN (NOT old.geom_point ~= new.geom_point AND new.geom_point IS NOT NULL)
        EXECUTE PROCEDURE pr_vigienature.fct_tri_update_releve_altitude();

        DROP TRIGGER IF EXISTS tri_vigienature_upsert_obs
            ON src_vn_json.observations_json;

        CREATE TRIGGER tri_vigienature_upsert_obs
            AFTER UPDATE OR INSERT
            ON src_vn_json.observations_json
            FOR EACH ROW
            WHEN (new.id_form_universal IS NOT NULL)
        EXECUTE PROCEDURE pr_vigienature.fct_tri_update_obs();

        CREATE TRIGGER tri_vigienature_delete_obs
            AFTER DELETE
            ON src_vn_json.observations_json
            FOR EACH ROW
            WHEN (old.id_form_universal IS NOT NULL)
        EXECUTE PROCEDURE pr_vigienature.fct_tri_delete_obs();
        COMMIT;
    END
$$
;

BEGIN
;
