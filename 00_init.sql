/*
INITIALISATION DE LA STRUCTURE DES DONNEES
-----
Créatiop d'un schéma et des tables de centralisation des données VigieNature
 */
DO
$$
    BEGIN

        DROP SCHEMA pr_vigienature CASCADE;

        CREATE SCHEMA IF NOT EXISTS pr_vigienature;

        CREATE TABLE IF NOT EXISTS pr_vigienature.l_carre_suivi
        (
            id       INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
            carrenat INTEGER,
            numnat   INTEGER,
            geom     GEOMETRY(Polygon, 2154)
        );

        COMMENT ON TABLE pr_vigienature.l_carre_suivi IS 'Liste des Carrés de suivi STOC (mailles 2x2km)';
        COMMENT ON COLUMN pr_vigienature.l_carre_suivi.carrenat IS '?';
        COMMENT ON COLUMN pr_vigienature.l_carre_suivi.numnat IS '?';
        COMMENT ON COLUMN pr_vigienature.l_carre_suivi.geom IS 'Géométrie (SRID:2154)';


        CREATE INDEX l_carre_suivi_geom_idx
            ON pr_vigienature.l_carre_suivi USING gist (geom);


        ALTER TABLE pr_vigienature.l_carre_suivi
            ADD CONSTRAINT l_carre_suivi_numnat UNIQUE (numnat);

        /* Table dictionnaire des codes espèces */
/*DROP TABLE IF EXISTS pr_vigienature.cor_taxon_referentiels;*/

        CREATE TABLE pr_vigienature.cor_taxon_referentiels
        (
            id            INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
            euring_code   VARCHAR(20),
            euring_num    INTEGER,
            cd_nom        INTEGER,
            vn_id_species INTEGER,
            ref_tax       BOOLEAN
        );

        COMMENT ON TABLE pr_vigienature.cor_taxon_referentiels IS 'Table de correspondancs des référentiels espèces (EURING, TAXREF, VisioNature)';
        COMMENT ON COLUMN pr_vigienature.cor_taxon_referentiels.euring_code IS 'Code EURING';
        COMMENT ON COLUMN pr_vigienature.cor_taxon_referentiels.euring_num IS 'Numéro EURING';
        COMMENT ON COLUMN pr_vigienature.cor_taxon_referentiels.cd_nom IS 'CD_NOM TaxRef';
        COMMENT ON COLUMN pr_vigienature.cor_taxon_referentiels.vn_id_species IS 'Identifiant VisioNature';
        COMMENT ON COLUMN pr_vigienature.cor_taxon_referentiels.ref_tax IS 'Est un taxon référence ?';

        CREATE INDEX cor_taxon_referentiels_idx_euring_code ON pr_vigienature.cor_taxon_referentiels (euring_code);
        CREATE INDEX cor_taxon_referentiels_idx_cd_nom ON pr_vigienature.cor_taxon_referentiels (cd_nom);
        CREATE INDEX cor_taxon_referentiels_idx_vn_id ON pr_vigienature.cor_taxon_referentiels (vn_id_species);


        /* Table des correspondances des distances */
--DROP TABLE pr_vigienature.dict_distance_code;

        CREATE TABLE pr_vigienature.bib_nomenclature_type
        (
            id                    INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
            code                  VARCHAR(20),
            libelle               VARCHAR(200),
            libelle_international VARCHAR(200),
            additional_data       JSONB
        );

        COMMENT ON TABLE pr_vigienature.bib_nomenclature_type IS 'Liste des types de nomenclatures utilisées par VigieNature';
        COMMENT ON COLUMN pr_vigienature.bib_nomenclature_type.code IS 'Code du type de nomenclature';
        COMMENT ON COLUMN pr_vigienature.bib_nomenclature_type.code IS 'Libellé';
        COMMENT ON COLUMN pr_vigienature.bib_nomenclature_type.code IS 'Libellé international';
        COMMENT ON COLUMN pr_vigienature.bib_nomenclature_type.code IS 'Données additionelles au format JSON';

        CREATE INDEX idx_bib_nomenclature_type_id ON pr_vigienature.bib_nomenclature_type (id);
        CREATE INDEX idx_bib_nomenclature_type_code ON pr_vigienature.bib_nomenclature_type (code);

        CREATE TABLE pr_vigienature.t_nomenclature
        (
            id                    INTEGER PRIMARY KEY GENERATED BY DEFAULT AS IDENTITY,
            type_id               INT REFERENCES pr_vigienature.bib_nomenclature_type (id),
            code                  VARCHAR(100),
            code_vn               VARCHAR(20),
            libelle               VARCHAR(200),
            libelle_international VARCHAR(200),
            additional_data       JSONB
        );

        COMMENT ON TABLE pr_vigienature.t_nomenclature IS 'Table des nomenclatures utilisée dans VigieNature et correspondance avec les codes VisioNature';
        COMMENT ON COLUMN pr_vigienature.t_nomenclature.type_id IS 'Clé étrangère vers le type de nomenclature';
        COMMENT ON COLUMN pr_vigienature.t_nomenclature.code IS 'Code officiel';
        COMMENT ON COLUMN pr_vigienature.t_nomenclature.code_vn IS 'Code VisioNature';
        COMMENT ON COLUMN pr_vigienature.t_nomenclature.libelle IS 'Libellé français';
        COMMENT ON COLUMN pr_vigienature.t_nomenclature.libelle_international IS 'Libellé international';
        COMMENT ON COLUMN pr_vigienature.t_nomenclature.additional_data IS 'Données additionelles au format JSON';

        CREATE INDEX idx_nomenclature_id ON pr_vigienature.t_nomenclature (id);
