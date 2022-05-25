/***************************************************************************
 * Triggers déclenchés sur les tables de réception des données VisioNature *
 ***************************************************************************/

/* Retrieve survey values from  visionature codes  (habitat, meteo, etc.)  */

DROP FUNCTION IF EXISTS pr_vigienature.get_code_point_values_from_vn_code
;

CREATE OR REPLACE FUNCTION pr_vigienature.get_releve_info(_vn_code TEXT) RETURNS INT
AS
$$
DECLARE
    the_id INT;
BEGIN
    SELECT id INTO the_id FROM pr_vigienature.dict_points_code WHERE dict_points_code.code_vn = _vn_code;
    RETURN the_id;
END ;
$$
    LANGUAGE plpgsql
;

SELECT *
    FROM
        pr_vigienature.
            select id FROM pr_vigienature.dict_distance_code
    WHERE
        dict_distance_code.code_vn = 'A1_1'
;

/* TEST:
   SELECT pr_vigienature.get_code_point_values_from_vn_code('principal'::text, 'E1_1') as pr,
       pr_vigienature.get_code_point_values_from_vn_code('colonne'::text, 'E1_1') as col,
       pr_vigienature.get_code_point_values_from_vn_code('code'::text, 'E1_1') as code;
RESULTAT:
    pr	col	code
    E	1	1
*/

/* Retrieve distances values from  visionature codes  (distance)  */

DROP FUNCTION IF EXISTS pr_vigienature.get_distance_label_from_vn_code
;

CREATE OR REPLACE FUNCTION pr_vigienature.get_distance_label_from_vn_code(vn_code TEXT, OUT result TEXT)
    RETURNS TEXT AS
$$
BEGIN
    EXECUTE format(
            'SELECT bib_code_distances.libelle from pr_vigienature.bib_code_distances where code_vn = $1 limit 1')
        INTO result
        USING vn_code;
END ;
$$
    LANGUAGE plpgsql
;

DROP FUNCTION IF EXISTS pr_vigienature.get_altitude_from_dem
;

CREATE OR REPLACE FUNCTION pr_vigienature.get_altitude_from_dem(geom GEOMETRY(POINT, 2154), OUT result INT)
    RETURNS INT AS
$$
BEGIN
    EXECUTE format(
            'SELECT st_value(rast, $1)::int from ref_geo.dem where st_intersects(rast, $1)')
        INTO result
        USING geom;
END ;
$$
    LANGUAGE plpgsql
;

/* Get EURING code from vn id_species */

DROP FUNCTION IF EXISTS pr_vigienature.get_euring_code_from_vn_id_species
;

CREATE OR REPLACE FUNCTION pr_vigienature.get_euring_code_from_vn_id_species(id_species INT, OUT result VARCHAR(20))
    RETURNS VARCHAR(20) AS
$$
BEGIN
    EXECUTE format(
            'SELECT cor_taxon_referentiels.euring_code from pr_vigienature.cor_taxon_referentiels where vn_id_species = $1 and ref_tax is true limit 1')
        INTO result
        USING id_species;
END ;
$$
    LANGUAGE plpgsql
;

/* Get survey_id from vn id_form_universal */

DROP FUNCTION IF EXISTS pr_vigienature.get_releve_id_from_id_form_uid
;

CREATE OR REPLACE FUNCTION pr_vigienature.get_releve_id_from_id_form_uid(id_form_universal VARCHAR(50), OUT result INT)
    RETURNS INT AS
$$
BEGIN
    EXECUTE format(
            'SELECT t_releve.id from pr_vigienature.t_releve where bdd_source_id_universal = $1 limit 1')
        INTO result
        USING id_form_universal;
END ;
$$
    LANGUAGE plpgsql
;


DROP FUNCTION IF EXISTS import_vn.forms_json_id_universal
;

CREATE OR REPLACE FUNCTION import_vn.forms_json_id_universal(JSONB)
    RETURNS VARCHAR(50)
