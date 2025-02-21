# Projet OpenData Transmusicales - Application Multi-plateforme

![Image home project](<img src="https://github.com/SachaFernandezSoltane/les_transmusicales/blob/main/display_readme.png?raw=true" width="300" height="200">)

<img src="https://github.com/SachaFernandezSoltane/les_transmusicales/blob/main/display_readme.png?raw=true" width="300" height="500">

## Description

Ce projet consiste à développer une application multi-plateforme (mobile et web) exploitant les données OpenData des Transmusicales. L'application permet aux utilisateurs d'explorer les artistes, de visualiser des informations géographiques sur une carte interactive, et d'accéder à des profils détaillés des artistes avec un historique de leurs performances.

## Fonctionnalités

### Fonctionnalités Obligatoires

- **Exploration des artistes** : Liste des artistes avec des détails.
- **Carte interactive** : Visualisation géographique des informations.
- **Profils détaillés** : Historique des performances pour chaque artiste.
- **Intégration API** : Contenus via Spotify et Deezer.
- **Fonctionnalités sociales** : Système de notation (1 à 5 étoiles) et commentaires.
- **Mode jour/nuit** : Personnalisation de l'interface utilisateur.

### Fonctionnalités Facultatives

- **Pagination et recherche** : Liste paginée avec recherche et filtres multicritères.
- **Galerie photos** : Upload et compression d'images par artiste.
- **Système de favoris** : Création de listes personnalisées.
- **Synchronisation des données** : Entre différents appareils.
- **Tests** : Unitaires, d'intégration et UI.

## Architecture Technique

L'application suit les principes de la Clean Architecture pour une organisation claire et maintenable du code.

### Choix Technologiques

- **Mobile (Android/iOS)** : Flutter
- **Web** : Flutter Web
- **Backend** : Firebase pour l'authentification, API REST pour les données OpenData

## Contraintes Techniques

- **Performance** : Gestion efficace des données volumineuses (2600+ entrées).
- **Qualité de code** : Linting strict, documentation, conventions de nommage.

## Livrables

- Code source propre et documenté
- Plan de tests (si option choisie)
- Présentation des choix techniques

## Critères d'Évaluation

- Respect de la Clean Architecture
- Qualité du code et architecture
- Performance de l'application
- UX/UI
- Créativité et fonctionnalités additionnelles
- Tests et documentation (si option choisie)

## Installation

Pour installer et exécuter l'application, suivez ces étapes :

1. Clonez le dépôt : `git clone <repository-url>`
2. Accédez au répertoire du projet : `cd <project-directory>`
3. Installez les dépendances : `flutter pub get`
4. Exécutez l'application : `flutter run`

## Contribution

Les contributions sont les bienvenues ! Veuillez ouvrir une issue ou soumettre une pull request pour toute amélioration ou correction de bug.

---