--         CREATE UNIQUE INDEX idx_nomenclature_code ON pr_vigienature.t_nomenclature (type_id, code);
        CREATE UNIQUE INDEX idx_nomenclature_code_vn ON pr_vigienature.t_nomenclature (type_id, code_vn);

        /* Table des relevés */
-- DROP TABLE IF EXISTS pr_vigienature.t_releve CASCADE
-- ;

        CREATE TABLE pr_vigienature.t_releve
        (
            id                      SERIAL                NOT NULL PRIMARY KEY,        -- Clé primaire
            date_debut              DATE                  NOT NULL,                    -- Date de début
            heure_debut             TIME                  NOT NULL,                    -- Heure de debut
            date_fin                DATE                  NOT NULL,                    -- Date de fin
            heure_fin               TIME                  NOT NULL,                    -- Heure de fin
            observateur             VARCHAR(100),                                      -- Observateur
            carre_suivi_id          INT REFERENCES pr_vigienature.l_carre_suivi (id),  -- Clé étrangère vers le carré de suivi
            carre_numnat            INTEGER,                                           -- Référence du carré
            point_num               INTEGER,                                           -- Référence du point
            site_name               VARCHAR(250),                                      -- Nom du site (pour STOC sites)
            passage_mnhn            INTEGER,                                           -- Numéro de passage MNHN
            altitude                INTEGER,                                           -- Altitude
            nuage_id                INT REFERENCES pr_vigienature.t_nomenclature (id), -- Couverture nuageuse
            pluie_id                INT REFERENCES pr_vigienature.t_nomenclature (id), -- Pluie
            vent_id                 INT REFERENCES pr_vigienature.t_nomenclature (id), -- Vent
            visibilite_id           INT REFERENCES pr_vigienature.t_nomenclature (id), -- Visibilité
            p_milieu_id             INT REFERENCES pr_vigienature.t_nomenclature (id), -- Milieu principal
            p_type_id               INT REFERENCES pr_vigienature.t_nomenclature (id), -- Type du milieu principal
            p_cat1_id               INT REFERENCES pr_vigienature.t_nomenclature (id), -- Catégorie 1 du milieu principal
            p_cat2_id               INT REFERENCES pr_vigienature.t_nomenclature (id), -- Catégorie 2 du milieu principal
            p_ss_cat1_id            INT REFERENCES pr_vigienature.t_nomenclature (id), -- Sous-catégorie 1 du milieu principal
            p_ss_cat2_id            INT REFERENCES pr_vigienature.t_nomenclature (id), -- Sous-catégorie 2 du milieu principal
            s_milieu_id             INT REFERENCES pr_vigienature.t_nomenclature (id), -- Milieu secondaire
            s_type_id               INT REFERENCES pr_vigienature.t_nomenclature (id), -- Type du milieu secondaire
            s_cat1_id               INT REFERENCES pr_vigienature.t_nomenclature (id), -- Catégorie 1 du milieu secondaire
            s_cat2_id               INT REFERENCES pr_vigienature.t_nomenclature (id), -- Catégorie 2 du milieu secondaire
            s_ss_cat1_id            INT REFERENCES pr_vigienature.t_nomenclature (id), -- Sous-catégorie 1 du milieu secondaire
            s_ss_cat2_id            INT REFERENCES pr_vigienature.t_nomenclature (id), -- Sous catégorie 2 du milieu secondaire
            bdd_source              VARCHAR(50)           NOT NULL,                    -- Base de donnée source
            bdd_source_id           INTEGER               NOT NULL,                    -- identifiant dans la base de donnée source
            bdd_source_id_universal VARCHAR(250) UNIQUE   NOT NULL,                    -- Identifiant unique universel dans la base de donnée source
            type_releve             VARCHAR(20)           NOT NULL,                    -- Type de relevé (point vs transect)
            nom_protocole           VARCHAR(20)           NOT NULL,                    -- Code du protocole (STOC EPS, STOC SITE, SHOC, etc.)
            geom_point              GEOMETRY(point, 2154) NOT NULL,                    -- Geométrie de type point
            geom_transect           GEOMETRY(multilinestring, 2154),                   -- Géométrie de type transect
            source_data             JSONB                 NOT NULL,                    -- Donnée source au format JSON
            update_ts
                                    TIMESTAMP,
            CONSTRAINT type_esp_con CHECK (type_releve IN ('point', 'transect') OR type_releve IS NULL)
        );