AS
$$
SELECT
    ($1 -> 'id_form_universal')::VARCHAR(50)
$$
    LANGUAGE sql
    IMMUTABLE
    PARALLEL SAFE
;

DROP FUNCTION IF EXISTS import_vn.forms_json_protocol_name
;

CREATE OR REPLACE FUNCTION import_vn.forms_json_protocol_name(JSONB)
    RETURNS VARCHAR(50)
AS
$$
SELECT
    ($1 #> '{protocol, protocol_name}')::VARCHAR(50)
$$
    LANGUAGE sql
    IMMUTABLE
    PARALLEL SAFE
;

DROP FUNCTION IF EXISTS pr_vigienature.is_stoc_eps_form
;

CREATE FUNCTION pr_vigienature.is_stoc_eps_form(id_form_universal VARCHAR(50), protocol_name VARCHAR(20)) RETURNS BOOLEAN AS
$$
SELECT
    item #>> '{protocol, protocol_name}' ILIKE $2
    FROM
        import_vn.forms_json
    WHERE
        item ->> 'id_form_universal' LIKE $1
$$
    LANGUAGE sql
;


/*
select pr_vigienature.get_euring_code_from_vn_id_species(518);
*/

CREATE OR REPLACE FUNCTION pr_vigienature.delete_releves() RETURNS TRIGGER AS
$$
BEGIN
    -- Deleting data on src_vn.observations when raw data is deleted
    DELETE
        FROM
            pr_vigienature.t_releve
        WHERE
            bdd_source_id_universal = old.item ->> 'id_form_universal';
    IF NOT found
    THEN
        RETURN NULL;
    END IF;
    RETURN old;
END;
$$
    LANGUAGE plpgsql
;

DROP TRIGGER IF EXISTS stoc_releve_delete_from_vn_trigger ON import_vn.forms_json
;

CREATE TRIGGER stoc_releve_delete_from_vn_trigger
    AFTER DELETE
    ON import_vn.forms_json
    FOR EACH ROW
    WHEN (old.item #>> '{protocol, protocol_name}' LIKE 'STOC_%')
EXECUTE PROCEDURE pr_vigienature.delete_releves()
;

CREATE OR REPLACE FUNCTION pr_vigienature.upsert_releve() RETURNS TRIGGER
    LANGUAGE plpgsql
AS
$$
DECLARE
    the_date                    DATE;
    the_time                    TIME;
    the_observer                VARCHAR(100);
    the_carre_suivi_id          INTEGER;
    the_carre_numnat            INTEGER;
    the_point_num               INTEGER;
    the_site_name               VARCHAR(250);
    the_altitude                INTEGER;
    the_nuage_id                INTEGER;
    the_pluie_id                INTEGER;
    the_vent_id                 INTEGER;
    the_visibilite_id           INTEGER;
    the_p_milieu_id             INTEGER;
    the_p_type_id               INTEGER;
    the_p_cat1_id               INTEGER;
    the_p_cat2_id               INTEGER;
    the_p_ss_cat1_id            INTEGER;
    the_p_ss_cat2_id            INTEGER;
    the_s_milieu_id             INTEGER;
    the_s_type_id               INTEGER;
    the_s_cat1_id               INTEGER;
    the_s_cat2_id               INTEGER;
    the_s_ss_cat1_id            INTEGER;
    the_s_ss_cat2_id            INTEGER;
    the_site_id                 BOOLEAN;
    the_geom_id                 GEOMETRY(point, 2154);
    the_passage_mnhn            INTEGER;
    the_bdd_source_id_universal VARCHAR(20);
    the_bdd_source              VARCHAR(20);
    the_survey_geotype          VARCHAR(20);
    the_source_data             JSONB;
BEGIN
    the_date = cast(new.item ->> 'date_start' AS DATE);
    the_time = cast(new.item ->> 'time_start' AS TIME);
    the_observer = pr_vigienature.fct_get_observer_from_vn(cast(new.item ->> '@uid' AS INT), new.site);
    the_carre_numnat = CASE
                           WHEN new.item #>> '{protocol, protocol_name}' LIKE 'STOC_EPS'
                               THEN cast(new.item #>> '{protocol, site_code}' AS INT)
        END;
    the_point_num = cast(new.item #>> '{protocol, sequence_number}' AS INT);
    the_site_name = CASE
                        WHEN new.item #>> '{protocol, protocol_name}' LIKE 'STOC_SITES'
                            THEN new.item #>> '{protocol, site_code}'
        END;
    the_geom = st_transform(
            st_setsrid(st_makepoint(cast(new.item ->> 'lon' AS FLOAT), cast(new.item ->> 'lat' AS FLOAT)), 4326), 2154);
    the_altitude = pr_vigienature.fct_get_altitude_from_dem(the_geom);
    the_nuage = pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, stoc_cloud}');
    the_pluie = pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, stoc_rain}');
    the_vent = pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, stoc_wind}');
    the_visibilite =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, stoc_visibility}');
    the_p_milieu =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hp1}');
    the_p_type =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hp2}');
    the_p_cat1 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hp3A}');
    the_p_cat2 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hp3B}');
    the_p_ss_cat1 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hp4A}');
    the_p_ss_cat2 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hp4B}');
    the_s_milieu =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hs1}');
    the_s_type =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hs2}');
    the_s_cat1 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hs3A}');
    the_s_cat2 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hs3B}');
    the_s_ss_cat1 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hs4A}');
    the_s_ss_cat2 =
            pr_vigienature.get_code_point_values_from_vn_code('code'::TEXT, new.item #>> '{protocol, habitat, hs4B}');
    the_site = CASE
                   WHEN new.item #>> '{protocol, protocol_name}' LIKE 'STOC_SITES'
                       THEN TRUE
                   ELSE FALSE END;

    the_passage_mnhn = cast(new.item #>> '{protocol, visit_number}' AS INT);
    the_bdd_source_id_universal = new.item ->> 'id_form_universal';
    the_bdd_source = new.site;
    the_survey_geotype = CASE
                             WHEN (new.item -> 'protocol' ? 'stoc_transport')
                                 THEN 'Transect'
                             ELSE NULL END;
    IF (tg_op = 'UPDATE')
    THEN
        UPDATE pr_vigienature.t_releve
        SET
            date                    = the_date
          , time                    = the_time
          , observer                = the_observer
          , carre_numnat            = the_carre_numnat
          , point_num               = the_point_num
          , site_name               = the_site_name
          , altitude                = the_altitude
          , nuage                   = the_nuage
          , pluie                   = the_pluie
          , vent                    = the_vent
          , visibilite              = the_visibilite
          , p_milieu                = the_p_milieu
          , p_type                  = the_p_type
          , p_cat1                  = the_p_cat1
          , p_cat2                  = the_p_cat2
          , p_ss_cat1               = the_p_ss_cat1
          , p_ss_cat2               = the_p_ss_cat2
          , s_milieu                = the_s_milieu
          , s_type                  = the_s_type
          , s_cat1                  = the_s_cat1
          , s_cat2                  = the_s_cat2
          , s_ss_cat1               = the_s_ss_cat1
          , s_ss_cat2               = the_s_ss_cat2
          , site                    = the_site
          , geom                    = the_geom
          , passage_mnhn            = the_passage_mnhn
          , bdd_source              = the_bdd_source
          , bdd_source_id_universal = the_bdd_source_id_universal
          , survey_geotype          = the_survey_geotype
            WHERE
--                 (t_releve.carre_numnat, t_releve.date, t_releve.point_num, t_releve.bdd_source_id_universal) =
--                 (the_carre_numnat, the_date, the_point_num, the_bdd_source_id_universal);
t_releve.bdd_source_id_universal = the_bdd_source_id_universal;
        IF NOT found
        THEN
            INSERT INTO
                pr_vigienature.t_releve ( date
                                        , time
                                        , observer
                                        , carre_numnat
                                        , point_num
                                        , site_name
                                        , altitude
                                        , nuage
                                        , pluie
                                        , vent
                                        , visibilite
                                        , p_milieu
                                        , p_type
                                        , p_cat1
                                        , p_cat2
                                        , p_ss_cat1
                                        , p_ss_cat2
                                        , s_milieu
                                        , s_type
                                        , s_cat1
                                        , s_cat2
                                        , s_ss_cat1
                                        , s_ss_cat2
                                        , site
                                        , geom
                                        , passage_mnhn
                                        , bdd_source
                                        , bdd_source_id_universal
                                        , survey_geotype)
                VALUES
                    ( the_date
                    , the_time
                    , the_observer
                    , the_carre_numnat
                    , the_point_num
                    , the_site_name
                    , the_altitude
                    , the_nuage
                    , the_pluie
                    , the_vent
                    , the_visibilite
                    , the_p_milieu
                    , the_p_type
                    , the_p_cat1
                    , the_p_cat2
                    , the_p_ss_cat1
                    , the_p_ss_cat2
                    , the_s_milieu
                    , the_s_type
                    , the_s_cat1
                    , the_s_cat2
                    , the_s_ss_cat1
                    , the_s_ss_cat2
                    , the_site
                    , the_geom
                    , the_passage_mnhn
                    , the_bdd_source
                    , the_bdd_source_id_universal
                    , the_survey_geotype);
            RETURN new;
        END IF;
        RETURN new;
    ELSE
        IF (tg_op = 'INSERT')
        THEN
            INSERT INTO
                pr_vigienature.t_releve ( date
                                        , time
                                        , observer
                                        , carre_numnat
                                        , point_num
                                        , site_name
                                        , altitude
                                        , nuage
                                        , pluie
                                        , vent
                                        , visibilite
                                        , p_milieu
                                        , p_type
                                        , p_cat1
                                        , p_cat2
                                        , p_ss_cat1
                                        , p_ss_cat2
                                        , s_milieu
                                        , s_type
                                        , s_cat1
                                        , s_cat2
                                        , s_ss_cat1
                                        , s_ss_cat2
                                        , site
                                        , geom
                                        , passage_mnhn
                                        , bdd_source
                                        , bdd_source_id_universal
                                        , survey_geotype)
                VALUES
                    ( the_date
                    , the_time
                    , the_observer
                    , the_carre_numnat
                    , the_point_num
                    , the_site_name
                    , the_altitude
                    , the_nuage
                    , the_pluie
                    , the_vent
                    , the_visibilite
                    , the_p_milieu
                    , the_p_type
                    , the_p_cat1
                    , the_p_cat2
                    , the_p_ss_cat1
                    , the_p_ss_cat2
                    , the_s_milieu
                    , the_s_type
                    , the_s_cat1
                    , the_s_cat2
                    , the_s_ss_cat1
                    , the_s_ss_cat2
                    , the_site
                    , the_geom
                    , the_passage_mnhn
                    , the_bdd_source
                    , the_bdd_source_id_universal
                    , the_survey_geotype)
            ON CONFLICT (bdd_source_id_universal) DO UPDATE SET
                                                                date                    = the_date
                                                              , time                    = the_time
                                                              , observer                = the_observer
                                                              , carre_numnat            = the_carre_numnat
                                                              , point_num               = the_point_num
                                                              , site_name               = the_site_name
                                                              , altitude                = the_altitude
                                                              , nuage                   = the_nuage
                                                              , pluie                   = the_pluie
                                                              , vent                    = the_vent
                                                              , visibilite              = the_visibilite
                                                              , p_milieu                = the_p_milieu
                                                              , p_type                  = the_p_type
                                                              , p_cat1                  = the_p_cat1
                                                              , p_cat2                  = the_p_cat2
                                                              , p_ss_cat1               = the_p_ss_cat1
                                                              , p_ss_cat2               = the_p_ss_cat2
                                                              , s_milieu                = the_s_milieu
                                                              , s_type                  = the_s_type
                                                              , s_cat1                  = the_s_cat1
                                                              , s_cat2                  = the_s_cat2
                                                              , s_ss_cat1               = the_s_ss_cat1
                                                              , s_ss_cat2               = the_s_ss_cat2
                                                              , site                    = the_site
                                                              , geom                    = the_geom
                                                              , passage_mnhn            = the_passage_mnhn
                                                              , bdd_source              = the_bdd_source
                                                              , bdd_source_id_universal = the_bdd_source_id_universal
                                                              , survey_geotype          = the_survey_geotype
                WHERE
                    t_releve.bdd_source_id_universal = the_bdd_source_id_universal;
            --                         (t_releve.carre_numnat, t_releve.date, t_releve.point_num, t_releve.bdd_source_id_universal) =
--                         (the_carre_numnat, the_date, the_point_num, the_bdd_source_id_universal);

            RETURN new;
        END IF;
        RETURN new;
    END IF;
END;
$$
;


/* trigger sur les relevés
   - Sur les relevés avec un id_form_universal null uniquement pour éviter les erreurs sur les archives stoc FEPS et MNHN
 */
DROP TRIGGER IF EXISTS stoc_releve_upsert_from_vn_trigger ON import_vn.forms_json
;

CREATE TRIGGER stoc_releve_upsert_from_vn_trigger
    AFTER UPDATE OR INSERT
    ON import_vn.forms_json
    FOR EACH ROW
    WHEN (new.item #>> '{protocol, protocol_name}' LIKE 'STOC_%')
EXECUTE PROCEDURE pr_vigienature.upsert_releve()
;


/* Trigger sur les observations pour détecter les types de relevés (transect ou point d'écoute) */

CREATE OR REPLACE FUNCTION pr_vigienature.update_type_releves_from_obs() RETURNS TRIGGER AS
$$
DECLARE
    is_stoc_eps BOOLEAN;
BEGIN
    is_stoc_eps = new.id_form_universal IN
                  (SELECT bdd_source_id_universal FROM pr_vigienature.t_releve WHERE survey_geotype IS NULL);
    IF is_stoc_eps
    THEN
        UPDATE pr_vigienature.t_releve
        SET
            survey_geotype = CASE
                                 WHEN new.item #>> '{observers,0,precision}' LIKE 'transect%' THEN 'Transect'
                                 ELSE 'Point'
                END
            WHERE
                  bdd_source_id_universal = new.id_form_universal
              AND coalesce(survey_geotype, '') NOT LIKE 'Point';
    END IF;
    RETURN new;
END ;
$$
    LANGUAGE plpgsql
;

DROP TRIGGER IF EXISTS stoc_releve_update_survey_geotype_from_vn_trigger
    ON import_vn.observations_json
;

CREATE TRIGGER stoc_releve_update_survey_geotype_from_vn_trigger
    AFTER UPDATE OR INSERT
    ON import_vn.observations_json
    FOR EACH ROW
    --     WHEN pr_vigienature.is_stoc_eps_form(new.item, 'STOC_EPS')
    WHEN (new.id_form_universal IS NOT NULL)
EXECUTE PROCEDURE pr_vigienature.update_type_releves_from_obs()
;

/* Trigger sur les observations, conditions:
   id_form_universal not null and id_form_universal in (select id_form_universal from pr_vigienature.t_releve) */

CREATE OR REPLACE FUNCTION pr_vigienature.delete_obs_from_vn() RETURNS TRIGGER AS
$$
BEGIN
    DELETE
        FROM
            pr_vigienature.t_observation
        WHERE
            (bdd_source, bdd_source_id) = (old.site, old.id);
    IF NOT found
    THEN
        RETURN NULL;
    END IF;
    RETURN old;
END;
$$
    LANGUAGE plpgsql
;

CREATE TRIGGER stoc_observation_delete_from_vn_trigger
    AFTER DELETE
    ON import_vn.observations_json
    FOR EACH ROW
    WHEN (old.id_form_universal IS NOT NULL)
EXECUTE PROCEDURE pr_vigienature.delete_obs_from_vn()
;


CREATE OR REPLACE FUNCTION pr_vigienature.upsert_obs_from_vn() RETURNS TRIGGER AS
$$
DECLARE
    the_survey_id     INT;
    the_euring_codesp VARCHAR(20);
    is_stoc_eps       BOOLEAN;
    the_stoc_obs      RECORD;
BEGIN
    is_stoc_eps = new.id_form_universal IN (SELECT bdd_source_id_universal FROM pr_vigienature.t_releve);
    IF is_stoc_eps
    THEN
        the_survey_id = pr_vigienature.get_releve_id_from_id_form_uid(new.id_form_universal);
        the_euring_codesp =
                pr_vigienature.get_euring_code_from_vn_id_species(cast(new.item #>> '{species, @id}' AS INT));
        IF (tg_op = 'UPDATE')
        THEN
--         RAISE NOTICE 'DELETE DATA FROM RELEVE %', pr_vigienature.get_releve_id_from_id_form_uid(new.id_form_universal);
            DELETE
                FROM
                    pr_vigienature.t_observation
                WHERE
                      survey_id = the_survey_id
                  AND euring_codesp = the_euring_codesp;
        END IF;
        RAISE DEBUG 'INSERT DATA FROM RELEVE %', pr_vigienature.get_releve_id_from_id_form_uid(new.id_form_universal);
        INSERT
            INTO
            pr_vigienature.t_observation ( survey_id
                                         , euring_codesp
                                         , vn_is_species
                                         , count
                                         , distance
                                         , details
                                         , bdd_source
                                         , bdd_source_id
                                         , bdd_source_id_universal
                                         , update_ts)
        SELECT
            the_survey_id                                                             AS survey_id
          , the_euring_codesp                                                         AS euring_codesp
          , cast(obs.item #>> '{species, @id}' AS INT)                                AS species
          , (detail.obj ->> 'count')::INT                                             AS count
          , pr_vigienature.get_distance_label_from_vn_code(detail.obj ->> 'distance') AS dist
          , detail.obj                                                                AS details
          , obs.site                                                                  AS bdd_source
          , obs.id                                                                    AS bdd_source_id
          , obs.item #>> '{observers,0,id_universal}'                                 AS bdd_source_id_universal
          , to_timestamp(obs.update_ts)                                               AS update_ts
            FROM
                new AS obs
                    LEFT JOIN LATERAL jsonb_array_elements(obs.item #> '{observers,0,details}') AS detail (obj) ON TRUE
            RETURNING * INTO the_stoc_obs;
        RAISE DEBUG 'Observation % (%,%) inserted',the_stoc_obs, new.site, new.id;
    END IF;
    RETURN NULL;
END ;
$$
    LANGUAGE plpgsql
;

DROP TRIGGER IF EXISTS stoc_observation_upsert_from_vn_trigger
    ON import_vn.observations_json
;

CREATE TRIGGER stoc_observation_upsert_from_vn_trigger
    AFTER UPDATE OR INSERT
    ON import_vn.observations_json
    FOR EACH ROW
--     WHEN pr_vigienature.is_stoc_eps_form(new.item, 'STOC_EPS')
    WHEN (new.id_form_universal IS NOT NULL)
EXECUTE PROCEDURE pr_vigienature.upsert_obs_from_vn()
;
