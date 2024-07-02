-- pr_vigienature.v_vigienature_data source

DROP VIEW pr_vigienature.v_vigienature_data ;

CREATE OR REPLACE
VIEW pr_vigienature.v_vigienature_data
AS
SELECT
	obs.id,
	rel.bdd_source_id_universal AS code_inventaire,
	rel.nom_protocole AS etude,
	rel.site_name AS site,
	l_areas.area_code AS insee,
	l_areas.area_name AS commune,
	concat('CARRE N°',
	CASE
		WHEN length(rel.carre_numnat::varchar)<6 THEN concat('0',
		rel.carre_numnat::varchar)
		ELSE rel.carre_numnat::varchar
	END ) AS num_carre_eps,
	rel.date_debut AS date,
	rel.heure_debut AS heure,
	rel.heure_fin,
	rel.observateur,
	rel.point_num AS num_point_eps,
	rel.altitude,
	obs.nom_cite AS taxon_nom_cite,
	tax.cd_nom AS taxon_cd_nom,
	tax.euring_code AS taxon_code_euring,
	taxref.group2_inpn AS taxon_classe,
	obs.nombre,
	ndist.code_vn AS distance_de_contact,
	st_x(st_transform(rel.geom_point, 4326)) AS longitude,
	st_y(st_transform(rel.geom_point, 4326)) AS latitude,
	nnuage.code AS eps_nuage,
	npluie.code AS eps_pluie,
	nvent.code AS eps_vent,
	nneige.code AS eps_neige,
	nvisibilite.code AS eps_visibilite,
	np_milieu.code AS eps_p_milieu,
	np_type.code AS eps_p_type,
	np_cat1.code AS eps_p_cat1,
	np_cat2.code AS eps_p_cat2,
	np_ss_cat1.code AS eps_p_ss_cat1,
	np_ss_cat2.code AS eps_p_ss_cat2,
	ns_milieu.code AS eps_s_milieu,
	ns_type.code AS eps_s_type,
	ns_cat1.code AS eps_s_cat1,
	ns_cat2.code AS eps_s_cat2,
	ns_ss_cat1.code AS eps_s_ss_cat1,
	ns_ss_cat2.code AS eps_s_ss_cat2,
	rel.bdd_source_id_universal AS reference_id_universal_ff_releve,
	obs.bdd_source_id_universal AS reference_id_universal_ff_observation,
	obs.uuid AS reference_uuid_observation
FROM
	pr_vigienature.t_releve rel
JOIN pr_vigienature.t_observation obs ON
	rel.id = obs.releve_id
JOIN ref_geo.l_areas ON
	st_within(st_transform(rel.geom_point,
	4326),
	l_areas.geom)
LEFT JOIN pr_vigienature.cor_taxon_referentiels tax ON
	obs.taxon_id = tax.id
LEFT JOIN taxonomie.taxref ON
	tax.cd_nom = taxref.cd_nom
LEFT JOIN pr_vigienature.t_nomenclature ndist ON
	obs.distance_id = ndist.id
LEFT JOIN pr_vigienature.t_nomenclature nnuage ON
	rel.nuage_id = nnuage.id
LEFT JOIN pr_vigienature.t_nomenclature npluie ON
	rel.pluie_id = npluie.id
LEFT JOIN pr_vigienature.t_nomenclature nvent ON
	rel.vent_id = nvent.id
LEFT JOIN pr_vigienature.t_nomenclature nneige ON
	rel.neige_id = nneige.id
LEFT JOIN pr_vigienature.t_nomenclature nvisibilite ON
	rel.visibilite_id = nvisibilite.id
LEFT JOIN pr_vigienature.t_nomenclature np_milieu ON
	rel.p_milieu_id = np_milieu.id
LEFT JOIN pr_vigienature.t_nomenclature np_type ON
	rel.p_type_id = np_type.id
LEFT JOIN pr_vigienature.t_nomenclature np_cat1 ON
	rel.p_cat1_id = np_cat1.id
LEFT JOIN pr_vigienature.t_nomenclature np_cat2 ON
	rel.p_cat2_id = np_cat2.id
LEFT JOIN pr_vigienature.t_nomenclature np_ss_cat1 ON
	rel.p_ss_cat1_id = np_ss_cat1.id
LEFT JOIN pr_vigienature.t_nomenclature np_ss_cat2 ON
	rel.p_ss_cat2_id = np_ss_cat2.id
LEFT JOIN pr_vigienature.t_nomenclature ns_milieu ON
	rel.s_milieu_id = ns_milieu.id
LEFT JOIN pr_vigienature.t_nomenclature ns_type ON
	rel.s_type_id = ns_type.id
LEFT JOIN pr_vigienature.t_nomenclature ns_cat1 ON
	rel.s_cat1_id = ns_cat1.id
LEFT JOIN pr_vigienature.t_nomenclature ns_cat2 ON
	rel.s_cat2_id = ns_cat2.id
LEFT JOIN pr_vigienature.t_nomenclature ns_ss_cat1 ON
	rel.s_ss_cat1_id = ns_ss_cat1.id
LEFT JOIN pr_vigienature.t_nomenclature ns_ss_cat2 ON
	rel.s_ss_cat2_id = ns_ss_cat2.id
WHERE
	l_areas.id_type = ref_geo.get_id_area_type('COM'::CHARACTER VARYING);

  -- pr_vigienature.v_vigienature_observers source
DROP VIEW pr_vigienature.v_vigienature_observers ;

CREATE OR REPLACE VIEW pr_vigienature.v_vigienature_observers
AS SELECT observers_json.site,
    observers_json.id AS id_local,
    observers_json.id_universal,
    observers_json.item ->> 'email'::text AS email,
    observers_json.item ->> 'name'::text AS nom,
    observers_json.item ->> 'surname'::text AS prenom
   FROM src_vn_json.observers_json
  WHERE (observers_json.id_universal IN ( SELECT t_releve.observateur::integer AS observateur
           FROM pr_vigienature.t_releve));