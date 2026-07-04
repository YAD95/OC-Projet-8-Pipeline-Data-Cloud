#  Pipeline Data Cloud : Prévisions Météo pour GreenAndCoop

## --- Contexte du projet ---
L'entreprise **GreenAndCoop** a besoin d'analyser des données météorologiques pour optimiser ses opérations. 
**Le problème :** Les données sources arrivent dans un format brut, non standardisé, et comportent des erreurs (valeurs aberrantes, doublons).
**La solution :** Les Data Scientists ont besoin d'une donnée propre, fiable et prête à l'emploi. Ce projet consiste à créer un pipeline de données automatisé ("Zero-Touch") de bout en bout pour extraire, nettoyer et transformer ces données directement dans le Cloud.

---

## --- Stack Technique & Étapes du Pipeline ---
Ce projet suit une architecture moderne de type ELT (Extract, Load, Transform) :

1. **Extraction & Chargement (Airbyte) :** Ingestion des données brutes depuis les sources vers la base de données.
2. **Transformation & Qualité (dbt) :** Nettoyage des données sales, standardisation, tests de qualité (not null, unique, valeurs aberrantes) et création de tables prêtes pour l'analyse.
3. **Conteneurisation (Docker) :** Packaging du projet dbt via un `Dockerfile` pour le rendre portable et isoler l'environnement.

---

## --- Architecture Cloud (AWS) ---
Le pipeline est entièrement déployé de manière automatisée et Serverless sur Amazon Web Services (AWS) :

*   **Amazon RDS (PostgreSQL) :** Le Data Warehouse hébergeant les données brutes et les tables transformées.
*   **AWS IAM :** Gestion stricte des identités, création des rôles et des politiques de sécurité pour limiter les accès.
*   **Amazon ECR :** Registre privé sécurisé pour héberger l'image Docker contenant notre projet dbt.
*   **Amazon ECS (Fargate) :** Service Serverless utilisé pour exécuter le conteneur dbt uniquement lorsque c'est nécessaire, optimisant ainsi les coûts.
*   **Amazon EventBridge :** L'orchestrateur (cron) qui déclenche l'exécution quotidienne automatique du pipeline.
*   **Amazon CloudWatch :** Centralisation et persistance des logs d'exécution du conteneur éphémère pour faciliter le monitoring et le débogage.

---

## --- Structure du Dépôt ---
Pour aller à l'essentiel, ce dépôt se concentre sur la logique de transformation et l'infrastructure :

*   `forecast_project/` : Contient tout le code source dbt (modèles SQL de staging et marts, tests de qualité de la donnée, configuration `dbt_project.yml`).
*   `assets/` : Contient les schémas architecturaux de la base de données et le logigramme complet de l'infrastructure Cloud.
*   `Dockerfile` & `docker-compose.yml` : Fichiers de configuration pour la conteneurisation du projet.
