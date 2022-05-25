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

        COMMIT;
    END
$$
;

BEGIN
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
                               LIMIT 10)
;
ROLLBACK ;

select * from pr_vigienature.t_releve;