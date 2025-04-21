# Jouons à Pong - TP N°3

## Description

Ce projet est une application mobile Flutter permettant de découvrir les films actuellement à l’affiche.
L’application consomme l’API publique TMDB (The Movie Database) pour afficher les films, leurs informations détaillées et permettre une recherche dynamique.

### L’utilisateur peut :
- Voir la liste des films à l’affiche
- Rechercher un film en temps réel via une barre de recherche
- Trier les films par note, date, titre (croissante ou décroissante)
- Accéder aux détails d’un film (résumé, affiche, note, date de sortie)

### Fonctionnalités principales :
- Intégration de l’API TMDB
- Affichage dynamique des films à l’affiche
- Barre de recherche réactive (mise à jour automatique à la saisie)
- Tri par note, date, titre (ascendant / descendant) 
- Fiche film avec image, description, note et date de sortie
- Interface simple, responsive et épurée

---

## Structure du projet

```env
├── lib/
│   ├── main.dart                   # Point d’entrée de l’application
│   ├── helpers/
│   │   └── http_helper.dart        # Gestion des requêtes HTTP vers l’API TMDB
│   ├── modeles/
│   │   └── film.dart               # Modèle de données Film
│   ├── pages/
│   │   ├── liste_films.dart        # Page d’accueil avec liste et recherche de films
│   │   └── detail_film.dart        # Page de détails d’un film sélectionné
├── pubspec.yaml                    # Dépendances et configuration Flutter                 # Dépendances et configuration Flutter
```
## Installation

1. **Clonez le projet** :

```bash
git clone https://github.com/EnideDj/allons_au_cinema_td5
```
2.	Installez les dépendances :
```bash
flutter pub get
```
3.	Exécutez l’application :
      Pour exécuter l’application sur un émulateur ou un appareil physique, utilisez la commande suivante :
```bash
flutter run
```

## ENIDE DJENDER - FISA-TI-27 - IMT NORD EUROPE