/* Commentaire des champs de la table pr_vigienature.t_releve */
        COMMENT ON TABLE pr_vigienature.t_releve IS 'Table des Relevés Vigie-Nature';
        COMMENT ON COLUMN pr_vigienature.t_releve.id IS 'Clé primaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.date_debut IS 'Date de début';
        COMMENT ON COLUMN pr_vigienature.t_releve.heure_debut IS 'Heure de début';
        COMMENT ON COLUMN pr_vigienature.t_releve.date_fin IS 'Date de fin';
        COMMENT ON COLUMN pr_vigienature.t_releve.heure_fin IS 'Heure de fin';
        COMMENT ON COLUMN pr_vigienature.t_releve.observateur IS 'Observateur';
        COMMENT ON COLUMN pr_vigienature.t_releve.carre_numnat IS 'Référence du carré';
        COMMENT ON COLUMN pr_vigienature.t_releve.point_num IS 'Référence du point';
        COMMENT ON COLUMN pr_vigienature.t_releve.site_name IS 'Nom du site (pour STOC sites)';
        COMMENT ON COLUMN pr_vigienature.t_releve.passage_mnhn IS 'Numéro de passage MNHN';
        COMMENT ON COLUMN pr_vigienature.t_releve.altitude IS 'Altitude';
        COMMENT ON COLUMN pr_vigienature.t_releve.nuage_id IS 'Couverture nuageuse';
        COMMENT ON COLUMN pr_vigienature.t_releve.pluie_id IS 'Pluie';
        COMMENT ON COLUMN pr_vigienature.t_releve.vent_id IS 'Vent';
        COMMENT ON COLUMN pr_vigienature.t_releve.visibilite_id IS 'Visibilité';
        COMMENT ON COLUMN pr_vigienature.t_releve.p_milieu_id IS 'Milieu principal';
        COMMENT ON COLUMN pr_vigienature.t_releve.p_type_id IS 'Type du milieu principal';
        COMMENT ON COLUMN pr_vigienature.t_releve.p_cat1_id IS 'Catégorie 1 du milieu principal';
        COMMENT ON COLUMN pr_vigienature.t_releve.p_cat2_id IS 'Catégorie 2 du milieu principal';
        COMMENT ON COLUMN pr_vigienature.t_releve.p_ss_cat1_id IS 'Sous-catégorie 1 du milieu principal';
        COMMENT ON COLUMN pr_vigienature.t_releve.p_ss_cat2_id IS 'Sous-catégorie 2 du milieu principal';
        COMMENT ON COLUMN pr_vigienature.t_releve.s_milieu_id IS 'Milieu secondaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.s_type_id IS 'Type du milieu secondaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.s_cat1_id IS 'Catégorie 1 du milieu secondaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.s_cat2_id IS 'Catégorie 2 du milieu secondaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.s_ss_cat1_id IS 'Sous-catégorie 1 du milieu secondaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.s_ss_cat2_id IS 'Sous catégorie 2 du milieu secondaire';
        COMMENT ON COLUMN pr_vigienature.t_releve.bdd_source IS 'Base de donnée source';
        COMMENT ON COLUMN pr_vigienature.t_releve.bdd_source_id IS 'identifiant dans la base de donnée source';
        COMMENT ON COLUMN pr_vigienature.t_releve.bdd_source_id_universal IS 'Identifiant unique universel dans la base de donnée source';
        COMMENT ON COLUMN pr_vigienature.t_releve.type_releve IS 'Type de relevé (point vs transect)';
        COMMENT ON COLUMN pr_vigienature.t_releve.nom_protocole IS 'Code du protocole (STOC EPS, STOC SITE, SHOC, etc.)';
        COMMENT ON COLUMN pr_vigienature.t_releve.geom_point IS 'Geométrie de type point (SRID 2154)';
        COMMENT ON COLUMN pr_vigienature.t_releve.geom_transect IS 'Géométrie de type transect (SRID 2154)';
        COMMENT ON COLUMN pr_vigienature.t_releve.source_data IS 'Donnée source brute au format JSON';
        COMMENT ON COLUMN pr_vigienature.t_releve.update_ts IS 'Timestamp de la dernière mise à jour dans la base de donnée';

        /* Index sur les colonnes carre_numnat, date et point_num */


