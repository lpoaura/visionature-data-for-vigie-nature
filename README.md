# visionature-data-for-vigie-nature

Transformation process of VisioNature data for the French national program Vigie-Nature

## Database model

![modelisation_bdd.png](modelisation_bdd.png)

## Partenaires

Ce projet a été développé par la [LPO Auvergne-Rhône-Alpes](https//auvergne-rhone-alpes.lpo.fr/) pour la LPO France et le Muséum national d'Histoire Naturelle.

## Note

Le processus de synchronisation des données (API VisioNature via l'application Client-API-VN) peut provoquer une mise à jour incomplète des données, les formulaires pouvant être créés après l'insertion des formulaires (relevés) dans la base de données. Pour corriger ce problème, il est recommandé de lancer régulièrement via une tache cron le script `11_missing_data.sql`.

## Equipe

Les contributeurs du projet sont:

- Frédéric CLOITRE (@lpofredc) : Développement
- Julien GIRARD-CLAUDON (@lpojgc) : Coordination du projet
