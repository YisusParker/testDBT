# Ejecución del Proyecto DBT (Los CSVS usados fueron los ***updated.csv)

Para ejecutar este proyecto después de clonar el repositorio, seguir el siguiente flujo:

```text
git clone
↓
crear entorno Python
↓
instalar dbt-bigquery
↓
configurar profiles.yml
↓
dbt debug
↓
dbt seed
↓
dbt run
↓
ver resultados en BigQuery
```

## 1. Clonar el repositorio

```bash
git clone <url_del_repositorio>
cd dbt_project_exam
```

## 2. Crear entorno virtual de Python

```bash
py -3.11 -m venv venv
source dbt-env/bin/activate
```

## 3. Instalar DBT para BigQuery

```bash
pip install dbt-bigquery
```

## 4. Configurar autenticación (`profiles.yml`)

Crear el archivo:

```text
~/.dbt/profiles.yml
```

Ejemplo de configuración:

```yaml
dbt_project_exam:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project: data-transformation-486715
      dataset: exam_1
      threads: 4
      keyfile: /ruta/al/service-account.json
      location: US
      timeout_seconds: 300
```

## 5. Verificar conexión

```bash
dbt debug
```

## 6. Cargar datos iniciales

```bash
dbt seed
```

## 7. Ejecutar transformaciones

```bash
dbt run
```

## 8. Ver resultados en BigQuery

Ejecutar en BigQuery:

```sql
SELECT *
FROM `data-transformation-486715.exam_1.my_second_dbt_model`
```