--         CREATE UNIQUE INDEX ON pr_vigienature.t_releve (carre_numnat, date_debut, point_num);
--         CREATE UNIQUE INDEX ON pr_vigienature.t_releve (bdd_source, bdd_source_id);
        CREATE INDEX ON pr_vigienature.t_releve (bdd_source_id_universal);
        CREATE INDEX ON pr_vigienature.t_releve
            USING gist (geom_transect);
        CREATE INDEX ON pr_vigienature.t_releve
            USING gist (geom_point);

        /* Table des observations */
-- drop table if exists pr_vigienature.t_observation cascade
-- ;
        CREATE TABLE pr_vigienature.t_observation
        (
            id                      SERIAL      NOT NULL PRIMARY KEY,
            uuid                    UUID,
            releve_id               INTEGER REFERENCES pr_vigienature.t_releve (id)
                ON DELETE CASCADE,
            taxon_id                INTEGER REFERENCES pr_vigienature.cor_taxon_referentiels (id),
            nom_cite                VARCHAR(300),
            nombre                  INTEGER,
            distance_id             INT REFERENCES pr_vigienature.t_nomenclature (id),
            details                 JSONB,
            bdd_source_id           INTEGER     NOT NULL,
            bdd_source_id_universal VARCHAR(50) NOT NULL,
            source_data             JSONB       NOT NULL,
            update_ts               TIMESTAMP
        );

/**/

        COMMENT ON TABLE pr_vigienature.t_observation IS 'Table d''observations des protocoles vigie-nature';
        COMMENT ON COLUMN pr_vigienature.t_observation.id IS 'Clé primaire';
        COMMENT ON COLUMN pr_vigienature.t_observation.uuid IS 'Identifiant unique universel';
        COMMENT ON COLUMN pr_vigienature.t_observation.releve_id IS 'Clé étrangère du relevé';
        COMMENT ON COLUMN pr_vigienature.t_observation.taxon_id IS 'Clé étrangère du taxon';
        COMMENT ON COLUMN pr_vigienature.t_observation.nom_cite IS 'Nom cité dans VisioNature';
        COMMENT ON COLUMN pr_vigienature.t_observation.nombre IS 'Dénombrement';
        COMMENT ON COLUMN pr_vigienature.t_observation.distance_id IS 'Classe de distance';
        COMMENT ON COLUMN pr_vigienature.t_observation.details IS 'Détails des dénombrements (format JSON)';
        COMMENT ON COLUMN pr_vigienature.t_observation.bdd_source_id IS 'identifiant dans la base de donnée source';
        COMMENT ON COLUMN pr_vigienature.t_observation.bdd_source_id_universal IS 'Identifiant unique universel dans la base de donnée source';
        COMMENT ON COLUMN pr_vigienature.t_observation.source_data IS 'Donnée source brute au format JSON';
        COMMENT ON COLUMN pr_vigienature.t_observation.update_ts IS 'Timestamp de la dernière mise à jour dans la base de donnée';

