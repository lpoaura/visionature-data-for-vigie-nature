/* TODO peuplement des relevés STOC EPS */
UPDATE
    import_vn.forms_json
SET
    site = site
    WHERE
        item #>> '{protocol,protocol_name}' LIKE 'S_OC%'
;


/* TODO Peuplement des observations détaillées STOC EPS */
UPDATE
    import_vn.observations_json
SET
    site = site
    WHERE
        --         item #>> '{observers,0,protocol,protocol_name}' LIKE 'STOC_EPS'
        id_form_universal IN (SELECT
                                  bdd_source_id_universal
                                  FROM
                                      pr_vigienature.t_releve)
;

UPDATE
    src_vn_json.forms_json
SET
    item = item
    WHERE
            (site, id) IN (SELECT
                               t.site
                             , t.id
                               FROM
                                   src_vn_json.forms_json t
                               WHERE
                                   item #>> '{protocol,protocol_name}' LIKE 'S_OC%'
                               LIMIT 1000)
;

SELECT *
    FROM
        pr_vigienature.t_releve
;