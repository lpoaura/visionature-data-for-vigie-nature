# Changelog


## 1.2.1 - Aug 19, 2025

### Fixes

- Fix view `pr_vigienature.v_vigienature_observers` which file in case of old data (not visionature sourced) are imported, where observers are not IDs.

### ToDo

- Execute following SQL code:

```sql
CREATE VIEW pr_vigienature.v_vigienature_observers AS
    SELECT site
        , id                       AS id_local
        , id_universal
        , item ->> 'email'::TEXT   AS email
        , item ->> 'name'::TEXT    AS nom
        , item ->> 'surname'::TEXT AS prenom
   FROM src_vn_json.observers_json
   WHERE (id_universal IN (SELECT t_releve.observateur::INTEGER AS observateur
                           FROM pr_vigienature.t_releve where (t_releve.observateur ~ '^\d+$')));
```

## 1.2.0 - Nov 7, 2023

### Release Note release 

- Execute script `01_functions.sql`
- Add a cron task to execute daily or weekly `11_missing_data.sql` script

## 1.1.0 - Aug 30, 2023


- Update README by @lpofredc in #2
- Add missing nomenclature by @lpofredc in #3
- Fix missing obs delete trigger @lpofredc

## 1.0.0 - Aug 31, 2022

First release !!!