/* INFO: Index de la table pr_vigienature.t_observation */

        CREATE INDEX ON pr_vigienature.t_observation (releve_id);
        CREATE INDEX ON pr_vigienature.t_observation (taxon_id);
        CREATE INDEX ON pr_vigienature.t_observation (bdd_source_id);
        CREATE INDEX ON pr_vigienature.t_observation (bdd_source_id_universal);


        DROP VIEW IF EXISTS pr_vigienature.v_vigienature_data;

        CREATE VIEW pr_vigienature.v_vigienature_data AS
        SELECT
            rel.bdd_source_id_universal AS rel_id_universal_ff
          , rel.nom_protocole           AS rel_nom_protocole
          , rel.type_releve             AS rel_type_releve
          , rel.carre_numnat            AS rel_carre_numnat
          , rel.site_name               AS rel_site_name
          , rel.passage_mnhn            AS rel_passage_mnhn
          , rel.date_debut              AS rel_date_debut
          , rel.heure_debut             AS rel_heure_debut
          , rel.date_fin                AS rel_date_fin
          , rel.heure_fin               AS rel_heure_fin
          , rel.altitude                AS rel_altitude
          , nnuage.code                 AS rel_nuage
          , npluie.code                 AS rel_pluie
          , nvent.code                  AS rel_vent
          , nvisibilite.code            AS rel_visibilite
          , npmilieu.code               AS rel_p_milieu
          , np_cat1.code                AS rel_p_cat1
          , np_cat2.code                AS rel_p_cat2
          , np_ss_cat1.code             AS rel_p_ss_cat1
          , np_ss_cat2.code             AS rel_p_ss_cat2
          , ns_cat1.code                AS rel_s_cat1
          , ns_cat2.code                AS rel_s_cat2
          , ns_ss_cat1.code             AS rel_s_ss_cat1
          , ns_ss_cat2.code             AS rel_s_ss_cat2
          , st_x(geom_point)            AS rel_x
          , st_y(geom_point)            AS rel_y
          , st_astext(geom_point)       AS rel_geom
          , st_astext(geom_transect)    AS rel_transect
          , obs.bdd_source_id_universal AS obs_id_universal_ff
          , obs.uuid                    AS obs_uuid
          , obs.nom_cite                AS obs_nom_cite
          , tax.cd_nom                  AS obs_cd_nom
          , tax.euring_code             AS obs_code_euring
          , ndist.code                  AS obs_distance
          , obs.nombre                  AS obs_nombre
--   , obs.details                 AS obs_dist
          , obs.details ->> 'age'       AS obs_age
          , obs.details ->> 'sex'       AS obs_sexe
          , obs.details ->> 'condition' AS obs_condition
            FROM
                pr_vigienature.t_releve rel
                    JOIN pr_vigienature.l_carre_suivi
                         ON rel.carre_suivi_id = l_carre_suivi.id
                    JOIN pr_vigienature.t_observation obs ON rel.id = obs.releve_id
                    LEFT JOIN pr_vigienature.cor_taxon_referentiels tax ON obs.taxon_id = tax.id
                    LEFT JOIN pr_vigienature.t_nomenclature ndist ON obs.distance_id = ndist.id
                    LEFT JOIN pr_vigienature.t_nomenclature nnuage ON rel.nuage_id = nnuage.id
                    LEFT JOIN pr_vigienature.t_nomenclature npluie ON rel.pluie_id = npluie.id
                    LEFT JOIN pr_vigienature.t_nomenclature nvent ON rel.vent_id = nvent.id
                    LEFT JOIN pr_vigienature.t_nomenclature nvisibilite ON rel.visibilite_id = nvisibilite.id
                    LEFT JOIN pr_vigienature.t_nomenclature npmilieu ON rel.p_milieu_id = npmilieu.id
                    LEFT JOIN pr_vigienature.t_nomenclature np_cat1 ON rel.p_cat1_id = np_cat1.id
                    LEFT JOIN pr_vigienature.t_nomenclature np_cat2 ON rel.p_cat2_id = np_cat2.id
                    LEFT JOIN pr_vigienature.t_nomenclature np_ss_cat1 ON rel.p_ss_cat1_id = np_ss_cat1.id
                    LEFT JOIN pr_vigienature.t_nomenclature np_ss_cat2 ON rel.p_ss_cat2_id = np_ss_cat2.id
                    LEFT JOIN pr_vigienature.t_nomenclature ns_cat1 ON rel.s_cat1_id = ns_cat1.id
                    LEFT JOIN pr_vigienature.t_nomenclature ns_cat2 ON rel.s_cat2_id = ns_cat2.id
                    LEFT JOIN pr_vigienature.t_nomenclature ns_ss_cat1 ON rel.s_ss_cat1_id = ns_ss_cat1.id
                    LEFT JOIN pr_vigienature.t_nomenclature ns_ss_cat2 ON rel.s_ss_cat2_id = ns_ss_cat2.id;

        COMMIT;
    END
$$
;


select * from pr_vigienature.v_vigienature_data;