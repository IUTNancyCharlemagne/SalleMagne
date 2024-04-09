# Salle'Magne

## 🐸 Auteurs (La Voyelle)

- Bernardet Nicolas
- Holder Jules
- Despré Watisburger Julie
- Gromangin Clément
- Hergott Emilien
- Steelandt Jules
- Melbeck Nathan

---

## 📖 Description du Projet

L’IUT souhaite faciliter l’orientation des nouveaux étudiants dans les salles. Pour ce faire, elle
souhaite réaliser l’application Salle’Magne, afin de pouvoir plus facilement lister les salles et
leurs cours.
En indiquant un numéro de salle, l’application doit indiquer les cours de la salle (planning)
ainsi que l’étage auquel elle se situe. La saisie du numéro de salle peut se faire soit en
tapant le numéro de la salle, soit en prenant en photo la plaque du numéro de salle (qui se
trouve au-dessus de la porte).
Les salles préférées des étudiants pourront être mises en favori pour les retrouver plus
rapidement.
Si l’étudiant n’est pas présent géographiquement à l’IUT, l’application doit aider à ce que
l’étudiant s’y rende.
Cette application devra posséder deux facettes : une facette Web (Nuxt/SSR) et une facette
mobile (Flutter). Les deux facettes s’appuieront sur un backend commun.

---

## Lien en production sur docketu

- https://docketu.iutnc.univ-lorraine.fr:32498/

## ⚙️ Backend

### 📕 Description

Un backend commun sera réalisé pour les différentes fonctionnalités utilisées par les deux
facettes (web/mobile). Ce back-end s’occupera de centraliser les données des salles, les
plannings, et de faire la reconnaissance des numéros de salles sur les photos.

### 🔧 Technologies
- Node.js
- Express.js
- MariaDB
- Docker
- Adminer

---

## ✨ Frontend

### 📗 Description

Depuis un site Web responsive, réalisé avec Nuxt.JS, les étudiants doivent pouvoir consulter
le plan de l’IUT, avec les différentes salles et leur planning. Ils doivent pouvoir soit saisir un
numéro de salle, soit prendre en photo la plaque devant la salle afin de pouvoir indiquer à
l’application où il se trouve, et obtenir les informations de la salle
Une interface de recherche doit permettre de retrouver facilement des salles, ou des cours
directement.

### 🔧 Technologies

- Nuxt.js
- TailwindCSS
- Tesseract.js
- FullCanlendar.js
- Leaflet

---

## Mobile

### 📘 Description

Via une application mobile, réalisée avec Flutter, les fonctionnalités de la facette Web
doivent être repris. De la même manière donc, les étudiants doivent pouvoir consulter les
plannings des salles, saisir le numéro d’une salle ou prendre sa plaque en photo pour obtenir
le planning d’une salle en question.
Une interface de recherche doit permettre de retrouver facilement des salles ou des cours,
mettre une salle en favoris, ainsi que de permettre d’ajouter dans l’agenda du téléphone des
cours à venir.

### 🔧 Technologies

- Flutter
- Google ML Kit Text Recognition
- Sync Fusion Flutter Calendar

---

## 🚀 Installation et Déploiement

### Application Web

- Cloner le dépôt
````shell
git clone https://github.com/NicoRiri/RuMedrevilleBot.git
````

- Renommer le fichier `.env.example` en `.env`
````shell
mv .env.example .env
````

- Modifier les variables d'environnement dans le fichier `.env`
````dotenv
SECRET_KEY= # Clé secrète pour les tokens JWT
MYSQL_ROOT_PASSWORD= # Mot de passe root de la base de données
MYSQL_DATABASE= # Nom de la base de données
MYSQL_USER= # Nom d'utilisateur de la base de données
MYSQL_PASSWORD= # Mot de passe de l'utilisateur de la base de données
````

- Mettre les fichiers SSL dans le dossier `certificat`
````dotenv
certificat/
    ├── certificat.cer
    └── certificat.key
````

PS : Si il n'y a pas les fichiers SSL, la localisation dans l'application web ne pourra pas se faire.
Pour retirer les fichiers SSL, il faut :
- Supprimer dans nginx.conf

````nginx configuration
# SSL Settings
ssl_certificate     /etc/nginx/certificat/certificat.cer;
ssl_certificate_key /etc/nginx/certificat/certificat.key;
````

- Supprimer l'instruction SSL à coté du port

````nginx configuration
# Code avec SSL
server {
            listen 2498 ssl;
            server_name  docketu.iutnc.univ-lorraine.fr;

            location / {
                proxy_pass http://web:3000;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto https;
            }
    }
    
# Code sans SSL
server {
            listen 2498;
            server_name  docketu.iutnc.univ-lorraine.fr;

            location / {
                proxy_pass http://web:3000;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto https;
            }
    }
````


- Lancer les conteneurs Docker
````shell
docker compose up
````

## 📱 Application mobile

## Dépendances

- Flutter : https://flutter.dev/docs/get-started/install
- Dart : https://dart.dev/get-dart

````shell
cd salle_magne
````
````shell
flutter pub get
````
````shell
flutter run
````
