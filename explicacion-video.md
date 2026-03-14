# Guion del Video – Examen I DBT & BigQuery

Duración sugerida del video: **4–6 minutos**
Participantes: **Natalia, Villadiego, Sharick, Jesus, Carlos, Anghely**

El objetivo del video es demostrar el flujo completo de **transformación de datos usando DBT y BigQuery**.

---

# 1. Introducción

### Quién habla

**Natalia**

### Qué mostrar en pantalla

* Carpeta del proyecto en el explorador o terminal
* Nombre del proyecto DBT

### Qué decir

> Hola, somos Natalia, Villadiego y Sharick.
> En este video presentaremos nuestro proyecto para el Examen I de DBT.
> En este proyecto demostramos un flujo completo de transformación de datos utilizando **DBT y Google BigQuery**.
> El proceso incluye autenticación con Google Cloud, carga de datos mediante **seeds**, transformación de datos usando **modelos DBT** y visualización de los resultados finales en **BigQuery**.

---

# 2. Mostrar estructura del proyecto

### Quién habla

**Villadiego**

### Qué mostrar en pantalla

Terminal mostrando la estructura del proyecto.

Ejecutar:

```bash
ls
```

Mostrar principalmente:

```text
dbt_project_exam
├── dbt_project.yml
├── models
├── seeds
├── macros
├── tests
```

### Qué decir

> Aquí podemos ver la estructura del proyecto DBT.
> La carpeta **models** contiene las transformaciones SQL que ejecutará DBT.
> La carpeta **seeds** contiene archivos CSV que serán cargados como tablas en BigQuery.
> Finalmente, el archivo **dbt_project.yml** contiene la configuración principal del proyecto.

---

# 3. Verificar conexión con BigQuery

### Quién habla

**Sharick**

### Qué mostrar en pantalla

Terminal ejecutando:

```bash
dbt debug
```

Mostrar resultado:

```text
All checks passed
```

### Qué decir

> Ahora verificamos la conexión entre DBT y BigQuery utilizando el comando **dbt debug**.
> Este comando valida la autenticación mediante la **Service Account**, revisa la configuración del archivo **profiles.yml** y confirma que DBT puede conectarse correctamente a BigQuery.

---

# 4. Cargar los datos iniciales

### Quién habla

**Natalia**

### Qué mostrar en pantalla

Terminal ejecutando:

```bash
dbt seed
```

Luego mostrar en BigQuery las tablas creadas.

### Qué decir

> A continuación cargamos los datos iniciales utilizando el comando **dbt seed**.
> Este comando toma los archivos CSV que se encuentran en la carpeta **seeds** y los carga como tablas en BigQuery.
> En nuestro caso se crean las tablas **raw_customers_updated** y **raw_orders_updated** dentro del dataset **exam_1**.

---

# 5. Mostrar el modelo de transformación

### Quién habla

**Villadiego**

### Qué mostrar en pantalla

Abrir archivo:

```
models/example/my_first_dbt_model.sql
```

Mostrar el código:

```sql
{{ config(materialized='table') }}

SELECT
    customer_id AS id,
    name,
    country_code,
    city,
    customer_tier
FROM {{ ref('raw_customers_updated') }}
WHERE customer_id IS NOT NULL
```

### Qué decir

> Este es nuestro modelo principal de transformación.
> Aquí utilizamos la función **ref()** de DBT para referenciar la tabla **raw_customers_updated** que fue creada a partir del seed.
> En esta transformación renombramos la columna **customer_id** como **id**, seleccionamos algunas columnas relevantes y eliminamos los registros donde el identificador sea nulo.

---

# 6. Nota sobre la transformación

### Quién habla

**Sharick**

### Qué mostrar en pantalla

El mismo modelo SQL abierto.

### Qué decir

> Esta transformación es un ejemplo simple y puede modificarse fácilmente según las necesidades del análisis.
> Por ejemplo, se podrían agregar más columnas, realizar **joins con la tabla de órdenes**, o generar métricas agregadas.
> DBT permite adaptar las transformaciones simplemente modificando la consulta SQL.

---

# 7. Ejecutar las transformaciones

### Quién habla

**Natalia**

### Qué mostrar en pantalla

Terminal ejecutando:

```bash
dbt run
```

Mostrar resultado final:

```text
Finished running 1 table model, 1 view model
Completed successfully
```

### Qué decir

> Ahora ejecutamos las transformaciones utilizando el comando **dbt run**.
> Este comando ejecuta todos los modelos definidos en la carpeta **models** y crea las tablas o vistas correspondientes en BigQuery.

---

# 8. Mostrar resultados en BigQuery

### Quién habla

**Villadiego**

### Qué mostrar en pantalla

BigQuery mostrando el dataset:

```
exam_1
```

Mostrar tablas:

```
raw_customers_updated
raw_orders_updated
my_first_dbt_model
my_second_dbt_model
```

Luego ejecutar:

```sql
SELECT *
FROM `data-transformation-486715.exam_1.my_second_dbt_model`
```

### Qué decir

> Aquí podemos ver las tablas generadas en BigQuery después de ejecutar el pipeline de DBT.
> Finalmente ejecutamos una consulta sobre el modelo **my_second_dbt_model**, el cual utiliza el resultado del modelo anterior para mostrar el resultado final de la transformación.

---

# 9. Conclusión

### Quién habla

**Sharick**

### Qué mostrar en pantalla

BigQuery con el resultado final de la consulta.

### Qué decir

> En conclusión, en este proyecto implementamos un pipeline de transformación de datos utilizando **DBT y BigQuery**.
> Primero cargamos los datos mediante **seeds**, luego aplicamos transformaciones usando **modelos DBT** y finalmente verificamos los resultados en **BigQuery**.
> Esto demuestra un flujo completo de **ingeniería de datos moderno utilizando DBT**.

---

