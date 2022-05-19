/*******************************************************************************************
 * Créatiop d''une bdd de centralisation des données STOC depuis les portails VisioNature  *
 *******************************************************************************************/
CREATE SCHEMA IF NOT EXISTS pr_vigienature
;

CREATE TABLE IF NOT EXISTS pr_vigienature.l_grid
(
    id        INTEGER NOT NULL PRIMARY KEY,
    area      FLOAT,
    perimeter FLOAT,
    carrenat  INTEGER,
    numnat    INTEGER,
    x         FLOAT,
    y         FLOAT,
    geom      GEOMETRY(Polygon, 2154)
)
;

CREATE INDEX l_grid_geom_idx
    ON pr_vigienature.l_grid USING gist (geom)
;


ALTER TABLE pr_vigienature.l_grid
    ADD CONSTRAINT l_grid_numnat UNIQUE (numnat)
;

/* Table dictionnaire des codes espèces */
/*DROP TABLE IF EXISTS pr_vigienature.match_taxa_repo;*/

CREATE TABLE pr_vigienature.match_taxa_repo
(
    id            SERIAL PRIMARY KEY,
    euring_code   VARCHAR(20),
    euring_num    INTEGER,
    taxref_cd_nom INTEGER,
    vn_id_species INTEGER,
    ref_tax       BOOLEAN
)
;

CREATE INDEX match_taxa_repo_idx_euring_code ON pr_vigienature.match_taxa_repo (euring_code)
;

CREATE INDEX match_taxa_repo_idx_cd_nom ON pr_vigienature.match_taxa_repo (taxref_cd_nom)
;

CREATE INDEX match_taxa_repo_idx_vn_id ON pr_vigienature.match_taxa_repo (vn_id_species)
;


/* Table des correspondances des distances */
--DROP TABLE pr_vigienature.dict_distance_code;

CREATE TABLE pr_vigienature.dict_distance_code
(
    id                    BIGINT NOT NULL PRIMARY KEY,
    code                  VARCHAR(100),
    code_vn               VARCHAR(20),
    libelle               VARCHAR(200),
    defaut                VARCHAR(200),
    libelle_international VARCHAR(200)
)
;


CREATE INDEX ON pr_vigienature.dict_distance_code USING btree (id)
;

CREATE INDEX ON pr_vigienature.dict_distance_code USING btree (code_vn)
;

CREATE TABLE pr_vigienature.dict_points_code
(
    id         SERIAL PRIMARY KEY,
    type_code  VARCHAR(50),
    principal  VARCHAR(5),
    colonne    VARCHAR(5),
    code       VARCHAR(50),
    code_vn    VARCHAR(50),
    libelle    VARCHAR(200),
    libelle_vn VARCHAR(100)
)
;

CREATE INDEX dict_points_code_type_code_idx
    ON pr_vigienature.dict_points_code (type_code)
;

CREATE INDEX dict_points_code_code_idx
    ON pr_vigienature.dict_points_code (code)
;

CREATE INDEX dict_points_code_libelle_idx
    ON pr_vigienature.dict_points_code (libelle)
;

CREATE INDEX dict_points_code_libelle_vn_idx
    ON pr_vigienature.dict_points_code (libelle_vn)
;


/* Table des relevés */
-- drop table if exists pr_vigienature.t_survey cascade;
CREATE TABLE pr_vigienature.t_survey
(
    id                     SERIAL NOT NULL PRIMARY KEY,
    date                   DATE,
    time                   TIME,
    observer               VARCHAR(100),
    carre_numnat           INTEGER,
    point_num              INTEGER,
    site_name              VARCHAR(250),
    altitude               INTEGER,
    cloud                  INTEGER,
    rain                   INTEGER,
    wind                   INTEGER,
    visibility             INTEGER,
    p_milieu               VARCHAR(10),
    p_type                 VARCHAR(10),
    p_cat1                 VARCHAR(10),
    p_cat2                 VARCHAR(10),
    p_ss_cat1              VARCHAR(10),
    p_ss_cat2              VARCHAR(10),
    s_milieu               VARCHAR(10),
    s_type                 VARCHAR(10),
    s_cat1                 VARCHAR(10),
    s_cat2                 VARCHAR(10),
    s_ss_cat1              VARCHAR(10),
    s_ss_cat2              VARCHAR(10),
    site                   BOOLEAN,
    passage_mnhn           VARCHAR(10),
    db_source              VARCHAR(50),
    db_source_id           INTEGER,
    db_source_id_universal VARCHAR(250) UNIQUE,
    survey_geotype         VARCHAR(20),
    protocol_name          VARCHAR(20),
    geom                   GEOMETRY(point, 2154),
    CONSTRAINT type_esp_con CHECK (survey_geotype IN ('Point', 'Transect') OR survey_geotype IS NULL)
)
;

/* Index sur les colonnes carre_numnat, date et point_num */

CREATE UNIQUE INDEX ON pr_vigienature.t_survey (db_source_id_universal)
;

CREATE UNIQUE INDEX ON pr_vigienature.t_survey (carre_numnat, date, point_num, db_source_id_universal)
;

CREATE INDEX ON pr_vigienature.t_survey (carre_numnat, date, point_num)
;

CREATE INDEX ON pr_vigienature.t_survey (db_source)
;

CREATE INDEX ON pr_vigienature.t_survey (db_source_id)
;


CREATE INDEX ON pr_vigienature.t_survey
    USING gist (geom)
;


/* Table des observations */
-- drop table if exists pr_vigienature.t_observations cascade
-- ;

CREATE TABLE pr_vigienature.t_observations
(
    id                     SERIAL NOT NULL PRIMARY KEY,
    survey_id              INTEGER REFERENCES pr_vigienature.t_survey (id)
        ON DELETE CASCADE,
    euring_codesp          VARCHAR(10),
    vn_is_species          INTEGER,
    count                  INTEGER,
    distance               VARCHAR(50),
    details                JSONB,
    db_source              VARCHAR(50),
    db_source_id           INTEGER,
    db_source_id_universal VARCHAR(50),
    update_ts              TIMESTAMP
)
;

CREATE INDEX ON pr_vigienature.t_observations (survey_id)
;

CREATE INDEX ON pr_vigienature.t_observations (euring_codesp)
;

CREATE INDEX ON pr_vigienature.t_observations (db_source)
;

CREATE INDEX ON pr_vigienature.t_observations (db_source_id)
;

CREATE INDEX ON pr_vigienature.t_observations (db_source_id_universal)
;

-- alter table pr_vigienature.observations
--   drop constraint observations_survey_id_fkey,
--   add constraint observations_survey_id_fkey
-- foreign key (survey_id)
-- references pr_vigienature.releves (id)
-- on delete cascade
-- ;
