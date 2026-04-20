# Proyecto dbt — Examen II (BigQuery)

Transformaciones de datos con dbt sobre Google BigQuery. Incluye modelos `staging`, `intermediate`, `marts`, macros y **tests de calidad**.

## Requisitos

- Python **3.11** (recomendado; evitar Python 3.14 con dbt por incompatibilidades conocidas).
- Entorno virtual del repo: `../dbt-env` (desde la carpeta `dbt_exam`).
- Perfil dbt en `~/.dbt/profiles.yml` con perfil **`dbt_demo`** y conexión BigQuery (service account u OAuth).

## Comandos básicos

Activa el entorno y sitúate en este directorio:

```bash
cd /ruta/a/dbt_exam
source dbt-env/bin/activate
cd dbt_project_exam
```

| Comando | Descripción |
|--------|-------------|
| `dbt debug` | Comprueba `profiles.yml`, proyecto y conexión a BigQuery. |
| `dbt seed` | Carga seeds (p. ej. `countriesEU.csv`) al dataset configurado. |
| `dbt run` | Ejecuta todos los modelos. |
| `dbt test` | Ejecuta **todos** los tests (genéricos en YAML + singulares en `tests/`). |
| `dbt build` | `seed` + `run` + `test` + snapshots en orden de dependencias. |

Con ruta explícita al proyecto:

```bash
dbt test --project-dir /ruta/a/dbt_exam/dbt_project_exam
```

### Ejecutar tests selectivos

```bash
# Solo tests de un modelo
dbt test --select stg_orders

# Solo tests genéricos
dbt test --select test_type:generic

# Solo tests singulares (SQL en tests/)
dbt test --select test_type:singular

# Un test singular por nombre de archivo (sin .sql)
dbt test --select eu_discount_allowed_values
```

## Tests implementados

### Dónde viven

- **Tests genéricos** (`not_null`, `unique`, `relationships`, `accepted_values`): definidos en YAML junto a los modelos:
  - [`models/staging/schema.yml`](models/staging/schema.yml)
  - [`models/intermediate/schema.yml`](models/intermediate/schema.yml)
  - [`models/marts/schema.yml`](models/marts/schema.yml)
- **Tests singulares** (SQL en `tests/`): consultas que fallan si devuelven filas:
  - [`tests/eu_discount_allowed_values.sql`](tests/eu_discount_allowed_values.sql) — valores de `descuento` solo `var('discount')` o `1`.
  - [`tests/shipper_ranking_non_negative_orders.sql`](tests/shipper_ranking_non_negative_orders.sql) — `cantidad_pedidos` no negativa.

### Qué validan (resumen)

| Capa | Enfoque |
|------|---------|
| **Staging** | PKs (`unique` + `not_null`); FKs de pedidos hacia clientes, empleados y transportistas (`relationships`). |
| **Intermediate** | Integridad de pedidos y relaciones; `estado` EU con `accepted_values`. |
| **Marts** | Métricas y reglas de negocio (`estado` reconocido, `descuento`, conteos). |

### Severidad (`severity`)

En [`dbt_project.yml`](dbt_project.yml) el proyecto define por defecto **`+severity: error`**: si un test falla, el comando `dbt test` termina con error.

Se pueden **sobrescribir** casos puntuales:

- En YAML de columnas: por ejemplo `accepted_values` de `estado` en `int_customers_in_eu` con `severity: warn` (advertencia sin fallar el job completo según configuración de dbt).
- En tests singulares: `{{ config(severity='warn') }}` o `severity='error'` al inicio del `.sql`.

Interpretación: **`error`** bloquea el resultado del comando; **`warn`** registra el fallo como advertencia.

## Recursos

- [Documentación dbt](https://docs.getdbt.com/docs/introduction)
- [Comando dbt test](https://docs.getdbt.com/reference/commands/test)
- [Configuración de tests](https://docs.getdbt.com/reference/test-configs)
