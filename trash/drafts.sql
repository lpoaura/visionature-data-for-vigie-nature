/* Recherche de formulaires STOC en doublon */
SELECT
    survey_id
  , carre_numnat
  , passage_mnhn
  , date
  , survey_geotype
  , point_num
  , euring_codesp
  , t_releve.bdd_source
--   , sum(count)
    FROM
        pr_vigienature.t_observation
            JOIN pr_vigienature.t_releve ON t_observation.survey_id = t_releve.id
            LEFT JOIN pr_vigienature.cor_taxon_referentiels ON euring_codesp = euring_code AND ref_tax IS TRUE
    WHERE
          t_releve.bdd_source LIKE 'vn%'
      AND carre_numnat = 11158
      AND date BETWEEN '2019-04-20' AND '2019-04-24'
      AND point_num = 1
;

SELECT *
    FROM
        pr_vigienature.t_observation
    ORDER BY
        update_ts ASC
    LIMIT 20
;


UPDATE import_vn.observations_json
SET
    site = site
    WHERE
            id_form_universal IN (SELECT
                                      bdd_source_id_universal
                                      FROM
                                          pr_vigienature.t_releve
                                      WHERE
                                          bdd_source LIKE 'vn%')

SELECT
    min(id)
  , max(id)
    FROM
        pr_vigienature.t_releve
    WHERE
        bdd_source LIKE 'vn%'
;

UPDATE pr_vigienature.t_observation
SET
    update_ts = to_timestamp(obsjson.update)
    FROM
        import_vn.observations_json obsjson
    WHERE
          bdd_source = site
      AND bdd_source_id = obsjson.id
;

SELECT
    jsonb_pretty(item)
    FROM
        src_vn_json.forms_json
    WHERE
        item #>> '{protocol, protocol_name}' = 'STOC_EPS'
    LIMIT 5
;

SELECT
    form.id
  , form.item ->> 'comment'                   AS comment
  , form.item #>> '{protocol, protocol_name}' AS pr_name
  , form.item ->> 'full_form'                 AS full_form
  , jsonb_pretty(form.item)
  , array_agg(obs.id)
    FROM
        import_vn.forms_json form
            JOIN import_vn.observations_json obs ON form.item ->> 'id_form_universal' = obs.id_form_universal
    GROUP BY
        form.id
      , form.item
    ORDER BY
        form.id DESC
;

SELECT
    jsonb_pretty(item)
    FROM
        import_vn.observations_json
    WHERE
          id = 474534
      AND site LIKE 'vn07'
;

SELECT
    jsonb_pretty(item)
    FROM
        import_vn.forms_json
    WHERE
        item ->> 'id_form_universal' LIKE '65_354745'
;

SELECT *
    FROM
        import_vn.increment_log
;

SELECT
    min(last_ts)
    FROM
        import_vn.increment_log
;

UPDATE import_vn.increment_log
SET
    last_ts= '2019-09-05 09:05:00.000000'
;

WITH
    t1 AS (SELECT 'json' AS source, site, count(*) FROM import_vn.observations_json GROUP BY site)
  , t2 AS (SELECT
               'merged'            AS source
             , observations.source AS site
             , count(*)
               FROM
                   src_lpodatas.observations
               GROUP BY source)
SELECT
    t1.site
  , t1.count            AS t1count
  , t2.count            AS t2count
  , t1.count - t2.count AS diff
    FROM
        t1
            JOIN t2 ON
            t1.site = t2.site
;

SELECT *
    FROM
        src_lpodatas.observations
    ORDER BY
        derniere_maj DESC
    LIMIT 10
;

UPDATE src_lpodatas.observations
SET
    date    = to_timestamp(cast(obs.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))
  , date_an = cast(
        extract(YEAR FROM to_timestamp(cast(obs.item #>> '{date,@timestamp}' AS DOUBLE PRECISION))) AS INTEGER)
  , place   = obs.item #>> '{place,name}'
    FROM
        import_vn.observations_json obs
;

WHERE

    (obs.site, obs.id)
    =

    (observations.source, observations.bdd_source_id_data)
    AND
        observations.source LIKE 'vn07'
;


SELECT
    nspname || '.' || relname                     AS relation
  , pg_size_pretty(pg_total_relation_size(c.oid)) AS total_size
    FROM
        pg_class c
            LEFT JOIN pg_namespace n ON (n.oid = c.relnamespace)
    WHERE
          nspname NOT IN ('pg_catalog', 'information_schema')
      AND c.relkind <> 'i'
      AND nspname !~ '^pg_toast'
    ORDER BY
        pg_total_relation_size(c.oid) DESC
    LIMIT 20
;


SELECT *
    FROM
        src_vn.observations
    LIMIT 10
;

SELECT *
    FROM
        pr_vigienature.t_observation
            JOIN pr_vigienature.t_releve ON t_observation.survey_id = t_releve.id
    WHERE
        update_ts > '2019-09-05'
;

SELECT
    jsonb_pretty(item)
    FROM
        import_vn.observers_json
    LIMIT 100
;

CREATE VIEW src_lpodatas.observers AS
SELECT DISTINCT
    item ->> 'id_universal' AS id_universal
  , item ->> 'name'         AS nom
  , item ->> 'surname'      AS prenom
  , item ->> 'email'        AS email
  , item ->> 'postcode'     AS code_postal
  , item ->> 'municipality' AS commune
    FROM
        import_vn.observers_json
;