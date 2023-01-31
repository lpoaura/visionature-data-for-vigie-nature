/*
INITIALISATION DE LA STRUCTURE DES DONNEES
-----
Créatiop d'un schéma et des tables de centralisation des données VigieNature
 */
DO
$$
    BEGIN

        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_nomenclature_type;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_nomenclature_type(_type_code TEXT) RETURNS INT AS
        $get_nomenclature_type$
        DECLARE
            the_id INT ;
        BEGIN
            SELECT
                id
                INTO
                    the_id
                FROM
                    pr_vigienature.bib_nomenclature_type
                WHERE
                    bib_nomenclature_type.code = _type_code;
            RETURN the_id;
        END ;
        $get_nomenclature_type$
            LANGUAGE plpgsql;


        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_id_nomenclature;

        CREATE FUNCTION pr_vigienature.fct_get_id_nomenclature(_type_code TEXT, _nomenclature_code TEXT) RETURNS INTEGER
            LANGUAGE plpgsql
        AS
        $fct_get_id_nomenclature$
        DECLARE
            the_id INT ;
        BEGIN
            SELECT
                id
                INTO
                    the_id
                FROM
                    pr_vigienature.t_nomenclature
                WHERE
                      t_nomenclature.code = _nomenclature_code
                  AND type_id = pr_vigienature.fct_get_nomenclature_type(_type_code);
            RETURN the_id;
        END ;
        $fct_get_id_nomenclature$;


        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_nomenclature;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_nomenclature(_type_code TEXT, _vn_code TEXT) RETURNS INT AS
        $get_releve_info$
        DECLARE
            the_id INT ;
        BEGIN
            SELECT
                id
                INTO
                    the_id
                FROM
                    pr_vigienature.t_nomenclature
                WHERE
                      t_nomenclature.code_vn = _vn_code
                  AND type_id = pr_vigienature.fct_get_nomenclature_type(_type_code);
            RETURN the_id;
        END ;
        $get_releve_info$
            LANGUAGE plpgsql;


        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_altitude_from_dem;

        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_altitude_from_dem(_geom GEOMETRY(POINT, 2154))
            RETURNS INT AS
        $get_altitude_from_dem$
        DECLARE
            the_altitude INT;
        BEGIN
            SELECT
                st_value(rast, _geom)::INT
                INTO
                    the_altitude
                FROM
                    ref_geo.dem
                WHERE
                    st_intersects(
                            rast
                        , _geom);
            RETURN the_altitude;
        END ;
        $get_altitude_from_dem$
            LANGUAGE plpgsql;


        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_taxon_id;

        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_taxon_id(_id_species INT)
            RETURNS INT AS
        $get_taxon_id$
        DECLARE
            the_id INT;
        BEGIN
            SELECT
                cor_taxon_referentiels.id
                INTO the_id
                FROM
                    pr_vigienature.cor_taxon_referentiels
                WHERE
                    vn_id_species = _id_species
