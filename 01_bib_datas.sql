/* bib_code_points values */
INSERT INTO
    pr_stoc.dict_codes (id, type_code, principal, colonne, code, code_vn, libelle, libelle_vn)
    VALUES
        (1, 'habitat', 'A', '0', 'A', 'A0_A', 'Forêt (arbres > 5m de hauteur)', 'Forêt (arbres > 5m de hauteur)')
      , (2, 'habitat', 'A', '1', '1', 'A1_1', 'Feuillus', NULL)
      , (3, 'habitat', 'A', '1', '2', 'A1_2', 'Conifères', NULL)
      , (4, 'habitat', 'A', '1', '3', 'A1_3', 'Mixte (> 10% de chaque)', NULL)
      , (5, 'habitat', 'A', '2', '1', 'A2_1', 'Semi-naturelle ou âges mélangés', NULL)
      , (6, 'habitat', 'A', '2', '10', 'A2_10', 'Bois mort présent', NULL)
      , (7, 'habitat', 'A', '2', '11', 'A2_11', 'Bois mort absent', NULL)
      , (8, 'habitat', 'A', '2', '2', 'A2_2', 'Plantation équienne', NULL)
      , (9, 'habitat', 'A', '2', '3', 'A2_3', 'Plantation non-équienne', NULL)
      , (10, 'habitat', 'A', '2', '4', 'A2_4', 'Plantation mâture (> 10m de haut)', NULL)
      , (11, 'habitat', 'A', '2', '5', 'A2_5', 'Jeune plantation (5-10m)', NULL)
      , (12, 'habitat', 'A', '2', '6', 'A2_6', 'Parc (arbres éparses et prairies)', NULL)
      , (13, 'habitat', 'A', '2', '7', 'A2_7', 'Sous-bois dense', NULL)
      , (14, 'habitat', 'A', '2', '8', 'A2_8', 'Sous-bois modéré', NULL)
      , (15, 'habitat', 'A', '2', '9', 'A2_9', 'Sous-bois éparse', NULL)
      , (16, 'habitat', 'A', '3', '1', 'A3_1', 'Chêne', NULL)
      , (17, 'habitat', 'A', '3', '10', 'A3_10', 'Autre essence conifère', NULL)
      , (18, 'habitat', 'A', '3', '11', 'A3_11', 'Autre essence', NULL)
      , (19, 'habitat', 'A', '3', '2', 'A3_2', 'Hêtre', NULL)
      , (20, 'habitat', 'A', '3', '3', 'A3_3', 'Erable', NULL)
      , (21, 'habitat', 'A', '3', '4', 'A3_4', 'Châtaignier', NULL)
      , (22, 'habitat', 'A', '3', '5', 'A3_5', 'Autre essence feuillue', NULL)
      , (23, 'habitat', 'A', '3', '6', 'A3_6', 'Sapin', NULL)
      , (24, 'habitat', 'A', '3', '7', 'A3_7', 'Epicéa', NULL)
      , (25, 'habitat', 'A', '3', '8', 'A3_8', 'Pin', NULL)
      , (26, 'habitat', 'A', '3', '9', 'A3_9', 'Mélèze', NULL)
      , ( 27
        , 'habitat'
        , 'B'
        , '0'
        , 'B'
        , 'B0_B'
        , 'Buissons (ou jeune forêt < 5m de hauteur)'
        , 'Buissons (ou jeune forêt < 5m de hauteur)')
      , (28, 'habitat', 'B', '1', '1', 'B1_1', 'Forêt de régénération', NULL)
      , (29, 'habitat', 'B', '1', '2', 'B1_2', 'Buissons calcicoles', NULL)
      , (30, 'habitat', 'B', '1', '3', 'B1_3', 'Lande', NULL)
      , (31, 'habitat', 'B', '1', '4', 'B1_4', 'Jeune taillis', NULL)
      , (32, 'habitat', 'B', '1', '5', 'B1_5', 'Nouvelle plantation', NULL)
      , (33, 'habitat', 'B', '1', '6', 'B1_6', 'Coupe « à blanc »', NULL)
      , (34, 'habitat', 'B', '1', '6', 'B1_6', 'Coupe « à blanc »', NULL)
      , (35, 'habitat', 'B', '1', '7', 'B1_7', 'Autres', NULL)
      , (36, 'habitat', 'B', '2', '1', 'B2_1', 'Feuillus', NULL)
      , (37, 'habitat', 'B', '2', '2', 'B2_2', 'Conifères', NULL)
      , (38, 'habitat', 'B', '2', '3', 'B2_3', 'Mixte (10% de chaque)', NULL)
      , (39, 'habitat', 'B', '2', '4', 'B2_4', 'Buissons feuillus de marais', NULL)
      , (40, 'habitat', 'B', '2', '5', 'B2_5', 'Buissons conifères de marais', NULL)
      , (41, 'habitat', 'B', '2', '6', 'B2_6', 'Buissons mixtes de marais', NULL)
      , (42, 'habitat', 'B', '2', '7', 'B2_7', 'Feuilles persistantes', NULL)
      , (43, 'habitat', 'B', '2', '8', 'B2_8', 'Garrigue', NULL)
      , (44, 'habitat', 'B', '2', '9', 'B2_9', 'Maquis', NULL)
      , (45, 'habitat', 'B', '3', '1', 'B3_1', 'Surtout grands (3-5 mètres)', NULL)
      , (46, 'habitat', 'B', '3', '2', 'B3_2', 'Surtout petits (1-3 mètres)', NULL)
      , (47, 'habitat', 'B', '3', '3', 'B3_3', 'Sous-bois dense', NULL)
      , (48, 'habitat', 'B', '3', '4', 'B3_4', 'Sous-bois modéré', NULL)
      , (49, 'habitat', 'B', '3', '5', 'B3_5', 'Sous-bois éparse', NULL)
      , (50, 'habitat', 'B', '3', '6', 'B3_6', 'Fougères', NULL)
      , (51, 'habitat', 'B', '3', '7', 'B3_7', 'Pâturé', NULL)
      , (52, 'habitat', 'C', '0', 'C', 'C0_C', 'Pelouses, marais et landes', 'Pelouses, marais et landes')
      , (53, 'habitat', 'C', '1', '1', 'C1_1', 'Pelouse calcaire sèche', NULL)
      , (54, 'habitat', 'C', '1', '10', 'C1_10', 'Tourbières', NULL)
      , (55, 'habitat', 'C', '1', '11', 'C1_11', 'Marais salés', NULL)
      , (56, 'habitat', 'C', '1', '11', 'C1_11', 'Marais salé', NULL)
      , (57, 'habitat', 'C', '1', '2', 'C1_2', 'Lande herbacée', NULL)
      , (58, 'habitat', 'C', '1', '3', 'C1_3', 'Lande de bruyère', NULL)
      , (59, 'habitat', 'C', '1', '4', 'C1_4', 'Pelouse humide naturelle', NULL)
      , (60, 'habitat', 'C', '1', '5', 'C1_5', 'Autres pelouses sèches', NULL)
      , (61, 'habitat', 'C', '1', '6', 'C1_6', 'Pelouse inondée/marais pâturé', NULL)
      , (62, 'habitat', 'C', '1', '7', 'C1_7', 'Roselière', NULL)
      , (63, 'habitat', 'C', '1', '8', 'C1_8', 'Autres marais ouverts', NULL)
      , (64, 'habitat', 'C', '1', '9', 'C1_9', 'Marais salants', NULL)
      , (65, 'habitat', 'C', '2', '1', 'C2_1', 'Haies avec arbres', NULL)
      , (66, 'habitat', 'C', '2', '2', 'C2_2', 'Haies sans arbres', NULL)
      , (67, 'habitat', 'C', '2', '3', 'C2_3', 'Lignes d’arbres sans haie', NULL)
      , (68, 'habitat', 'C', '2', '3', 'C2_3', 'Ligne d’arbres sans haie', NULL)
      , (69, 'habitat', 'C', '2', '4', 'C2_4', 'Autre limite de terrain (mur, fossé...)', NULL)
      , (70, 'habitat', 'C', '2', '4', 'C2_4', 'Autre limite de terrain (mur, fossé…)', NULL)
      , (71, 'habitat', 'C', '2', '5', 'C2_5', 'Groupes isolés de 1-10 arbres', NULL)
      , (72, 'habitat', 'C', '2', '5', 'C2_5', 'Groupe isolé de 1-10 arbres', NULL)
      , (73, 'habitat', 'C', '2', '6', 'C2_6', 'Pas de haie', NULL)
      , (74, 'habitat', 'C', '2', '7', 'C2_7', 'Montagne', NULL)
      , (75, 'habitat', 'C', '2', '8', 'C2_8', 'Digue', NULL)
      , (76, 'habitat', 'C', '3', '1', 'C3_1', 'Non pâturé', NULL)
      , (77, 'habitat', 'C', '3', '2', 'C3_2', 'Pâturé', NULL)
      , (78, 'habitat', 'C', '3', '3', 'C3_3', 'Foin', NULL)
      , (79, 'habitat', 'C', '3', '4', 'C3_4', 'Beaucoup de fougères', NULL)
      , (80, 'habitat', 'D', '0', 'D', 'D0_D', 'Milieux agricoles', 'Milieux agricoles')
      , (81, 'habitat', 'D', '1', '1', 'D1_1', 'Prairie cultivée', NULL)
      , (82, 'habitat', 'D', '1', '2', 'D1_2', 'Prairie non cultivée', NULL)
      , (83, 'habitat', 'D', '1', '3', 'D1_3', 'Mixité prairie / cultures', NULL)
      , (84, 'habitat', 'D', '1', '4', 'D1_4', 'Grandes cultures', NULL)
      , (85, 'habitat', 'D', '1', '5', 'D1_5', 'Verger / vignes / maraîchers', NULL)
      , (86, 'habitat', 'D', '1', '6', 'D1_6', 'Autres types de cultures', NULL)
      , (87, 'habitat', 'D', '2', '1', 'D2_1', 'Haies avec arbres', NULL)
      , (88, 'habitat', 'D', '2', '2', 'D2_2', 'Haies sans arbres', NULL)
      , (89, 'habitat', 'D', '2', '3', 'D2_3', 'Ligne d’arbres sans haie', NULL)
      , (90, 'habitat', 'D', '2', '4', 'D2_4', 'Autre limite de terrain (mur, fossé…)', NULL)
      , (91, 'habitat', 'D', '2', '4', 'D2_4', 'Autre limite de terrain', NULL)
      , (92, 'habitat', 'D', '2', '5', 'D2_5', 'Groupe isolé de 1-10 arbres', NULL)
      , (93, 'habitat', 'D', '2', '5', 'D2_5', 'Groupes isolés de 1-10 arbres', NULL)
      , (94, 'habitat', 'D', '2', '6', 'D2_6', 'Cour de ferme, basse-cour', NULL)
      , (95, 'habitat', 'D', '2', '7', 'D2_7', 'Pas de haie', NULL)
      , (96, 'habitat', 'D', '3', '1', 'D3_1', 'Non pâturé', NULL)
      , (97, 'habitat', 'D', '3', '10', 'D3_10', 'Rizières', NULL)
      , (98, 'habitat', 'D', '3', '2', 'D3_2', 'Pâturé', NULL)
      , (99, 'habitat', 'D', '3', '3', 'D3_3', 'Céréales', NULL)
      , (100, 'habitat', 'D', '3', '4', 'D3_4', 'Maïs', NULL)
      , (101, 'habitat', 'D', '3', '5', 'D3_5', 'Tournesol', NULL)
      , (102, 'habitat', 'D', '3', '6', 'D3_6', 'Colza', NULL)
      , (103, 'habitat', 'D', '3', '7', 'D3_7', 'Cultures à racines', NULL)
      , (104, 'habitat', 'D', '3', '8', 'D3_8', 'Sol nu', NULL)
      , (105, 'habitat', 'D', '3', '9', 'D3_9', 'Autres cultures', NULL)
      , (106, 'habitat', 'E', '0', 'E', 'E0_E', 'Milieux bâtis ou urbanisés', 'Milieux bâtis ou urbanisés')
      , (107, 'habitat', 'E', '1', '1', 'E1_1', 'Urbain', NULL)
      , (108, 'habitat', 'E', '1', '2', 'E1_2', 'Suburbain', NULL)
      , (109, 'habitat', 'E', '1', '3', 'E1_3', 'Rural', NULL)
      , (110, 'habitat', 'E', '2', '1', 'E2_1', 'Bâtiments', NULL)
      , (111, 'habitat', 'E', '2', '2', 'E2_2', 'Jardins', NULL)
      , (112, 'habitat', 'E', '2', '3', 'E2_3', 'Parcs municipaux, zones de loisirs', NULL)
      , (113, 'habitat', 'E', '2', '4', 'E2_4', 'Traitement des eaux urbaines', NULL)
      , (114, 'habitat', 'E', '2', '5', 'E2_5', 'Près d’une route (< 50 mètres)', NULL)
      , (115, 'habitat', 'E', '2', '5', 'E2_5', 'Près d’une route (<50 mètres)', NULL)
      , (116, 'habitat', 'E', '2', '6', 'E2_6', 'Près d’une voie de chemin de fer (<50 mètres)', NULL)
      , (117, 'habitat', 'E', '2', '6', 'E2_6', 'Près d’une voie de chemin de fer (< 50 mètres)', NULL)
      , (118, 'habitat', 'E', '2', '7', 'E2_7', 'Décharge d’ordures', NULL)
      , (119, 'habitat', 'E', '3', '1', 'E3_1', 'Industriel', NULL)
      , (120, 'habitat', 'E', '3', '2', 'E3_2', 'Résidentiel', NULL)
      , (121, 'habitat', 'E', '3', '3', 'E3_3', 'Beaucoup d’arbres', NULL)
      , (122, 'habitat', 'E', '3', '4', 'E3_4', 'Peu d’arbres', NULL)
      , (123, 'habitat', 'E', '3', '5', 'E3_5', 'Grande surface de jardins (> 450m2)', NULL)
      , (124, 'habitat', 'E', '3', '6', 'E3_6', 'Moyenne surface de jardins (100 - 450 m2)', NULL)
      , (125, 'habitat', 'E', '3', '6', 'E3_6', 'Moyenne surface de jardins (100-450m²)', NULL)
      , (126, 'habitat', 'E', '3', '7', 'E3_7', 'Faible surface de jardins (< 100 m2)', NULL)
      , (127, 'habitat', 'E', '3', '7', 'E3_7', 'Faible surface de jardins (<100m²)', NULL)
      , (128, 'habitat', 'E', '3', '8', 'E3_8', 'Beaucoup de buissons', NULL)
      , (129, 'habitat', 'E', '3', '9', 'E3_9', 'Peu de buissons', NULL)
      , (130, 'habitat', 'F', '0', 'F', 'F0_F', 'Milieux aquatiques', 'Milieux aquatiques')
      , (131, 'habitat', 'F', '4', '1', 'F4_1', 'Non utilisé/non perturbé', NULL)
      , (132, 'habitat', 'F', '4', '1', 'F4_1', 'Mare (moins de 50 m2)', NULL)
      , (133, 'habitat', 'F', '4', '1', 'F4_1', 'Eutrophique (eau verte)', NULL)
      , (134, 'habitat', 'F', '4', '10', 'F4_10', 'Grand canal (> 5m de largeur)', NULL)
      , (135, 'habitat', 'F', '4', '10', 'F4_10', 'Rives avec végétation', NULL)
      , (136, 'habitat', 'F', '4', '11', 'F4_11', 'Eaux saumâtres (salins, lagunes…)', NULL)
      , (137, 'habitat', 'F', '4', '11', 'F4_11', 'Rives avec falaise', NULL)
      , (138, 'habitat', 'F', '4', '12', 'F4_12', 'Fleuve / rivière large (> 10m)', NULL)
      , (139, 'habitat', 'F', '4', '2', 'F4_2', 'Sports nautiques', NULL)
      , (140, 'habitat', 'F', '4', '2', 'F4_2', 'Oligotrophique (eau claire, peu d’algues)', NULL)
      , (141, 'habitat', 'F', '4', '2', 'F4_2', 'Petit étang (50 - 450 m2)', NULL)
      , (142, 'habitat', 'F', '4', '3', 'F4_3', 'Lac/réservoir (berges naturelles)', NULL)
      , (143, 'habitat', 'F', '4', '3', 'F4_3', 'Pêche à la ligne', NULL)
      , (144, 'habitat', 'F', '4', '3', 'F4_3', 'Dystrophique (eau noire)', NULL)
      , (145, 'habitat', 'F', '4', '4', 'F4_4', 'Bigarré (eau claire, beaucoup dd’algues)', NULL)
      , (146, 'habitat', 'F', '4', '4', 'F4_4', 'Bigarré (eau claire, beaucoup d’algues)', NULL)
      , (147, 'habitat', 'F', '4', '4', 'F4_4', 'Réservoir (berges non naturelles)', NULL)
      , (148, 'habitat', 'F', '4', '4', 'F4_4', 'Activité industrielle', NULL)
      , (149, 'habitat', 'F', '4', '5', 'F4_5', 'Traitements d’eaux usées', NULL)
      , (150, 'habitat', 'F', '4', '5', 'F4_5', 'Carrière de gravier, de sable...', NULL)
      , (151, 'habitat', 'F', '4', '5', 'F4_5', 'Courant faible / moyen', NULL)
      , (152, 'habitat', 'F', '4', '6', 'F4_6', 'Autres dérangements', NULL)
      , (153, 'habitat', 'F', '4', '6', 'F4_6', 'Ruisseau (< 3m de largeur)', NULL)
      , (154, 'habitat', 'F', '4', '6', 'F4_6', 'Courant fort', NULL)
      , (155, 'habitat', 'F', '4', '7', 'F4_7', 'Dragué', NULL)
      , (156, 'habitat', 'F', '4', '7', 'F4_7', 'Activités industrielles', NULL)
      , (157, 'habitat', 'F', '4', '7', 'F4_7', 'Rivière (3m < largeur < 10m)', NULL)
      , (158, 'habitat', 'F', '4', '8', 'F4_8', 'Fossé inondé (< 2m de largeur)', NULL)
      , (159, 'habitat', 'F', '4', '8', 'F4_8', 'Non dragué', NULL)
      , (160, 'habitat', 'F', '4', '8', 'F4_8', 'Petites îles', NULL)
      , (161, 'habitat', 'F', '4', '9', 'F4_9', 'Petit canal (2 - 5m. de largeur)', NULL)
      , (162, 'habitat', 'F', '4', '9', 'F4_9', 'Rives nues', NULL)
      , (163, 'habitat', 'G', '0', 'G', 'G0_G', 'Rochers terrestres ou côtiers', 'Rochers terrestres ou côtiers')
      , (164, 'habitat', 'G', '1', '1', 'G1_1', 'Falaise', NULL)
      , (165, 'habitat', 'G', '1', '2', 'G1_2', 'Eboulis, pente rocheuse', NULL)
      , (166, 'habitat', 'G', '1', '3', 'G1_3', 'Pavement calcaire', NULL)
      , (167, 'habitat', 'G', '1', '4', 'G1_4', 'Autres sols rocheux', NULL)
      , (168, 'habitat', 'G', '1', '5', 'G1_5', 'Carrière', NULL)
      , (169, 'habitat', 'G', '1', '6', 'G1_6', 'Mine / abîme / terril', NULL)
      , (170, 'habitat', 'G', '1', '7', 'G1_7', 'Grotte', NULL)
      , (171, 'habitat', 'G', '1', '8', 'G1_8', 'Dune', NULL)
      , (172, 'habitat', 'G', '2', '1', 'G2_1', 'Montagne', NULL)
      , (173, 'habitat', 'G', '2', '2', 'G2_2', 'Pas en montagne', NULL)
      , (174, 'habitat', 'G', '2', '3', 'G2_3', 'Bord de mer', NULL)
      , (175, 'habitat', 'G', '2', '4', 'G2_4', 'Fort dérangement par l’homme (grimpeurs, promeneurs…)', NULL)
      , (176, 'habitat', 'G', '2', '4', 'G2_4', 'Fort dérangement par l’homme (grimpeurs, promeneurs...)', NULL)
      , (177, 'habitat', 'G', '3', '1', 'G3_1', 'Roche nue', NULL)
      , (178, 'habitat', 'G', '3', '2', 'G3_2', 'Végétation basse présente (mousses, lichens…)', NULL)
      , (179, 'habitat', 'G', '3', '2', 'G3_2', 'Végétation basse présente (mousses, lichens...)', NULL)
      , (180, 'habitat', 'G', '3', '3', 'G3_3', 'Graminées présentes', NULL)
      , (181, 'habitat', 'G', '3', '4', 'G3_4', 'Buissons présents', NULL)
      , (185, 'pluie', NULL, NULL, '1', 'NO_RAIN', 'Absente', NULL)
      , (186, 'pluie', NULL, NULL, '2', 'SMALL_RAIN', 'Bruine', NULL)
      , (187, 'pluie', NULL, NULL, '3', 'STRONG_RAIN', 'Averses', NULL)
      , (188, 'vent', NULL, NULL, '1', 'NO_WIND', 'Absent', NULL)
      , (183, 'cloud', NULL, NULL, '2', 'TWO_THIRD', '33-66 %', '33 – 66%')
      , (182, 'cloud', NULL, NULL, '1', 'ONE_THIRD', '0-33 %', '0 – 33%')
      , (184, 'cloud', NULL, NULL, '3', 'THREE_THIRD', '66-100 %', '66 – 100%')
      , (190, 'vent', NULL, NULL, '3', 'MIDDLE_STRONG_WIND', 'Moyen à fort', NULL)
      , (189, 'vent', NULL, NULL, '2', 'WEAK_WIND', 'Faible', NULL)
      , (191, 'visibilité', NULL, NULL, '1', 'GOOD_VISIBILITY', 'Bonne', 'Bonne')
      , (193, 'visibilité', NULL, NULL, '3', 'BAD_VISIBILITY', 'Faible', 'Faible')
      , (192, 'visibilité', NULL, NULL, '2', 'MODERATE_VISIBILITY', 'Modérée', 'Visibilité modérée')
