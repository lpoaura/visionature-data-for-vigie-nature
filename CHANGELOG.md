# Changelog


## 1.2.1 - Aug 19, 2025

### Fixes

- Fix view `pr_vigienature.v_vigienature_observers` which file in case of old data (not visionature sourced) are imported, where observers are not IDs.
- Cleanup views `pr_vigienature.v_vigienature_observers` and `pr_vigienature.v_vigienature_data`

### ToDo

- apply sql script `12_views.sql`


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