--                   AND ref_tax IS TRUE
                LIMIT 1;
            RETURN the_id;
        END ;
        $get_taxon_id$
            LANGUAGE plpgsql;


        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_releve_id_from_id_form_uid;

        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_releve_id_from_id_form_uid(_id_form_universal VARCHAR(50))
            RETURNS INT AS
        $get_releve_id_from_id_form_uid$
        DECLARE
            the_id INT;
        BEGIN

            SELECT
                t_releve.id
                INTO the_id
                FROM
                    pr_vigienature.t_releve
                WHERE
                    bdd_source_id_universal = _id_form_universal
                LIMIT 1;
            RETURN the_id;
        END ;
        $get_releve_id_from_id_form_uid$
            LANGUAGE plpgsql;

        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_carre_suivi_id;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_carre_suivi_id(_carre_numnat INT)
            RETURNS INT AS
        $get_carre_suivi_id$
        DECLARE
            the_id INT;
        BEGIN
            SELECT
                l_carre_suivi.id
                INTO the_id
                FROM
                    pr_vigienature.l_carre_suivi
                WHERE
                    _carre_numnat = l_carre_suivi.numnat
                LIMIT 1;
            RETURN the_id;
        END ;
        $get_carre_suivi_id$
            LANGUAGE plpgsql;

        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_observer_from_vn(_uid INT, _site VARCHAR) RETURNS VARCHAR(100) AS
        $get_observer_from_vn$
        DECLARE
            the_observer VARCHAR(100);
        BEGIN
            SELECT
                upper((item ->> 'name')) || ' ' || (item ->> 'surname')
                INTO the_observer
                FROM
                    src_vn_json.observers_json
                WHERE
                      id_universal = _uid
                  AND site = _site;
            RETURN the_observer;
        END ;
        $get_observer_from_vn$
            LANGUAGE plpgsql;

        DROP FUNCTION IF EXISTS pr_vigienature.fct_tri_delete_releve CASCADE;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_tri_delete_releve() RETURNS TRIGGER AS
        $delete_releve$
        BEGIN
            -- Deleting data on src_vn.observations when raw data is deleted
            RAISE DEBUG '[VigieNature] DELETE RELEVE %', old;
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
        $delete_releve$
            LANGUAGE plpgsql;

        DROP FUNCTION IF EXISTS pr_vigienature.fct_tri_upsert_releve CASCADE;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_tri_upsert_releve() RETURNS TRIGGER
            LANGUAGE plpgsql
        AS
        $upsert_releve$
        DECLARE
            the_date_start              DATE;
            the_time_start              TIME;
            the_date_stop               DATE;
            the_time_stop               TIME;
            the_observer                VARCHAR(100);
            the_carre_suivi_id          INTEGER;
            the_carre_numnat            INTEGER;
            the_point_num               INTEGER;
            the_site_name               VARCHAR(250);
            the_passage_mnhn            INTEGER;
            the_altitude                INTEGER;
            the_nuage_id                INTEGER;
            the_pluie_id                INTEGER;
            the_vent_id                 INTEGER;
            the_neige_id                INTEGER;
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
            the_geom_point              public.GEOMETRY(point, 2154);
            the_nom_protocole           VARCHAR(50);
            the_bdd_source_id_universal VARCHAR(20);
            the_bdd_source              VARCHAR(20);
            the_bdd_source_id           INTEGER;
            the_type_releve             VARCHAR(20);
            the_source_data             JSONB;
        BEGIN
            the_date_start = cast(new.item ->> 'date_start' AS DATE);
            the_time_start = cast(new.item ->> 'time_start' AS TIME);
            the_date_stop = cast(new.item ->> 'date_stop' AS DATE);
            the_time_stop = cast(new.item ->> 'time_stop' AS TIME);
            the_observer = new.item ->> '@uid' AS int;
            the_carre_numnat = CASE
                                   WHEN ((new.item #>> '{protocol, site_code}') ~ '^[0-9\.]+$' AND
                                         new.item #>> '{protocol, protocol_name}' IN ('STOC_EPS', 'SHOC'))
                                       THEN cast(new.item #>> '{protocol, site_code}' AS INT)
                END;
            RAISE DEBUG 'the_carre_numnat %',the_carre_numnat;
            the_carre_suivi_id = pr_vigienature.fct_get_carre_suivi_id(the_carre_numnat);
            the_point_num = cast(new.item #>> '{protocol, sequence_number}' AS INT);
            the_site_name = CASE
                                WHEN ((new.item #>> '{protocol, site_code}') !~ '^[0-9\.]+$' OR
                                      new.item #>> '{protocol, protocol_name}' NOT IN ('STOC_EPS', 'SHOC'))
                                    THEN coalesce(new.item #>> '{protocol, site_code}',
                                                  new.item #>> '{protocol, local_site_code}')
                END;
            the_geom_point = st_transform(
                    st_setsrid(st_makepoint(cast(new.item ->> 'lon' AS FLOAT), cast(new.item ->> 'lat' AS FLOAT)),
                               4326), 2154);
            the_nuage_id = pr_vigienature.fct_get_nomenclature('CLOUD', new.item #>> '{protocol, stoc_cloud}');
            the_pluie_id = pr_vigienature.fct_get_nomenclature('RAIN', new.item #>> '{protocol, stoc_rain}');
            the_vent_id = pr_vigienature.fct_get_nomenclature('WIND', new.item #>> '{protocol, stoc_wind}');
            the_neige_id = pr_vigienature.fct_get_nomenclature('SNOW', new.item #>> '{protocol, stoc_snow}');
            the_visibilite_id =
                    pr_vigienature.fct_get_nomenclature('VISIBILITY', new.item #>> '{protocol, stoc_visibility}');
            the_p_milieu_id = pr_vigienature.fct_get_nomenclature('HAB_ENV', new.item #>> '{protocol, habitat, hp1}');
            the_p_type_id = pr_vigienature.fct_get_nomenclature('HAB_TYP', new.item #>> '{protocol, habitat, hp2}');
            the_p_cat1_id = pr_vigienature.fct_get_nomenclature('HAB_CAT1', new.item #>> '{protocol, habitat, hp3A}');
            the_p_cat2_id = pr_vigienature.fct_get_nomenclature('HAB_CAT1', new.item #>> '{protocol, habitat, hp3B}');
            the_p_ss_cat1_id =
                    pr_vigienature.fct_get_nomenclature('HAB_CAT2', new.item #>> '{protocol, habitat, hp4A}');
            the_p_ss_cat2_id =
                    pr_vigienature.fct_get_nomenclature('HAB_CAT2', new.item #>> '{protocol, habitat, hp4B}');
            the_s_milieu_id = pr_vigienature.fct_get_nomenclature('HAB_ENV', new.item #>> '{protocol, habitat, hs1}');
            the_s_type_id = pr_vigienature.fct_get_nomenclature('HAB_TYP', new.item #>> '{protocol, habitat, hs2}');
            the_s_cat1_id = pr_vigienature.fct_get_nomenclature('HAB_CAT1', new.item #>> '{protocol, habitat, hs3A}');
            the_s_cat2_id = pr_vigienature.fct_get_nomenclature('HAB_CAT1', new.item #>> '{protocol, habitat, hs3B}');
            the_s_ss_cat1_id =
                    pr_vigienature.fct_get_nomenclature('HAB_CAT2', new.item #>> '{protocol, habitat, hs4A}');
            the_s_ss_cat2_id =
                    pr_vigienature.fct_get_nomenclature('HAB_CAT2', new.item #>> '{protocol, habitat, hs4B}');
            the_nom_protocole = new.item #>> '{protocol, protocol_name}';
            the_passage_mnhn = cast(new.item #>> '{protocol, visit_number}' AS INT);
            the_bdd_source_id_universal = new.item ->> 'id_form_universal';
            the_bdd_source = new.site;
            the_bdd_source_id = new.id;
            the_type_releve = CASE
                                  WHEN (new.item -> 'protocol' ? 'stoc_transport' OR
                                        new.item #>> '{protocol, protocol_name}' LIKE 'SHOC')
                                      THEN 'transect'
                                  ELSE 'point' END;
            the_source_data = new.item;
            IF (tg_op IN ('UPDATE', 'INSERT'))
            THEN
                INSERT INTO
                    pr_vigienature.t_releve ( date_debut
                                            , heure_debut
                                            , date_fin
                                            , heure_fin
                                            , observateur
                                            , carre_suivi_id
                                            , carre_numnat
                                            , point_num
                                            , site_name
--                                             , altitude
                                            , nuage_id
                                            , pluie_id
                                            , vent_id
                                            , neige_id
                                            , visibilite_id
                                            , p_milieu_id
                                            , p_type_id
                                            , p_cat1_id
                                            , p_cat2_id
                                            , p_ss_cat1_id
                                            , p_ss_cat2_id
                                            , s_milieu_id
                                            , s_type_id
                                            , s_cat1_id
                                            , s_cat2_id
                                            , s_ss_cat1_id
                                            , s_ss_cat2_id
                                            , geom_point
                                            , passage_mnhn
                                            , nom_protocole
                                            , bdd_source
                                            , bdd_source_id
                                            , bdd_source_id_universal
                                            , type_releve
                                            , source_data
                                            , update_ts)
                    VALUES
                        ( the_date_start
                        , the_time_start
                        , the_date_stop
                        , the_time_stop
                        , the_observer
                        , the_carre_suivi_id
                        , the_carre_numnat
                        , the_point_num
                        , the_site_name
--                         , the_altitude
                        , the_nuage_id
                        , the_pluie_id
                        , the_vent_id
                        , the_neige_id
                        , the_visibilite_id
                        , the_p_milieu_id
                        , the_p_type_id
                        , the_p_cat1_id
                        , the_p_cat2_id
                        , the_p_ss_cat1_id
                        , the_p_ss_cat2_id
                        , the_s_milieu_id
                        , the_s_type_id
                        , the_s_cat1_id
                        , the_s_cat2_id
                        , the_s_ss_cat1_id
                        , the_s_ss_cat2_id
                        , the_geom_point
                        , the_passage_mnhn
                        , the_nom_protocole
                        , the_bdd_source
                        , the_bdd_source_id
                        , the_bdd_source_id_universal
                        , the_type_releve
                        , the_source_data
                        , now())
                ON CONFLICT (bdd_source_id_universal) DO UPDATE
                    SET
                        date_debut              = the_date_start
                      , heure_debut             = the_time_start
                      , date_fin                = the_date_stop
                      , heure_fin               = the_time_stop
                      , observateur             = the_observer
                      , carre_suivi_id          = the_carre_suivi_id
                      , carre_numnat            = the_carre_numnat
                      , point_num               = the_point_num
                      , site_name               = the_site_name
--                       , altitude                = the_altitude
                      , nuage_id                = the_nuage_id
                      , pluie_id                = the_pluie_id
                      , vent_id                 = the_vent_id
                      , neige_id                = the_neige_id
                      , visibilite_id           = the_visibilite_id
                      , p_milieu_id             = the_p_milieu_id
                      , p_type_id               = the_p_type_id
                      , p_cat1_id               = the_p_cat1_id
                      , p_cat2_id               = the_p_cat2_id
                      , p_ss_cat1_id            = the_p_ss_cat1_id
                      , p_ss_cat2_id            = the_p_ss_cat2_id
                      , s_milieu_id             = the_s_milieu_id
                      , s_type_id               = the_s_type_id
                      , s_cat1_id               = the_s_cat1_id
                      , s_cat2_id               = the_s_cat2_id
                      , s_ss_cat1_id            = the_s_ss_cat1_id
                      , s_ss_cat2_id            = the_s_ss_cat2_id
                      , geom_point              = the_geom_point
                      , passage_mnhn            = the_passage_mnhn
                      , nom_protocole           = the_nom_protocole
                      , bdd_source              = the_bdd_source
                      , bdd_source_id           = the_bdd_source_id
                      , bdd_source_id_universal = the_bdd_source_id_universal
                      , type_releve             = the_type_releve
                      , source_data             = the_source_data
                      , update_ts               = now();

            END IF;
            RETURN new;
        END ;
        $upsert_releve$;

        DROP FUNCTION IF EXISTS pr_vigienature.fct_tri_update_releve_altitude CASCADE;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_tri_update_releve_altitude() RETURNS TRIGGER AS
        $upsert_alti$
        BEGIN
            IF (
                    (old IS NULL OR old.altitude IS NULL)-- Pas de old
                    OR ((NOT old.geom_point ~= new.geom_point) AND new.geom_point IS NOT NULL)-- old is not null but new geom is different
                )
            THEN
                UPDATE pr_vigienature.t_releve
                SET
                    altitude = pr_vigienature.fct_get_altitude_from_dem(new.geom_point)
                    WHERE
                        t_releve.id = new.id;
            END IF;
            RETURN new;
        END;
        $upsert_alti$ LANGUAGE plpgsql;


        DROP FUNCTION IF EXISTS pr_vigienature.fct_tri_update_obs CASCADE;
        CREATE OR REPLACE FUNCTION pr_vigienature.fct_tri_update_obs() RETURNS TRIGGER AS
        $upsert_obs$
        DECLARE
            the_releve     RECORD;
            the_taxon_id   INT;
            the_nom_cite   VARCHAR;
            is_vigienature BOOLEAN;
        BEGIN
            is_vigienature = new.id_form_universal IN (SELECT bdd_source_id_universal FROM pr_vigienature.t_releve);
            IF is_vigienature
            THEN
                SELECT *
                    INTO the_releve
                    FROM
                        pr_vigienature.t_releve
                    WHERE
                        bdd_source_id_universal = new.id_form_universal;
                the_taxon_id = pr_vigienature.fct_get_taxon_id(cast(new.item #>> '{species, @id}' AS INT));
                SELECT
                    item ->> 'latin_name'
                    INTO the_nom_cite
                    FROM
                        src_vn_json.species_json
                    WHERE
                            (new.site, cast(new.item #>> '{species, @id}' AS INT)) =
                            (species_json.site, species_json.id);
                IF (tg_op IN ('INSERT', 'UPDATE')) THEN
                    DELETE
                        FROM
                            pr_vigienature.t_observation
                        WHERE
                            uuid = cast(new.item #>> '{observers,0,uuid}' AS UUID);
                    INSERT INTO
                        pr_vigienature.t_observation( uuid
                                                    , releve_id
                                                    , taxon_id
                                                    , nom_cite
                                                    , nombre
                                                    , distance_id
                                                    , details
                                                    , bdd_source_id
                                                    , bdd_source_id_universal
                                                    , source_data
                                                    , update_ts)
                    SELECT
                        cast(obs.item #>> '{observers,0,uuid}' AS UUID)
                      , the_releve.id
                      , the_taxon_id
                      , the_nom_cite
                      , (detail.obj ->> 'count')::INT
                      , pr_vigienature.fct_get_nomenclature('DISTANCE', detail.obj ->> 'distance')
                      , detail.obj
                      , obs.id
                      , obs.item #>> '{observers,0,id_universal}'
                      , obs.item
                      , now()
                        FROM
                            (SELECT
                                 new.id
                               , new.site
                               , new.item
                               , new.id_form_universal
                               , new.update_ts) AS obs
                                LEFT JOIN LATERAL jsonb_array_elements(obs.item #> '{observers,0,details}') AS detail (obj)
                                          ON TRUE;
                    IF (the_releve.type_releve NOT LIKE 'transect' AND new.item #>> '{observers,0,precision}' LIKE
                                                                       'transect%')
                    THEN
                        UPDATE pr_vigienature.t_releve
                        SET
                            type_releve = CASE
                                              WHEN new.item #>> '{observers,0,precision}' LIKE 'transect%'
                                                  THEN 'transect'
                                              ELSE 'point'
                                END
                          , update_ts   = now()
                            WHERE
                                  t_releve.id = the_releve.id
                              AND coalesce(type_releve, '') NOT LIKE 'point'
                            RETURNING * INTO the_releve;
                    END IF;
                    IF (the_releve.geom_transect IS NULL AND the_releve.type_releve LIKE 'transect')
                    THEN
                        UPDATE pr_vigienature.t_releve
                        SET
                            geom_transect = public.st_multi(
                                    public.st_transform(
                                            public.st_setsrid(
                                                    public.st_geomfromtext(nullif(pl.item ->> 'wkt', '')), 4326),
                                            2154))
                          , update_ts=now()
                            FROM
                                src_vn_json.places_json pl
                            WHERE
                                  t_releve.id = the_releve.id
                              AND (pl.site, pl.id) = (new.site, (new.item #>> '{place,@id}')::INT);
                    END IF;
                END IF;
            END IF;
            RETURN NULL;
        END;
        $upsert_obs$
            LANGUAGE plpgsql;


        /* End of transaction */
        COMMIT;
    END
$$
;