;


/* bib_code_dist values */

INSERT INTO
    pr_stoc.bib_code_distances (id, code, code_vn, libelle, defaut, libelle_international)
    VALUES
        (2, '2', NULL, '50-200m', '0', '50-200m')
      , (3, 'A', NULL, '< 5m', '0', '< 5m')
      , (4, 'B', NULL, '5-10m', '0', '5-10m')
      , (5, 'C', NULL, '10-25m', '0', '10-25m')
      , (7, 'E', NULL, '25-50m', '0', '25-50m')
      , (9, 'G', NULL, '50-100m', '0', '50-100m')
      , (10, 'H', NULL, '> 100m', '0', '> 100m')
      , (11, 'I', NULL, '> 250m', '0', '> 250m')
      , (12, 'J', NULL, '> 500m', '0', '> 500m')
      , (13, 'K', NULL, '> 1km', '0', '> 1Km')
      , (16, 'O', NULL, 'Hors de la parcelle', '0', 'Outside the field')
      , (17, 'P', NULL, 'Dans la parcelle', '0', 'Inside the field')
      , (18, 'Q', NULL, 'Dans la parcelle adjacente', '0', 'Dans la parcelle adjacente')
      , (19, 'R', NULL, 'Dans les bordures', '0', 'Dans les bordures')
      , (21, 'X', NULL, 'Non indiquée', '1', 'Non indiquée')
      , (6, 'D', 'LESS25', '< 25m', '0', '< 25m')
      , (20, 'V', 'TRANSIT', 'En vol', '0', 'En vol')
      , (14, 'L', 'LESS200', '100-200m', '0', '100-200m')
      , (15, 'M', 'MORE200', '> 200m', '0', '> 200m')
      , (8, 'F', 'LESS100', '25-100m', '0', '25-100m')
      , (1, '1', NULL, '< 50m', '0', '< 50m')
