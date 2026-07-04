# 🌦️ Pipeline Data Cloud : Prévisions Météo pour GreenAndCoop

## Contexte du projet

Les Data Scientists de l'entreprise **GreenAndCoop** ont besoin d'analyser des données météorologiques de qualité pour leurs modèles de prévision.
En tant que Data Engineer, mon travail consiste à leur fournir des données fiables, propres et exploitables.

**Le problème :** L'équipe data reçoit des données sources qui arrivent dans un format brut, non standardisé, et qui comportent des erreurs (données illisibles, non exploitables, valeurs aberrantes, doublons, etc.).

**La solution :** Créer une pipeline de données automatisé ("Zero-Touch") de bout en bout pour extraire, nettoyer et transformer ces données directement dans le Cloud (AWS) pour que les Data Scientists puissent disposer de données propres et exploitables pour leurs opérations. 



---

## Stack Technique & Étapes du Pipeline
Ce projet suit une architecture moderne de type ELT (Extract, Load, Transform) :

1. **Extraction & Chargement (Airbyte) :** Ingestion des données brutes depuis les sources vers la base de données.  
2. **Transformation & Qualité (dbt) :** Nettoyage des données sales, standardisation, tests de qualité (not null, unique, valeurs aberrantes) et création de tables (faits et dimensions) prêtes pour l'analyse.  
3. **Conteneurisation (Docker) :** Packaging du projet dbt via un `Dockerfile` pour le rendre portable et isoler l'environnement.  

---

## Architecture Cloud (AWS)
Le pipeline est entièrement déployé de manière automatisée et Serverless sur Amazon Web Services (AWS) :

*   **Amazon EC2 :** Serveur virtuel (machine cloud) utilisé pour héberger et exécuter l'outil d'ingestion Airbyte.
*   **Amazon RDS (PostgreSQL) :** Le Data Warehouse hébergeant les données brutes et les tables transformées.
*   **AWS IAM :** Gestion stricte des identités, création des rôles et des politiques de sécurité pour limiter les accès.
*   **Amazon ECR :** Registre privé sécurisé pour héberger l'image Docker contenant notre projet dbt.
*   **Amazon ECS (Fargate) :** Service Serverless utilisé pour exécuter le conteneur dbt uniquement lorsque c'est nécessaire, optimisant ainsi les coûts.
*   **Amazon EventBridge :** L'orchestrateur (cron) qui déclenche l'exécution quotidienne automatique du pipeline.
*   **Amazon CloudWatch :** Centralisation et persistance des logs d'exécution du conteneur éphémère pour faciliter le monitoring et le débogage.

---

## Structure du Dépôt
Pour aller à l'essentiel, ce dépôt se concentre sur la logique de transformation et l'infrastructure :

*   `forecast_project/` : Contient tout le code source dbt (modèles SQL de staging et marts, tests de qualité de la donnée, configuration `dbt_project.yml`).
*   `assets/` : Contient une présentation visuelle des étapes du projet, le logigramme complet de l'infrastructure Cloud et les schémas architecturaux de la base de données.
*   `Dockerfile` & `docker-compose.yml` : Fichiers de configuration pour la conteneurisation du projet.
