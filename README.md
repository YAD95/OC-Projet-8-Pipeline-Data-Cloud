#  Architecture & Pipeline de Données Météorologiques - Cloud AWS

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

*   **Amazon EC2 :** C'est la machine virtuelle qui sert de point d'entrée. Je l'utilise pour héberger Airbyte et faire tourner toute l'ingestion des données.
*   **Amazon RDS (PostgreSQL) :** Notre Data Warehouse. C'est ici que tout atterrit et que sont stockées à la fois les données brutes et les tables finales nettoyées.
*   **AWS IAM :** Indispensable pour la sécurité. J'y ai configuré les rôles et les permissions de manière stricte pour que chaque service n'ait accès qu'à ce dont il a besoin.
*   **Amazon ECR :** L'espace de stockage sécurisé dans lequel je pousse l'image Docker contenant tout le code dbt.
*   **Amazon ECS (Fargate) :** Le moteur Serverless du projet. Il permet d'exécuter notre conteneur dbt uniquement quand c'est nécessaire pour faire les transformations, ce qui évite de payer un serveur qui tourne dans le vide.
*   **Amazon EventBridge :** (le planificateur) Je l'ai configuré pour déclencher tout le pipeline de manière automatique et quotidienne.
*   **Amazon CloudWatch :** Comme les conteneurs Fargate sont éphémères et disparaissent après le travail, j'utilise CloudWatch pour récupérer, centraliser et surveiller tous les logs d'exécution.

---

## Structure du Dépôt
Pour aller à l'essentiel, ce dépôt se concentre sur la logique de transformation et l'infrastructure :

*   `forecast_project/` : Contient tout le code source dbt (modèles SQL de staging et marts, tests de qualité de la donnée, configuration `dbt_project.yml`).
*   `assets/` : Contient une présentation visuelle des étapes du projet, le logigramme complet de l'infrastructure Cloud et les schémas architecturaux de la base de données.
*   `Dockerfile` & `docker-compose.yml` : Fichiers de configuration pour la conteneurisation du projet.