;

/* bib_code_sp */

INSERT INTO
    pr_stoc.match_taxa_repo (euring_code, euring_num, taxref_cd_nom, vn_id_species)
    VALUES
        ('OENOENLEU', 11462, 4068, 1453)
      , ('AQUCLA', 2930, 836346, NULL)
      , ('FALTIN', 3040, 2669, 179)
      , ('PHORUB', 1470, 199335, 45)
      , ('ANSALBALB', 1591, 2737, 1368)
      , ('ACTMAC', 5570, 459460, 234)
      , ('CYGATR', 20800, 2702, 55)
      , ('TRISOL', 5520, 2605, 1132)
      , ('DENMED', 8830, 3619, 338)
      , ('STRALU', 7610, 3518, 321)
      , ('CERBRA', 14870, 3791, 382)
      , ('TURNAU', 11960, 4123, 411)
      , ('SYLCON', 12640, 4227, 441)
      , ('LARPIP', 5770, 627334, NULL)
      , ('PTEALC', 6620, 3408, 306)
      , ('MERSER', 2210, 2816, 142)
      , ('CARERY', 16790, 4616, 512)
      , ('ANTCER', 10120, 3729, 468)
      , ('STEALB', 6240, 3352, 296)
      , ('MOTFLA', 10173, 3751, 476)
      , ('PHYTRO', 13120, 4289, 445)
      , ('CHAVOC', 4740, 3144, 220)
      , ('NUCCAR', 15570, 4480, 365)
      , ('PERPER', 3670, 2989, 188)
      , ('PORPUS', 4110, 836246, NULL)
      , ('PLUAPRALT', 4852, 3164, NULL)
      , ('SYLMEL', 12670, 4232, 439)
      , ('CHLUND', 4440, NULL, NULL)
      , ('MILMIG', 2380, 2840, 146)
      , ('PHOCHI', 20230, 2692, 46)
      , ('SYLCUR', 12740, 4247, 438)
      , ('HIEPEN', 2980, 2651, 153)
      , ('BUTBUTVUL', 2872, 779863, 1020)
      , ('SYLCAN', 12650, 4229, 440)
      , ('RECAVO', 4560, 3116, 255)
      , ('PHYCOLTRI', 13113, 4288, 448)
      , ('PHYINO', 13000, 4297, 452)
      , ('APUCAF', 7990, NULL, NULL)
      , ('MERALB', 2200, 199312, 140)
      , ('CHAALE', 4770, 3142, 219)
      , ('ANARUB', 1870, 1968, 1005)
      , ('ACRARU', 12530, 4198, 421)
      , ('FRICOE', 16360, 4564, 518)
      , ('AGAROS', NULL, NULL, NULL)
      , ('TARCYA', 11130, 4030, 392)
      , ('MOTFLAFEL', 10174, 3752, 475)
      , ('PHYTROACR', 13122, 4294, 1366)
      , ('BARLON', 5440, 199360, 1015)
      , ('SETRUT', 17550, 4636, 1114)
      , ('SYLATR', 12770, 4257, 433)
      , ('ANACLY', 1940, 1970, NULL)
      , ('TADFER', 1710, 2770, 77)
      , ('CALACU', 5080, 3231, 1022)
      , ('NUMTEN', 5400, 2574, 223)
      , ('LARDEL', 5890, 3278, 280)
      , ('CALMAR', 5100, 2906, 248)
      , ('CORMON', 15600, 4494, 362)
      , ('ALCTOR', 6360, 3388, 300)
      , ('PICTRI', 8980, 3638, 341)
      , ('LANMIN', 15190, 3811, 488)
      , ('OENOENOEN', 11461, 4067, NULL)
      , ('PARCIN', 14480, NULL, NULL)
      , ('MARANG', 1950, 1980, 105)
      , ('SYLUND', 12620, 4221, 442)
      , ('CALBRA', 9680, 3649, 345)
      , ('ANAFOR', 1830, 1964, NULL)
      , ('AEGMON', 2550, 2869, 159)
      , ('PLENIV', 18500, 4649, 533)
      , ('MOTFLA', NULL, 3741, 1351)
      , ('BRABERHRO', 1682, 2762, 1016)
      , ('MOTALB', 10200, 3941, 472)
      , ('OENDES', 11490, 199428, 400)
      , ('PHYCOLABI', 13114, 4287, 447)
      , ('SEINOV', 17570, 626165, 1112)
      , ('CICNIG', 1310, 2514, 41)
      , ('PERAPI', 2310, 2832, 144)
      , ('LARRID', 5820, 530157, 282)
      , ('PYRGRA', 15580, 4485, 369)
      , ('ACTHYP', 5560, 2616, 233)
      , ('BUTVIR', NULL, 199328, 1021)
      , ('GAVADA', 50, 953, 4)
      , ('PETPET', 16040, 4540, 497)
      , ('AYTFER', 1980, 1991, 118)
      , ('FULGLA', 220, 998, 10)
      , ('ANSANSRUB', 1612, 2745, 1370)
      , ('PSIKRA', 7120, 3448, 537)
      , ('CALDIO', 360, 1009, 11)
      , ('ANTPETLIT', 10143, 3719, 471)
      , ('TRINEB', 5480, 2594, 230)
      , ('TRYSUB', 5160, 2929, NULL)
      , ('OCEOCE', 500, 1039, 1084)
      , ('STEFUS', 6230, 528760, 1417)
      , ('XENCIN', 5550, 2610, 235)
      , ('MELPER', 2140, 2798, 1081)
      , ('ANTTRI', 10090, 3723, 467)
      , ('CINCIN', 10500, 3958, 384)
      , ('CIRCYA', 2610, 2881, 163)
      , ('SYLSAR', 12610, 4219, 1126)
      , ('ACCGEN', 2670, 2891, 147)
      , ('LOCLAN', 12350, 199458, 1077)
      , ('PHAARI', 800, 2447, 27)
      , ('ANADIS', 1920, 1962, NULL)
      , ('PORPOR', 4080, 3039, 200)
      , ('TURRUFRUF', 11971, NULL, NULL)
      , ('ANSCAECAE', 1631, NULL, NULL)
      , ('ALEBAR', 3590, 2978, 1004)
      , ('COTCOT', 3700, 2996, 189)
      , ('STEHIR', 6150, 3343, 293)
      , ('EGRGUL', 1180, 2494, 35)
      , ('STRDEC', 6840, 3429, 312)
      , ('CATSEM', 5600, 626151, 1033)
      , ('AYTNYR', 2020, 1995, 121)
      , ('FULCRI', 4310, 3072, 1057)
      , ('PASHIS', 15920, 4530, 1089)
      , ('CALFER', 5090, 2901, 250)
      , ('MELCAL', 9610, 3644, 343)
      , ('GLAPAS', 7510, 3507, 319)
      , ('PUFASS', 480, 1020, 16)
      , ('SAXTOR', 11390, 199425, 397)
      , ('UPUEPO', 8460, 3590, 332)
      , ('LIMLIM', 5320, 2563, 225)
      , ('ALEGRA', 3570, 2971, 185)
      , ('TURILI', 12010, 4137, 413)
      , ('PUFPUF', 460, 1027, 14)
      , ('TETRIX', 3320, 2960, NULL)
      , ('HIRRUS', 9920, 3696, 351)
      , ('CALLAP', 18470, 4644, 532)
      , ('BULBUL', 340, 1005, 1019)
      , ('AQUNIP', 30530, 2648, 1011)
      , ('PHAPYG', 820, 2454, 28)
      , ('CALALP', 5120, 2911, 249)
      , ('PHACOL', 3940, 3003, 190)
      , ('SERSER', 16400, 4571, 508)
      , ('PYRPYR', 17100, 4619, 511)
      , ('ARDRAL', 1080, 2486, 31)
      , ('HIPPAL', 12550, 199463, 430)
      , ('PHYPRO', 12980, 4267, 1099)
      , ('DENSTR', 17530, 627671, 1047)
      , ('CORMONMON', 15601, 4497, NULL)
      , ('ANAPLA', 1860, 1966, 86)
      , ('EUOMAL', 16180, 534746, 1053)
      , ('MERAPI', 8400, 3582, 330)
      , ('PASMON', 15980, 4532, 495)
      , ('CEPGRY', 6380, 3392, 302)
      , ('COCCOC', 17170, 4625, 498)
      , ('SCORUS', 5290, 2559, 240)
      , ('ANAQUE', 1910, 1975, NULL)
      , ('FALNAU', 3030, 2666, 178)
      , ('ACRRIS', 12500, 4192, 423)
      , ('GAVSTE', 20, 2411, 1)
      , ('LOCCER', 12330, 4161, 1075)
      , ('THRAET', 1420, 2687, 588)
      , ('TROTRO', 10660, 3967, 385)
      , ('BONBON', 3260, 199294, NULL)
      , ('CARHOREXI', 16642, NULL, NULL)
      , ('TRIGLA', 5540, 2607, 232)
      , ('CALMEL', 5070, 3226, 247)
      , ('TRITOTTOT', 5461, 2590, NULL)
      , ('LUSLUS', 11030, 4010, 387)
      , ('AYTAFF', 2050, 199305, 124)
      , ('CHEGRE', 4910, 3178, NULL)
      , ('ANTCAM', 10050, 3713, 465)
      , ('POLSTE', 2090, 199307, 135)
      , ('FALSUB', 3100, 2679, 174)
      , ('CORDAU', 15610, 199412, 1044)
      , ('MOTFLA', NULL, 3741, 478)
      , ('STRROS', 6830, 3432, 1122)
      , ('MELNIG', 2130, 2794, 133)
      , ('BRACAN', 1660, 2747, 72)
      , ('COLVIR', 3450, 3017, 1043)
      , ('AYTFERNYR', NULL, NULL, NULL)
      , ('GAVARC', 30, 956, 2)
      , ('PHYCOLCOL', 13111, NULL, NULL)
      , ('BOMGAR', 10480, 3953, 485)
      , ('AEGCAU', 14370, 4342, 377)
      , ('TURPHI', 12000, 4129, 414)
      , ('ANSIND', 1620, 2731, 69)
      , ('STUROS', 15840, 4520, 492)
      , ('GALTHE', 9730, 3661, 1058)
      , ('TURTORALP', 11862, 4114, 574)
      , ('CHAHIA', 4700, 3140, 217)
      , ('CHLHYB', 6260, 459627, 288)
      , ('ANSALBFLA', 1592, 2738, 1006)
      , ('PHACARSIN', 722, 2446, 26)
      , ('CORGAR', 8410, 3586, 331)
      , ('BRALEU', 1670, 2750, 71)
      , ('HIPOLI', 12580, NULL, NULL)
      , ('AQUCHR', 2960, 2645, 154)
      , ('PTEORI', 6610, NULL, NULL)
      , ('TYTALB', 7350, 3482, 315)
      , ('SYRPAR', 6630, 3415, 305)
      , ('TETURO', 3350, 2964, 181)
      , ('JYNTOR', 8480, 3595, 333)
      , ('PARCAE', 14620, 534742, 371)
      , ('MOTIMA', 10172, 3745, 477)
      , ('PORPAR', 4100, 836245, NULL)
      , ('CICCIC', 1340, 2517, 39)
      , ('VIROLI', 16330, 4560, 1137)
      , ('CATUST', 11770, 4100, 1032)
      , ('LARATR', 5760, 627332, NULL)
      , ('PLUAPR', 4850, 3161, 216)
      , ('CHALES', 4790, 3148, 1036)
      , ('LARFUSGRA', 5912, 3300, 1162)
      , ('PODPOD', 60, 982, 1104)
      , ('LIMSCO', 5270, 2554, 1074)
      , ('CAPRUF', 7790, 3544, 1029)
      , ('ACRSCH', 12430, 4187, 426)
      , ('LARPHI', 5810, 534682, 1070)
      , ('ZOODAU', 11700, 4091, NULL)
      , ('ALAARV', 9760, 3676, 349)
      , ('PHYCOL', 13110, 4280, 446)
      , ('MERMER', 2230, 2818, 141)
      , ('MOTFLA', 10170, 3741, 476)
      , ('CETCET', 12200, 4151, 416)
      , ('ANSBRA', 1580, 2725, 65)
      , ('GRIVES', 12069, 198744, 1204)
      , ('MERPER', 8393, 3578, 1083)
      , ('ACRSCI', 12510, 4195, 422)
      , ('OENOEN', 11460, 4064, 399)
      , ('ANTHOD', 10080, 3736, 466)
      , ('SYLHOR', 12720, 4242, 435)
      , ('TETRAX', 4420, 3089, 182)
      , ('EMBCIA', 18600, 4663, 528)
      , ('MOTCIN', 10190, 3755, 474)
      , ('OTITAR', 4460, 3101, 207)
      , ('CARFLA', 16630, 4595, 504)
      , ('SOMMOL', 2060, 2005, 131)
      , ('TURSYL', 4000, NULL, NULL)
      , ('BRABERBER', 1681, 2760, 1371)
      , ('GALMED', 5200, 2549, 237)
      , ('ANASTR', 1820, 1956, 111)
      , ('TURRUFATR', 11972, 4136, 410)
      , ('PORCAR', 4090, 3049, 1105)
      , ('MUSSTR', 13350, 4319, 457)
      , ('CALCAN', 4960, 3192, 242)
      , ('AYTFUL', 2030, 1998, 119)
      , ('COLLIV', 6650, 3420, 308)
      , ('CALTEM', 5020, 3210, 244)
      , ('CATMIN', 11780, 4106, 1031)
      , ('PHACARCAR', 721, 2442, 25)
      , ('STEBEN', 6090, 3359, NULL)
      , ('LANCOL', 15150, 3807, 490)
      , ('FALVES', 3070, 2674, 177)
      , ('COLOEN', 6680, 3422, 309)
      , ('GELNIL', 6050, 3332, 291)
      , ('GAVIMM', 40, 959, 3)
      , ('HIPCAL', 12560, 199465, 432)
      , ('CHELEU', 4920, 3182, NULL)
      , ('PODNIG', 120, 974, 7)
      , ('RHOGIT', 20280, 2405, 576)
      , ('STELON', 5680, 3261, 266)
      , ('CALBAI', 5060, 3222, 246)
      , ('PINENU', 16990, 4613, 513)
      , ('PODCRI', 90, 965, 8)
      , ('TACRUF', 70, 977, 5)
      , ('AEGCAUROS', 14375, NULL, NULL)
      , ('FICHYP', 13490, 4330, 458)
      , ('RAPACE', NULL, NULL, NULL)
      , ('LANSEN', 15230, 4460, 489)
      , ('CARFLAROS', 16632, NULL, NULL)
      , ('CALLLA', 5040, 3214, 1025)
      , ('LOXPYT', 16680, 4607, 516)
      , ('OENISA', 11440, 4062, 398)
      , ('TURVIS', 12020, 4142, 415)
      , ('SAXRUB', 11370, 4049, 396)
      , ('ERIRUB', 10990, 4001, 386)
      , ('CUCCAN', 7240, 3465, 314)
      , ('AQUADA', 2952, 2634, 1010)
      , ('LEILUT', 14070, 444425, 543)
      , ('AEGCAUCAU', 14371, 804727, 377)
      , ('PANHAL', 3010, 2660, 169)
      , ('SYLNIS', 12730, 4245, 434)
      , ('ANSFAB', 1570, 2720, 63)
      , ('CIRAER', 2600, 2878, 166)
      , ('CIRGAL', 2560, 2873, 168)
      , ('FALRUS', 3180, 2931, 172)
      , ('CARCHL', 16490, 4580, 499)
      , ('EMBCIT', 18570, 4657, 521)
      , ('CARCAN', 16600, 4588, 502)
      , ('LARHYP', 5990, 3309, 278)
      , ('GYPBAR', 2460, 2852, 162)
      , ('MICHIM', 5150, 444423, 1023)
      , ('OCEMON', 560, 2429, NULL)
      , ('STRTUR', 6870, 3439, 311)
      , ('PHATRI', 5630, 3247, NULL)
      , ('LUSSVECYA', 11062, 4027, 391)
      , ('STUUNI', 15830, 4518, 1124)
      , ('FREMAG', 930, 2468, 1056)
      , ('CARFLA', 16634, 4598, 504)
      , ('STEELE', 6120, 3356, NULL)
      , ('FICPAR', 13430, 4324, 460)
      , ('MOTCIT', 10180, 3948, 484)
      , ('SAXTORMAU', 11394, 458695, 1111)
      , ('ALLALL', 6470, 3396, 299)
      , ('MOTFLACIN', 10175, 3748, 480)
      , ('TRICIN', 5550, 2610, 235)
      , ('NUCCARMAC', 15572, NULL, NULL)
      , ('CERGAL', 10950, 3996, 443)
      , ('LARCAC', 5927, 3289, 274)
      , ('MOTFLA', NULL, 3741, 475)
      , ('CYGCOL', 1530, 2709, 53)
      , ('ANSCAEATL', 1632, NULL, NULL)
      , ('EMBAUR', 18760, 4678, 525)
      , ('OENHIS', 11480, 4074, 401)
      , ('LARARGARG', 5920, NULL, NULL)
      , ('TADTAD', 1730, 2767, 82)
      , ('CALPUS', 4980, 3199, 1026)
      , ('PARCRI', 14540, 534750, 374)
      , ('LARMEL', 5750, 627745, 281)
      , ('AREINT', 5610, 3239, 236)
      , ('PHOPHO', 11220, 4040, 395)
      , ('NYCNYC', 1040, 2481, 36)
      , ('STECAS', 6060, 3336, 292)
      , ('ELACAE', 2350, 2836, 143)
      , ('LARGEN', 5850, 534662, 283)
      , ('PARPAL', 14400, 534753, 375)
      , ('RIPRIP', 9810, 3688, 355)
      , ('BOTSTE', 950, 2473, 38)
      , ('PLUSQU', 4860, 3165, 215)
      , ('CYGOLO', 1520, 2706, 54)
      , ('LARSAB', 5790, 364251, 287)
      , ('CYGCYG', 1540, 2715, 52)
      , ('EMBCAE', 18680, 4674, 1050)
      , ('ACRDUM', 12480, 4190, 424)
      , ('ANTGUS', 10100, 3738, 1008)
      , ('PHAARIARI', 801, 2450, 1378)
      , ('GALGAL', 5190, 2543, 238)
      , ('GARGLA', 15390, 4466, 366)
      , ('COCAME', 7280, 3476, 1041)
      , ('LOCLUS', 12380, 4172, 419)
      , ('FALBIA', 3140, 2683, 170)
      , ('CHADUB', 4690, 3136, 218)
      , ('ASIOTU', 7670, 3522, 322)
      , ('GRUGRU', 4330, 3076, 193)
      , ('HISHIS', 2110, 2788, 130)
      , ('PRUMOD', 10840, 3978, 461)
      , ('DENSYR', 8780, NULL, NULL)
      , ('REGREG', 13140, 4308, 455)
      , ('PODGRI', 100, 968, 9)
      , ('DIOMEL', 140, 442424, 1128)
      , ('LARMAR', 6000, 3311, 276)
      , ('PHYBOR', 12950, 4264, 453)
      , ('FALCHE', 3160, 2672, 171)
      , ('LAGLAG', 3290, 2948, 1064)
      , ('ACRAGR', 12470, 199459, 425)
      , ('ANSANSANS', 1611, 2744, 1369)
      , ('BUROED', 4590, 3120, 259)
      , ('PICPIC', 15490, 4474, 363)
      , ('PHACAR', 720, 2440, 24)
      , ('CYACYA', 15470, 199411, 364)
      , ('BUTRUF', 2880, 2627, 149)
      , ('REGIGN', 13150, 459638, 456)
      , ('HIMHIM', 4550, 3112, 254)
      , ('STRNEB', 7660, NULL, NULL)
      , ('GALCHL', 4240, 3059, 202)
      , ('TURPIL', 11980, 4127, 412)
      , ('LAGMUT', 3300, 459629, NULL)
      , ('PUFGRI', 430, 1024, 13)
      , ('LARFUSFUS', 5911, 3299, 1068)
      , ('NUCCARCAR', 15571, 4482, 1173)
      , ('AIXGAL', 1780, 2776, 109)
      , ('TURRUF', 11970, 4121, 1134)
      , ('ALCATT', 8310, 3571, 329)
      , ('PHYBON', 13070, 4269, 449)
      , ('CORRAX', 15720, 4510, 357)
      , ('LUSSVE', 11060, 4023, 389)
      , ('OENPLE', 11470, 4070, 402)
      , ('CRECRE', 4210, 3053, 197)
      , ('FRIMON', 16380, 4568, 519)
      , ('CORFRU', 15630, 4501, 361)
      , ('LAGLAGSCO', 3292, NULL, NULL)
      , ('RISTRI', 6020, 3318, 286)
      , ('CALMIN', 5010, 3206, 243)
      , ('EMBLEU', 18560, 199522, 522)
      , ('CLAGLA', 7160, 3461, 313)
      , ('MELFUS', 2150, 2801, 134)
      , ('PLALEU', 1440, 2530, 42)
      , ('CARCAR', 16530, 4583, 500)
      , ('CHAASI', 4800, 3150, 1035)
      , ('LANEXC', 15200, 3814, 486)
      , ('COLPAL', 6700, 3424, 310)
      , ('SITEUR', 14790, 3774, 380)
      , ('DRYMAR', 8630, 3608, 336)
      , ('MONNIV', 16110, 4537, 496)
      , ('BRABER', 1680, 2757, 70)
      , ('PHYDES', 12930, 4275, 454)
      , ('EREALP', 9780, 3681, 350)
      , ('LUSSVESVE', 11061, 4026, 390)
      , ('ANSANS', 1610, 2741, 60)
      , ('MOTALBYAR', 10202, 3945, 473)
      , ('SITWHI', 14700, 3772, 1115)
      , ('LOCFAS', 12390, 4175, 1076)
      , ('SYRREE', 3930, 3000, 1127)
      , ('ANTPET', 10142, 3716, 1280)
      , ('BUTBUT', 2870, 2623, 150)
      , ('PARLUG', 14410, NULL, NULL)
      , ('STUVUL', 15820, 4516, 491)
      , ('SULBAS', 710, 2437, 23)
      , ('DELURB', 10010, 459478, 354)
      , ('VANVAN', 4930, 3187, 213)
      , ('ANSCAE', 1630, 2727, 58)
      , ('PLUDOM', 4840, 3158, 1102)
      , ('FRAARC', 6540, 3402, 304)
      , ('PHYSIB', 13080, 4272, 450)
      , ('TUROBS', 11950, 4119, 409)
      , ('PINSON', NULL, NULL, NULL)
      , ('CIRPYG', 2630, 2887, 165)
      , ('CALRUF', 9700, 199485, 346)
      , ('LARMIC', 5926, 199374, 273)
      , ('TICMUR', 14820, 3780, 383)
      , ('URIAAL', 6340, 3379, 301)
      , ('STESAN', 6110, 3362, 298)
      , ('AYTCOL', 2000, 1988, 120)
      , ('HAEOST', 4500, 3106, 209)
      , ('OTUSCO', 7390, 3489, 316)
      , ('HIPPOL', 12600, 4215, 428)
      , ('ORIORI', 15080, 3803, 356)
      , ('PYRRAX', 15590, 4488, 368)
      , ('CHEDUP', 9590, 3666, 1039)
      , ('PARAME', 17320, 627455, 1088)
      , ('SITNEU', 14810, NULL, NULL)
      , ('FALELE', 3110, 2681, 175)
      , ('SERCIT', 16440, 4574, 507)
      , ('ARDPUR', 1240, 2508, 30)
      , ('TRISTA', 5470, 2591, 229)
      , ('CERFAM', 14860, 3784, 381)
      , ('PORALL', 4250, 3065, 203)
      , ('PHYSCH', 13010, 4300, 1100)
      , ('ANACRE', 1840, 1958, 94)
      , ('STECUS', 5670, 3258, 265)
      , ('BRARUF', 1690, 2753, 73)
      , ('CIRMAC', 2620, 2884, 164)
      , ('MILCAL', 18820, 4686, 520)
      , ('LOCNAE', 12360, 4167, 417)
      , ('HALALB', 2430, 2848, 158)
      , ('LUSSVENAM', 11063, 4028, 1234)
      , ('TURTOR', 11860, 4112, 407)
      , ('LARARG', 5920, 3302, 272)
      , ('PORRIO', 4270, 3067, 204)
      , ('CALMAU', 4990, 3203, 1024)
      , ('FULATR', 4290, 3070, 205)
      , ('PARMON', 14420, 4355, 376)
      , ('LANISA', 15140, 459630, 587)
      , ('SYLCOM', 12750, 4252, 437)
      , ('SYLBOR', 12760, 4254, 436)
      , ('ALOAEG', 1700, 459626, NULL)
      , ('AIXSPO', 1770, 2775, 110)
      , ('URILOM', 6350, 3382, 1135)
      , ('TRIFLA', 5510, 2600, 1130)
      , ('STRURA', 7650, NULL, NULL)
      , ('APUAPU', 7950, 3551, 327)
      , ('PASDOM', 15910, 4525, 493)
      , ('AQUHEL', 2950, 2643, 155)
      , ('SURULU', 7500, 3503, 318)
      , ('NEOPER', 2470, 2856, 161)
      , ('FALPER', 3200, 2938, 173)
      , ('EGRGAR', 1190, 2497, 34)
      , ('PELONO', 880, 2460, 20)
      , ('PLUAPRAPR', 4851, NULL, NULL)
      , ('DENMAJ', 8760, 3611, 337)
      , ('GLANOR', 4670, 3132, 262)
      , ('STESKU', 5690, 3263, 263)
      , ('DENLEU', 8840, 3625, 339)
      , ('DENVID', NULL, 2399, 50)
      , ('CARHORHOR', 16641, NULL, NULL)
      , ('LARGLA', 5980, 3307, 279)
      , ('STEDOU', 6140, 3364, 295)
      , ('DENMIN', 8870, 3630, 340)
      , ('TURMER', 11870, 4117, 408)
      , ('BUBBUB', 7440, 3493, 317)
      , ('TURDUS', NULL, NULL, NULL)
      , ('PERINF', 15430, NULL, NULL)
      , ('ANSFABFAB', 1571, 2723, 64)
      , ('ASIFLA', 7680, 3525, 323)
      , ('MOTALBALB', 10201, 3943, 1182)
      , ('PODAUR', 110, 971, 6)
      , ('ANSALB', 1590, 2734, 61)
      , ('MONSAX', 11620, 4084, 403)
      , ('NYCSCA', 7490, 199395, NULL)
      , ('PUFGRA', 400, 790987, NULL)
      , ('CORCOR', 15670, 4503, 1270)
      , ('CISJUN', 12260, 4155, 444)
      , ('NUMPHA', 5380, 2571, 222)
      , ('ANAAME', 1800, 1953, NULL)
      , ('RHOROS', 6010, 3314, 285)
      , ('PHIPUG', 5170, 814245, NULL)
      , ('CALALB', 4970, 3195, 241)
      , ('STEPOM', 5660, 3255, 264)
      , ('ROSBEN', 4490, NULL, NULL)
      , ('PTYRUP', 9910, 3692, 353)
      , ('MONSOL', 11660, 4087, 404)
      , ('AQUPOM', 2920, 836345, NULL)
      , ('PYRPYREUR', 17102, 4623, 1251)
      , ('ACRPAL', 12420, 4184, 427)
      , ('ANAACU', 1890, 1973, 101)
      , ('PARCYA', 14630, 3768, NULL)
      , ('APUMEL', 7980, 3558, 326)
      , ('CARRIS', 16620, 4590, 503)
      , ('CALLIS', 5000, 199353, 1027)
      , ('LYMMIN', 5180, 2538, 239)
      , ('PARATE', 14610, 534751, 373)
      , ('CAPEUR', 7780, 3540, 325)
      , ('PHYFUS', 13030, 4304, 451)
      , ('LOXSCO', 16670, NULL, NULL)
      , ('PHYCOLBRE', 13116, 4283, 1321)
      , ('NUMARQ', 5410, 2576, 224)
      , ('LARAUD', 5880, 627743, NULL)
      , ('LIMFAL', 5140, 828816, NULL)
      , ('TRIOCH', 5530, 2603, 231)
      , ('BUTLAG', 2900, 2630, 151)
      , ('RALAQU', 4070, 3036, 196)
      , ('ANTSPISPI', 10140, 162665, 469)
      , ('PHAARIDES', 802, 2452, 1512)
      , ('FALCOL', 3090, 2676, 176)
      , ('HIRDAU', 9950, 3701, 352)
      , ('PASITA', 15912, 199494, 494)
      , ('ZOOSIB', 11710, 4095, NULL)
      , ('CALFUS', 5050, 3218, 245)
      , ('AEGFUN', 7700, 3533, 324)
      , ('EMBHOR', 18660, 4665, 527)
      , ('ANAPEN', 1790, 1950, NULL)
      , ('LARCAN', 5900, 3293, 270)
      , ('CALALPALP', 5121, 2916, 15256)
      , ('SYLRUE', 12690, 199469, 1125)
      , ('CLAHYE', 2120, 2790, 129)
      , ('GLAPRA', 4650, 3129, 261)
      , ('MILMIL', 2390, 2844, 145)
      , ('TRITOT', 5460, 2586, 228)
      , ('CORCORSAR', NULL, 4509, NULL)
      , ('OXYLEU', 2260, 2826, 136)
      , ('ATHNOC', 7570, 3511, 320)
      , ('CARHOR', 16640, 199503, 506)
      , ('STEANA', 6220, 532691, 1116)
      , ('ANSFABJOH', 1572, NULL, NULL)
      , ('EMBMEL', 18810, 4680, 523)
      , ('STRORI', 6890, 3442, 1121)
      , ('EMBCIR', 18580, 4659, 526)
      , ('ANSFABROS', 1574, 2724, 66)
      , ('HIEFAS', 2990, 2657, NULL)
      , ('EMBSCH', 18770, 4669, 531)
      , ('LOCFLU', 12370, 4170, 418)
      , ('FICALB', 13480, 4327, 459)
      , ('HOPSPI', 4870, NULL, NULL)
      , ('IXOMIN', 980, 2477, 37)
      , ('PAGEBU', 6040, 3322, 268)
      , ('PELCRI', 890, 2462, 22)
      , ('STEMAX', 6070, 528761, NULL)
      , ('STRSEN', 6900, 3435, 573)
      , ('PICCAN', 8550, 3601, 335)
      , ('HIPICT', 12590, 4212, 429)
      , ('PICVIR', 8560, 3603, 334)
      , ('PYRPYRPYR', 17101, 4621, NULL)
      , ('PRUCOL', 10940, 3984, 462)
      , ('AYTMAR', 2040, 2001, 123)
      , ('ANTRIC', 10020, 3709, 464)
      , ('CHLNIG', 6270, 3371, 290)
      , ('OCELEU', 550, 2423, NULL)
      , ('LARFUS', 5910, 3297, 275)
      , ('CALALPSCH', 5123, 2918, 15255)
      , ('NETRUF', 1960, 1984, 115)
      , ('PHAFUL', 5650, 3250, 256)
      , ('ACCNIS', 2690, 2895, 148)
      , ('GALCRI', 9720, 3656, 347)
      , ('LOXLEU', 16650, 4609, 517)
      , ('LANMER', 32910, 199409, 487)
      , ('LOXCUR', 16660, 4603, 515)
      , ('ANTSPI', 10140, 3733, 469)
      , ('TRIERY', 5450, 2584, 227)
      , ('LULARB', 9740, 3670, 348)
      , ('APUPAL', 7960, 3555, 328)
      , ('EMBPUS', 18740, 4667, 530)
      , ('LARHEU', 5922, NULL, NULL)
      , ('MOTFLAIBE', 10176, 3747, 481)
      , ('CORCORNIX', 15673, 4505, 360)
      , ('PHALOB', 5640, 3243, 257)
      , ('ACRMEL', 12410, 4180, 420)
      , ('LIMICO', NULL, NULL, NULL)
      , ('ARDCIN', 1220, 2506, 29)
      , ('OXYJAM', 2250, 2823, 137)
      , ('PANBIA', 13640, 4338, 379)
      , ('CHLLEU', 6280, 3374, 289)
      , ('OENLEU', 11580, 4080, 1000)
      , ('CURCUR', 4640, 3125, 260)
      , ('REMPEN', 14900, 3798, 378)
      , ('TORTRA', 2540, 2864, 1129)
      , ('STEPAR', 6160, 3345, 294)
      , ('LARMIN', 5780, 534748, 284)
      , ('BUBIBI', 1110, 2489, 32)
      , ('CARFLAFLA', 16631, 4600, 1706)
      , ('OCECAS', 580, 2426, NULL)
      , ('PUFYEL', 462, 1031, 15)
      , ('PHOOCH', 11210, 4035, 394)
      , ('TRIMEL', 5500, 2597, 1131)
      , ('HYDPEL', 520, 2419, 17)
      , ('LUSMEG', 11040, 4013, 388)
      , ('PARMAJ', 14640, 3764, 370)
      , ('BUCCLA', 2180, 2808, 126)
      , ('ALECHU', 3550, 2981, 187)
      , ('CARSPI', 16540, 4586, 501)
      , ('LIMLAP', 5340, 2568, 226)
      , ('CORCOR', NULL, 4503, 358)
      , ('CHAMOR', 4820, 3155, NULL)
      , ('MOTFLA', 10171, 3744, 476)
      , ('PHOMOU', 11270, NULL, NULL)
      , ('SERCOR', 16442, 534755, NULL)
      , ('TRITOTROB', 5462, 2589, NULL)
      , ('CALCAL', 3410, 3014, 1028)
      , ('EGRALB', 1210, 2504, 33)
      , ('GYPFUL', 2510, 2860, 160)
      , ('BUCISL', 2170, 2805, 128)
      , ('ANTPRA', 10110, 3726, 463)
      , ('PLEFAL', 1360, 2522, 44)
      , ('DIOEXU', 200, 988, 1048)
      , ('ANSERY', 1600, 2739, 62)
      , ('ALERUF', 3580, 2975, 186)
      , ('ARDMEL', 20310, 2510, 1013)
      , ('PLUFUL', 4842, 3170, 590)
      , ('LARMEL', 5750, 3272, 281)
      , ('EGRALB', 1210, 2502, 33)
      , ('PARMON', 14420, 534752, 376)
;