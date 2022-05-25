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


        DROP FUNCTION IF EXISTS pr_vigienature.fct_get_specie_from_vn_id_species;

        CREATE OR REPLACE FUNCTION pr_vigienature.fct_get_specie_from_vn_id_species(_id_species INT)
            RETURNS INT AS
        $get_specie_from_vn_id_species$
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
                  AND ref_tax IS TRUE
                LIMIT 1;
            RETURN the_id;
        END ;
        $get_specie_from_vn_id_species$
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

        DROP FUNCTION IF EXISTS pr_vigienature.fct_tri_delete_releve;
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


        CREATE OR REPLACE FUNCTION pr_vigienature.fct_tri_upsert_releve() RETURNS TRIGGER
            LANGUAGE plpgsql
        AS
        $upsert_releve$
        DECLARE
            the_date                    DATE;
            the_time                    TIME;
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
            the_site                    BOOLEAN;
            the_geom_point              GEOMETRY(point, 2154);
            the_nom_protocole           VARCHAR(50);
            the_bdd_source_id_universal VARCHAR(20);
            the_bdd_source              VARCHAR(20);
            the_bdd_source_id           INTEGER;
            the_type_releve             VARCHAR(20);
            the_source_data             JSONB;
        BEGIN
            the_date = cast(new.item ->> 'date_start' AS DATE);
            the_time = cast(new.item ->> 'time_start' AS TIME);
            the_observer = pr_vigienature.fct_get_observer_from_vn(cast(new.item ->> '@uid' AS INT), new.site);
            the_carre_numnat = CASE
                                   WHEN new.item #>> '{protocol, protocol_name}' LIKE 'STOC_EPS'
                                       THEN cast(new.item #>> '{protocol, site_code}' AS INT)
                END;
            the_carre_suivi_id = pr_vigienature.fct_get_carre_suivi_id(the_carre_numnat);
            the_point_num = cast(new.item #>> '{protocol, sequence_number}' AS INT);
            the_site_name = CASE
                                WHEN new.item #>> '{protocol, protocol_name}' LIKE 'STOC_SITES'
                                    THEN new.item #>> '{protocol, site_code}'
                END;
            the_geom_point = st_transform(
                    st_setsrid(st_makepoint(cast(new.item ->> 'lon' AS FLOAT), cast(new.item ->> 'lat' AS FLOAT)),
                               4326), 2154);
            the_altitude = pr_vigienature.fct_get_altitude_from_dem(the_geom_point);
            the_nuage_id = pr_vigienature.fct_get_nomenclature('NUAGE', new.item #>> '{protocol, stoc_cloud}');
            the_pluie_id = pr_vigienature.fct_get_nomenclature('PLUIE', new.item #>> '{protocol, stoc_rain}');
            the_vent_id = pr_vigienature.fct_get_nomenclature('VENT', new.item #>> '{protocol, stoc_wind}');
            the_visibilite_id =
                    pr_vigienature.fct_get_nomenclature('VISIBILITE', new.item #>> '{protocol, stoc_visibility}');
            the_p_milieu_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hp1}');
            the_p_type_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hp2}');
            the_p_cat1_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hp3A}');
            the_p_cat2_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hp3B}');
            the_p_ss_cat1_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hp4A}');
            the_p_ss_cat2_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hp4B}');
            the_s_milieu_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hs1}');
            the_s_type_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hs2}');
            the_s_cat1_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hs3A}');
            the_s_cat2_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hs3B}');
            the_s_ss_cat1_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hs4A}');
            the_s_ss_cat2_id = pr_vigienature.fct_get_nomenclature('HABITAT', new.item #>> '{protocol, habitat, hs4B}');
            the_site = CASE
                           WHEN new.item #>> '{protocol, protocol_name}' LIKE 'STOC_SITES'
                               THEN TRUE
                           ELSE FALSE END;
            the_nom_protocole = new.item #>> '{protocol, protocol_name}';
            the_passage_mnhn = cast(new.item #>> '{protocol, visit_number}' AS INT);
            the_bdd_source_id_universal = new.item ->> 'id_form_universal';
            the_bdd_source = new.site;
            the_bdd_source_id = new.id;
            the_type_releve = CASE
                                  WHEN (new.item -> 'protocol' ? 'stoc_transport' OR
                                        new.item #>> '{protocol, protocol_name}' LIKE 'SHOC')
                                      THEN 'Transect'
                                  ELSE 'Point' END;
            the_source_data = new.item;
            IF (tg_op IN ('UPDATE', 'INSERT'))
            THEN
                INSERT INTO
                    pr_vigienature.t_releve ( date
                                            , time
                                            , observer
                                            , carre_numnat
                                            , point_num
                                            , site_name
                                            , altitude
                                            , nuage_id
                                            , pluie_id
                                            , vent_id
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
                                            , site
                                            , geom_point
                                            , passage_mnhn
                                            , nom_protocole
                                            , bdd_source
                                            , bdd_source_id
                                            , bdd_source_id_universal
                                            , type_releve
                                            , source_data)
                    VALUES
                        ( the_date
                        , the_time
                        , the_observer
                        , the_carre_numnat
                        , the_point_num
                        , the_site_name
                        , the_altitude
                        , the_nuage_id
                        , the_pluie_id
                        , the_vent_id
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
                        , the_site
                        , the_geom_point
                        , the_passage_mnhn
                        , the_nom_protocole
                        , the_bdd_source
                        , the_bdd_source_id
                        , the_bdd_source_id_universal
                        , the_type_releve
                        , the_source_data)
                ON CONFLICT (bdd_source_id_universal) DO UPDATE
                    SET
                        date                    = the_date
                      , time                    = the_time
                      , observer                = the_observer
                      , carre_numnat            = the_carre_numnat
                      , point_num               = the_point_num
                      , site_name               = the_site_name
                      , altitude                = the_altitude
                      , nuage_id                = the_nuage_id
                      , pluie_id                = the_pluie_id
                      , vent_id                 = the_vent_id
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
                      , site                    = the_site
                      , geom_point              = the_geom_point
                      , passage_mnhn            = the_passage_mnhn
                      , nom_protocole           = the_nom_protocole
                      , bdd_source              = the_bdd_source
                      , bdd_source_id           = the_bdd_source_id
                      , bdd_source_id_universal = the_bdd_source_id_universal
                      , type_releve             = the_type_releve
                      , source_data             = the_source_data;

            END IF;
            RETURN new;
        END;
        $upsert_releve$;
        COMMIT;
    END
$$
;
