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
        COMMIT;
    END
$$
;

BEGIN
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
                                 AND item ->> 'id_form_universal' NOT LIKE '0' limit 200)

;

UPDATE src_vn_json.observations_json
SET
    item = item
    WHERE
            observations_json.id_form_universal IN
            (SELECT
                 bdd_source_id_universal
                 FROM
                     pr_vigienature.t_releve
--                  WHERE t_releve.nom_protocole LIKE 'SHOC'
--                  LIMIT 100
            )
;

COMMIT
;

--
-- SELECT
--     site
--   , id                           AS "@id"
--   , item ->> '@uid'              AS "@uid"
--   , item ->> 'id_form_universal' AS id_form_universal
-- --   , jsonb_pretty(item)
--     FROM
--         src_vn_json.forms_json
--     WHERE
--         item ->> 'id_form_universal' LIKE '0'
--
-- ;
--
-- SELECT *
--     FROM
--         pr_vigienature.t_releve
-- ;
--
-- UPDATE src_vn_json.observations_json
-- SET
--     item = item
--     WHERE
--             observations_json.id_form_universal IN
--             (SELECT bdd_source_id_universal
--                  FROM pr_vigienature.t_releve
-- --                  WHERE t_releve.nom_protocole LIKE 'SHOC'
-- --                  LIMIT 100
--                  )
-- ;
--
-- SELECT
--     jsonb_pretty(item)
--     FROM
--         src_vn_json.forms_json
--     WHERE
--         item ->> 'id_form_universal' LIKE '9\_22364'
-- ;
--
-- SELECT *
--     FROM
--         pr_vigienature.t_observation
-- ;