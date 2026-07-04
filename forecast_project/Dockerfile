# On part d'une base Python officielle et légère
FROM python:3.10-slim

# On met à jour le système et on installe les dépendances requises pour faire tourner PostgreSQL
RUN apt-get update \
    && apt-get install -y --no-install-recommends git libpq-dev python3-dev build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# On installe la version exacte de dbt-postgres
RUN pip install --no-cache-dir dbt-core==1.8.2 dbt-postgres==1.8.2

# On crée le dossier de travail à l'intérieur du conteneur
WORKDIR /usr/app/dbt

# On copie tout ton code SQL et tes configurations dans le conteneur
COPY . .

# On copie le fichier profiles.yml dans le dossier caché que dbt utilise par défaut
RUN mkdir -p /root/.dbt
COPY profiles.yml /root/.dbt/profiles.yml

# La commande par défaut qui s'exécutera quand le conteneur s'allumera sur AWS
CMD ["dbt", "run", "-t", "aws"]